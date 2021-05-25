library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory_debug_uart_b4 is
	generic (
		Atot : integer := 100000	--How many adresses to test, will take 
	);
	port (
		clk 	: in std_logic;
		reset 	: in std_logic;
		
		a_write, a_read : out std_logic_vector(21 downto 0);
		d_write			: out std_logic_vector(63 downto 0);
		d_read			: in std_logic_vector(63 downto 0) := (others => '1');
		btn				: in std_logic_vector(3 downto 0);
		w_complete		: in std_logic;
		r_complete		: in std_logic;
		
		tx_data			: out std_logic_vector(7 downto 0);
		tx_req			: out std_logic := '0';
		waiting 		: out std_logic;
		tx_busy 		: in std_logic;
		rx_data			: in std_logic_vector(7 downto 0);
		rx_busy 		: in std_logic
	);
end memory_debug_uart_b4;

architecture behavioral of memory_debug_uart_b4 is
	type state_type is ( WAIT_RX_BUSY, WAIT_RX_DATA, WR_REQ, WAIT_WR, RD_RQ, WAIT_RD, UART_RQ, WAIT_UART);
	signal current_state, next_state : state_type ;
	signal addr_out 	: std_logic_vector(21 downto 0) := (others => '1');
	signal addr_rd 	: std_logic_vector(21 downto 0) := (others => '1');
	signal channel		: integer range 0 to 7 := 0;
begin

		
next_state_logic:	
	process (current_state, w_complete, r_complete, tx_busy, btn, addr_out, addr_rd) is
	begin
		next_state <= current_state;
		case (current_state) is
			when WAIT_RX_BUSY =>
				if (rx_busy = '1') then
					next_state <= WAIT_RX_DATA;
				else
					next_state <= WAIT_RX_BUSY;
				end if;
			when WAIT_RX_DATA =>
				if (rx_busy = '0') then
					next_state <= WR_REQ;
				else
					next_state <= WAIT_RX_DATA;
				end if;
			when WR_REQ =>
				next_state <= WAIT_WR;
			when WAIT_WR =>
				if (w_complete = '1') then
					if (to_integer(unsigned(addr_out)) >= Atot) then
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
				if (tx_busy = '1') then
					next_state <= WAIT_UART;
				else
					next_state <= UART_RQ;
				end if;
			when WAIT_UART =>
				if (tx_busy = '1') then
					next_state <= WAIT_UART;
				else
					if (to_integer(unsigned(addr_rd)) >= Atot) then
						next_state <= WAIT_RX_BUSY;
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
			current_state <= WAIT_RX_BUSY;
			addr_out <= (others => '1');
			addr_rd <= (others => '1');
		elsif (rising_edge(clk)) then
			current_state <= next_state;
			if (next_state = WR_REQ) then
				if (current_state = WAIT_RX_DATA) then
					if (rx_data(0) = '1') then
						channel <= 0;
					elsif (rx_data(1) = '1') then
						channel <= 1;
					elsif (rx_data(2) = '1') then
						channel <= 2;
					elsif (rx_data(3) = '1') then
						channel <= 3;
					elsif (rx_data(4) = '1') then
						channel <= 4;
					elsif (rx_data(5) = '1') then
						channel <= 5;
					elsif (rx_data(6) = '1') then
						channel <= 6;
					elsif (rx_data(7) = '1') then
						channel <= 7;
					else
						channel <= 0;
					end if;
				end if;
				addr_out <= std_logic_vector(unsigned(addr_out) + 4);
			end if;	
			if (next_state = RD_RQ) then
				addr_rd <= std_logic_vector(unsigned(addr_rd) + 4);
			end if;
			if (next_state = WAIT_RX_BUSY) then
				addr_rd <= (others => '1');
				addr_out <= (others => '1');
			end if;
		end if;	
	end process;
	a_write <= addr_out;
	a_read	<= addr_rd;
	d_write(63 downto 56) <= addr_out(7 downto  0);
	d_write(55 downto 48) <= addr_out(8 downto  1);
	d_write(47 downto 40) <= addr_out(9 downto  2); --Very much todo
	d_write(39 downto 32) <= addr_out(10 downto 3); --Very much todo
	d_write(31 downto 24) <= addr_out(11 downto 4);
	d_write(23 downto 16) <= addr_out(12 downto 5);
	d_write(15 downto 8)  <= addr_out(13 downto 6); --Very much todo
	d_write(7 downto 0)   <= addr_out(14 downto 7); --Very much todo
	
	--uart_data <= d_read(7 downto 0);	
   --uart_data <= std_logic_vector(to_unsigned(channel,8));
	
output_logic:
	process (current_state, channel) is
	begin
		if (current_state = UART_RQ) then
			tx_req <= '1';
		else
			tx_req <= '0';
		end if;		
		case (channel) is
			when 0 => 
				tx_data <= d_read(7 downto 0);
			when 1 =>
				tx_data <= d_read(15 downto 8);
			when 2 =>
				tx_data <= d_read(23 downto 16);
			when 3 =>
				tx_data <= d_read(31 downto 24);
			when 4 => 
				tx_data <= d_read(39 downto 32);
			when 5 =>
				tx_data <= d_read(47 downto 40);
			when 6 =>
				tx_data <= d_read(55 downto 48);
			when 7 =>
				tx_data <= d_read(63 downto 56);
		end case;
	end process;

	waiting <= '1' when current_state = WAIT_RX_BUSY else '0';
end behavioral;