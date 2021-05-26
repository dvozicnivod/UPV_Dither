library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;

--TODO, possibly check adress with xpos, ypos to make sure reading correct location

entity read_interface is
	generic
	(
		FRAME_WIDTH : integer := 640;
		NUM_BYTES : integer := 4;
	constant ADDRESS_WIDTH : integer := 19
	);
	port
	(
		clk : in std_logic;
		reset : in std_logic;
		xpos : in std_logic_vector(9 downto 0); 
		ypos : in std_logic_vector(8 downto 0);
		valid : in std_logic;
		v_sync : in std_logic;
		read_address : out std_logic_vector(ADDRESS_WIDTH-1 downto 0);
		read_data : in std_logic_vector(NUM_BYTES*8-1 downto 0);
		data_out : out std_logic_vector(2 downto 0)
 	);
end read_interface;

architecture read_interface_arch of read_interface is
	
	type state_type is ( SETUP_FRAME, LATCH, DATA, WAIT_ROW );

	constant LA_BITS : integer := INTEGER(CEIL(LOG2(REAL(NUM_BYTES*4))));
	
	signal current_state, next_state : state_type;
	signal data_cnt, next_data_cnt : unsigned(5 downto 0); 
	signal data_buffer, next_data_buffer : std_logic_vector(NUM_BYTES*8-1 downto 0);
	signal serving_address, next_serving_address, calculated_address : std_logic_vector(ADDRESS_WIDTH-1 downto 0);
	signal tmp_data_out, next_data_out : std_logic_vector(2 downto 0);
	signal local_address : std_logic_vector(LA_BITS-1 downto 0);
	signal ram_address : std_logic_vector(ADDRESS_WIDTH-1 downto 2);
	signal tmp_read_address, next_read_address : unsigned(ADDRESS_WIDTH-1 downto 0);
	
begin



	
	calculated_address <= (calculated_address'length -1  downto 19 => '0') & std_logic_vector( to_unsigned(FRAME_WIDTH,10) * unsigned(ypos) + unsigned(xpos) );
	
	
	local_address <= calculated_address(LA_BITS-1 downto 0);
	ram_address <= calculated_address(ADDRESS_WIDTH-1 downto 2); --MORA DA SE PROVERI STA ZNACI ADRESIRANJE U 16 bitnom modu!!! 
	
	
	
--data_cnt
-- uvek 3 bita
-- LA->D1 [0-1]  data[0] buffer[4*0+2:4*0]  2:0
-- D1->D2 [1-2]  data[1] buffer[4*1+2:4*1]  6:4
-- D2->D3 [2-3]  data[2] buffer[4*2+2:4*2]	10:8
-- D3->LA [3-0]  data[3]  
--
--
next_state_logic:
	process (current_state, data_cnt, data_buffer, serving_address, tmp_data_out, v_sync, valid, local_address, tmp_read_address, read_data) is
	begin
		next_state <= current_state;
		next_data_cnt <= data_cnt;
		next_data_buffer <= data_buffer;
		next_serving_address <= serving_address;
		next_read_address <= tmp_read_address;
		next_data_out <= tmp_data_out;
		case (current_state) is
			when SETUP_FRAME =>
				if (v_sync = '1') then
					next_state <=  SETUP_FRAME;
				else
					next_state <=  WAIT_ROW;
					next_data_buffer <= read_data;
					next_serving_address <= std_logic_vector(tmp_read_address);
					next_read_address <= to_unsigned(NUM_BYTES / 2, ADDRESS_WIDTH);
				end if;
			when LATCH =>
				if (valid = '1') then
					next_data_out <= data_buffer(4*to_integer(data_cnt)+2 downto 4*to_integer(data_cnt));
					next_state <= DATA;
					next_data_cnt <= to_unsigned(1,6);
				else
					next_state <= WAIT_ROW;
				end if;				
			when DATA =>
				if (data_cnt = to_unsigned(NUM_BYTES * 2 - 1, LA_BITS)) then
					next_data_out <= data_buffer(4*to_integer(data_cnt)+2 downto 4*to_integer(data_cnt)); 
					next_state <= LATCH;
					next_data_buffer <= read_data;
					next_serving_address <= std_logic_vector(tmp_read_address);
					next_data_cnt <= to_unsigned(0,6);
					next_read_address <= tmp_read_address + NUM_BYTES / 2;
				else
					next_data_out <= data_buffer(4*to_integer(data_cnt)+2 downto 4*to_integer(data_cnt)); 
					next_state <= DATA;
					next_data_cnt <= data_cnt + to_unsigned(1,6);
				end if;
			when WAIT_ROW =>
				if (v_sync = '1') then
					next_state <= SETUP_FRAME;
					next_read_address <= to_unsigned(0, ADDRESS_WIDTH);
				elsif (valid = '1') then
					next_state <= DATA;
					next_data_cnt <= to_unsigned(1,6);
					next_data_out <= data_buffer(4*to_integer(data_cnt)+2 downto 4*to_integer(data_cnt)); --U ovom slucaju uvek cnt 0
				else
					next_state <= WAIT_ROW;
				end if;
		end case;
	end process;

state_transition:
	process ( clk, reset ) is
	begin
		if (reset = '1') then
			current_state <= WAIT_ROW;
			data_cnt <= to_unsigned(0,6);			--DON'T CARE
			data_buffer <= next_data_buffer;
			serving_address <= std_logic_vector(to_unsigned(0,ADDRESS_WIDTH)); --DON'T CARE
			tmp_read_address <= (others => '0');
			tmp_data_out <= (others => '0');
		elsif (rising_edge(clk)) then
			current_state <= next_state;
			data_cnt <= next_data_cnt;
			data_buffer <= next_data_buffer;
			serving_address <= next_serving_address;
			tmp_read_address <= next_read_address;
			tmp_data_out <= next_data_out;
		end if;
	end process;
	
	data_out <= tmp_data_out;
	read_address <= std_logic_vector(tmp_read_address);
	
end read_interface_arch;
