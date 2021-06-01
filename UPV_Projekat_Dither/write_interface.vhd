library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity write_interface is
	generic
	(
		NUM_BYTES : integer := 8
	);
	port
	(
		clk : in std_logic;
		reset : in std_logic;
		valid : in std_logic;
		data_in : in std_logic_vector(2 downto 0);
		data_out : out std_logic_vector(8 * NUM_BYTES - 1 downto 0);
		wr_req : out std_logic;
		vsync : in std_logic
 	);
end write_interface;

architecture write_interface_arch of write_interface is

	type state_type is (WAIT_DATA, LATCH_DATA);
	
	signal current_state, next_state : state_type;
	signal next_data_out, data_out_tmp : std_logic_vector(8 * NUM_BYTES - 1 downto 0);
	signal next_wr_req : std_logic;
	signal next_local_adr, local_adr : integer range 0 to 2 * NUM_BYTES;
begin

next_state_logic:
	process (current_state, local_adr, data_out_tmp, data_in, vsync, valid) is
	begin
		next_wr_req <= '0';
		next_state <= current_state;
		next_local_adr <= local_adr;
		next_data_out <= data_out_tmp;
		if (vsync = '0') then
			if (valid = '1') then
				next_state <= LATCH_DATA;
				next_data_out(local_adr * 4 + 2 downto local_adr * 4) <= data_in;
				if (local_adr = NUM_BYTES * 2 - 1) then
					next_local_adr <= 0;
					next_wr_req <= '1';
				else
					next_local_adr <= local_adr + 1;
				end if;
			else
				next_state <= WAIT_DATA;
			end if;
		else
			next_state <= WAIT_DATA;
			next_local_adr <= 0;
		end if;
	end process;
	
state_transition:
	process (clk, reset) is
	begin
		if (reset = '1') then
			data_out_tmp <= (others => '0');
			current_state <= WAIT_DATA;
			wr_req <= '0';
			local_adr <= 0;
		elsif (rising_edge(clk)) then 
			data_out_tmp <= next_data_out;
			current_state <= next_state;
			wr_req <= next_wr_req;
			local_adr <= next_local_adr;
		end if;
	end process;
	
	data_out <= data_out_tmp;
	
end write_interface_arch;
