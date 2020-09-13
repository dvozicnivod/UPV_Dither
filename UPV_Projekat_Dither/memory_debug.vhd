library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory_debug is
	port (
		clk 	: in std_logic;
		reset 	: in std_logic;
		
		a_write, a_read : out std_logic_vector(21 downto 0);
		d_write			: out std_logic_vector(15 downto 0);
		d_read			: in std_logic_vector(15 downto 0);
		
		w_complete		: in std_logic;
		r_complete		: in std_logic;
		
		equals 			: out std_logic;
		equals_valid	: out std_logic

	);
end memory_debug;

architecture behavioral of memory_debug is

	type state_type is ( D_WR, A_WR, WAIT_WR, A_RD, WAIT_RD, D_RD);
	signal current_state, next_state : state_type := D_WR;
	signal data 	: std_logic_vector(15 downto 0) := X"AA55";
	signal address 	: std_logic_vector(21 downto 0) := (others => '0');
	
begin
		
next_state_logic:	
	process (current_state, w_complete, r_complete) is
	begin
		case (current_state) is
			when D_WR =>
				next_state <= A_WR;
			when A_WR =>
				next_state <= WAIT_WR;
			when WAIT_WR =>
				if (w_complete = '1') then
					next_state <= A_RD;
				else
					next_state <= WAIT_WR;
				end if;
			when A_RD =>
				next_state <= WAIT_RD;
			when WAIT_RD =>
				if (r_complete = '1') then
					next_state <= D_RD;
				else
					next_state <= WAIT_RD;
				end if;
			when D_RD =>
				next_state <= D_WR;
		end case;		
	end process;
	
state_transition:
	process (reset, clk) is
	begin
		if (reset = '1') then
			current_state <= D_WR;
			data <= X"AA55";
			address <= (others => '0');
		elsif (rising_edge(clk)) then
			current_state <= next_state;
			if (next_state = D_WR) then
				address <= std_logic_vector(unsigned(address)+1);
				data <= (data(14 downto 0) & (data(15) xor data (12) xor data(9)));	--fibonacci lfsr
			end if;	
			if (next_state = A_WR) then
				a_write <= address;
			end if;
			if (next_state = A_RD) then
				a_read <= address;
			end if;			
		end if;	
	end process;	
	
	d_write <= data;
	
output_logic:
	process (current_state, data, d_read) is
	begin
		equals <= '0';
		equals_valid <= '0';
		if (current_state = D_RD) then
			equals_valid <= '1';
			if (data = d_read) then
				equals <='1';
			end if;
		end if;
	end process;
	
end behavioral;