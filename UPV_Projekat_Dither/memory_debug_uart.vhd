library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory_debug_uart is
	generic (
		Atot : integer := 100000	--How many adresses to test, will take 
	);
	port (
		clk 	: in std_logic;
		reset 	: in std_logic;
		
		a_write, a_read : out std_logic_vector(21 downto 0);
		d_write			: out std_logic_vector(31 downto 0);
		d_read			: in std_logic_vector(31 downto 0) := (others => '1');
		btn				: in std_logic;
		w_complete		: in std_logic;
		r_complete		: in std_logic;
		
		uart_data		: out std_logic_vector(7 downto 0);
		uart_req			: out std_logic := '0';
		waiting : out std_logic;
		uart_busy 		: in std_logic
	);
end memory_debug_uart;

architecture behavioral of memory_debug_uart is
	type state_type is ( WAIT_BTN, WR_REQ, WAIT_WR, RD_RQ, WAIT_RD, UART_RQ, WAIT_UART);
	signal current_state, next_state : state_type := WAIT_BTN;
	signal addr_out 	: std_logic_vector(21 downto 0) := (others => '1');
	signal addr_rd 	: std_logic_vector(21 downto 0) := (others => '1');
begin

		
next_state_logic:	
	process (current_state, w_complete, r_complete, uart_busy, btn, addr_out, addr_rd) is
	begin
		next_state <= current_state;
		case (current_state) is
			when WAIT_BTN =>
				if (btn = '0') then
					next_state <= WR_REQ;
				else
					next_state <= WAIT_BTN;
				end if;
			when WR_REQ =>
				next_state <= WAIT_WR;
			when WAIT_WR =>
				if (w_complete = '1') then
					if (to_integer(unsigned(addr_out)) = Atot) then
						next_state <= RD_RQ;
			        else
						next_state <= WR_REQ;
					end if;
				else
					next_state <= WAIT_WR;
				end if;
			when RD_RQ =>
				next_state <= WAIT_RD;
			when WAIT_RD =>
				if (r_complete = '1') then
					next_state <= UART_RQ;
				else
					next_state <= WAIT_RD;
				end if;
			when UART_RQ =>
				if (uart_busy = '1') then
					next_state <= WAIT_UART;
				else
					next_state <= UART_RQ;
				end if;
			when WAIT_UART =>
				if (uart_busy = '1') then
					next_state <= WAIT_UART;
				else
					if (to_integer(unsigned(addr_rd)) = Atot) then
						next_state <= WAIT_BTN;
					else
						next_state <= RD_RQ;
					end if;
				end if;
			when others =>
		end case;		
	end process;
		
state_transition:
	process (reset, clk) is
	begin
		if (reset = '1') then
			current_state <= WAIT_BTN;
			addr_out <= (others => '1');
			addr_rd <= (others => '1');
		elsif (rising_edge(clk)) then
			current_state <= next_state;
			if (next_state = WR_REQ) then
				addr_out <= std_logic_vector(unsigned(addr_out) + 1);
			end if;	
			if (next_state = RD_RQ) then
				addr_rd <= std_logic_vector(unsigned(addr_rd) + 1);
			end if;
			if (next_state = WAIT_BTN) then
				addr_rd <= (others => '1');
				addr_out <= (others => '1');
			end if;
		end if;	
	end process;
	a_write <= addr_out;
	a_read	<= addr_rd;
	d_write <= ((not addr_out(15 downto 0)) & addr_out(15 downto 0)); --Very much todo
	uart_data <= d_read(15 downto 8);
output_logic:
	process (current_state) is
	begin
		if (current_state = UART_RQ) then
			uart_req <= '1';
		else
			uart_req <= '0';
		end if;
	end process;
	
	waiting <= '1' when current_state = WAIT_BTN else '0';
end behavioral;