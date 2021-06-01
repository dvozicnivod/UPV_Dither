library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;

--TODO, possibly check adress with xpos, ypos to make sure reading correct location

entity read_interface is
	generic
	(
		NUM_BYTES : integer := 4
	);
	port
	(
		clk : in std_logic;
		reset : in std_logic;
		valid : in std_logic;
		data_in : in std_logic_vector(8 * NUM_BYTES - 1 downto 0);
		data_out : out std_logic_vector(2 downto 0);
		rd_req : out std_logic;
		vsync : in std_logic
 	);
end read_interface;

architecture read_interface_arch of read_interface is
	constant SETUP_CYCLES : integer  := 20;
	type state_type is ( WAIT_DATA, LATCH_DATA, SETUP_BUFFER);
	signal current_state, next_state : state_type;
	signal setup_cnt, next_setup_cnt : integer range 0 to SETUP_CYCLES + 1; 
	signal next_local_adr, local_adr : integer range 0 to 2 * NUM_BYTES;
	signal next_data_out, data_out_tmp : std_logic_vector(2 downto 0);
	signal data_buffer, next_data_buffer : std_logic_vector(8 * NUM_BYTES - 1 downto 0);
	signal next_rd_req : std_logic;
begin
	
next_state_logic: process (current_state, data_out_tmp, vsync, valid, local_adr, data_buffer, data_in, setup_cnt) is
	begin
		next_local_adr <= local_adr;
		next_state <= current_state;
		next_rd_req <= '0';
		next_data_out <= data_out_tmp;
		next_setup_cnt <= 0;
		next_data_buffer <= data_buffer;
		if (vsync = '0') then
			case (current_state) is
				when WAIT_DATA =>
					if (valid = '1') then
						next_state <= LATCH_DATA;
						next_data_out <= data_buffer(local_adr * 4 + 2 downto local_adr * 4);
						if (local_adr = NUM_BYTES * 2 - 1) then
							next_data_buffer <= data_in;
							next_local_adr <= 0;
							next_rd_req <= '1';
						else
							next_local_adr <= local_adr + 1;
						end if;
					else
						next_state <= WAIT_DATA;
					end if;
				when LATCH_DATA =>
					if (valid = '1') then
						next_state <= LATCH_DATA;
						next_data_out <= data_buffer(local_adr * 4 + 2 downto local_adr * 4);
						if (local_adr = NUM_BYTES * 2 - 1) then
							next_data_buffer <= data_in;
							next_local_adr <= 0;
							next_rd_req <= '1';
						else
							next_local_adr <= local_adr + 1;
						end if;
					else
						next_state <= WAIT_DATA;
					end if;
				when SETUP_BUFFER =>
					next_local_adr <= 0;
					if (setup_cnt < SETUP_CYCLES) then
						next_setup_cnt <= setup_cnt + 1;
						next_state <= SETUP_BUFFER;
					else
						next_state <= WAIT_DATA;
						next_data_buffer <= data_in;
						next_rd_req <= '1';
					end if;
			end case;
		else
			next_state <= SETUP_BUFFER; 
		end if;
	end process;
	
state_transition_process: process(reset, clk) is
	begin
		if (reset = '1') then
			current_state <= SETUP_BUFFER;
			rd_req <= '0';
			data_out_tmp <= (others => '0');
			setup_cnt <= 0;
			data_buffer <= (others => '0');
			local_adr <= 0;
		elsif (rising_edge(clk)) then
			local_adr <= next_local_adr;
			current_state <= next_state;
			rd_req <= next_rd_req;
			data_out_tmp <= next_data_out;
			setup_cnt <= next_setup_cnt;
			data_buffer <= next_data_buffer;
		end if;
	end process;
	data_out <= data_out_tmp;
	
end read_interface_arch;
