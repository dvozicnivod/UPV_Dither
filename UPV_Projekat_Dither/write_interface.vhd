library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity write_interface is
	generic
	(
		FRAME_WIDTH : integer := 640;
		NUM_BYTES : integer := 2
	);
	port
	(
		clk : in std_logic;
		reset : in std_logic;
		valid : in std_logic;
		data_in : in std_logic_vector(2 downto 0);
		xpos : in std_logic_vector(9 downto 0); 
		ypos : in std_logic_vector(8 downto 0);
		address_out : out std_logic_vector(18 downto 0); --307200 pix -> 19 bits needed
		data_out : out std_logic_vector(8 * NUM_BYTES - 1 downto 0)
 	);
end write_interface;

architecture write_interface_arch of write_interface is

	type state_type is (WAIT_DATA, ACCUMULATE_DATA, LATCH_OUT);
	
	signal current_state, next_state : state_type := WAIT_DATA;
	signal next_data_buffer, data_buffer, next_data_out, data_out_tmp: std_logic_vector( NUM_BYTES * 8 - 1 downto 0);
	signal next_data_cnt, data_cnt: unsigned(5 downto 0);	--Maks broj bajtova je 2*8 tj treba da moze da se predstavi 16, znaci treba nam 5 bitova
	signal calculated_address, next_address, current_address, next_address_out, address_out_tmp: std_logic_vector(18 downto 0);

	
begin

	calculated_address <= std_logic_vector( to_unsigned(FRAME_WIDTH,10) * unsigned(ypos) + unsigned(xpos) );

next_state_logic:
	process (current_state, valid, data_cnt, data_buffer, current_address, data_out_tmp, address_out_tmp, calculated_address, data_in) is
	begin
		next_state <= current_state;
		next_data_buffer <= data_buffer;
		next_data_cnt <= data_cnt;
		next_address <= current_address;
		next_data_out <= data_out_tmp;
		next_address_out <= address_out_tmp;
		case (current_state) is
			when WAIT_DATA =>
				if (valid = '1') then
					next_state <= ACCUMULATE_DATA;
					next_data_cnt <= to_unsigned(1,6); --Stigao prvi deo info
					next_address <= calculated_address;
					next_data_buffer(2 downto 0) <= data_in;
				else
					next_state <= WAIT_DATA;
				end if;
			when ACCUMULATE_DATA =>
				if (valid = '1') then
					if (data_cnt = NUM_BYTES * 2) then
						next_data_out <= data_buffer;
						next_address_out <= current_address;
						next_state <= LATCH_OUT;
					else
						next_data_cnt <= data_cnt + 1;
						next_state <= ACCUMULATE_DATA;
						next_data_buffer((to_integer(data_cnt)*4+2) downto to_integer(data_cnt)*4) <= data_in;
					end if;
				else
					next_state <= ACCUMULATE_DATA;
				end if;
			when LATCH_OUT =>
				next_data_cnt <= (others => '0');
				next_state <= WAIT_DATA;
		end case;
	end process;
	
state_transition:
	process (clk, reset) is
	begin
		if (reset = '1') then
			current_state <= WAIT_DATA;
			data_buffer <= (others => '0');
			data_cnt <= (others => '0');
			current_address <= (others => '0');
			data_out_tmp <= (others => '0');
			address_out_tmp <= (others => '0');
		elsif (rising_edge(clk)) then 
			current_state <= next_state;
			data_buffer <= next_data_buffer;
			data_cnt <= next_data_cnt;
			current_address <= next_address;
			data_out_tmp <= next_data_out;
			address_out_tmp <= next_address_out;
		end if;
	end process;
	
	address_out <= address_out_tmp;
	data_out <= data_out_tmp;	
	
end write_interface_arch;
