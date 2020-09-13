library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cam_mem_uart is
	generic (
		NUM_PXS :integer :=  640 * 480
	);
	port (
		clk 	: in std_logic;
		reset 	: in std_logic;
		button 	: in std_logic;
		tx_busy	: in std_logic;
		tx_en	: out std_logic;
		adr		: out std_logic_vector(18 downto 0)		
	);
end cam_mem_uart;

architecture behavioral of cam_mem_uart is

	type state_type is ( HOLD, INC, TX, BUTTON_WAIT);
	signal current_state, next_state : state_type := BUTTON_WAIT;
	signal A : integer range 0 to NUM_PXS;
begin
		
next_state_logic:	
	process (current_state, tx_busy, button, A) is
	begin
		case (current_state) is
			when BUTTON_WAIT =>
				if (button = '1') then
					next_state <= INC;
				else
					next_state <= BUTTON_WAIT;
				end if;
			when HOLD =>
				if (tx_busy = '1') then
					next_state <= HOLD;
				elsif (A = NUM_PXS - 1) then
					next_state <= BUTTON_WAIT;
				else 
					next_state <= INC;
				end if;
			when INC =>
				next_state <= TX;
			when TX =>
				if (tx_busy = '0') then
					next_state <= TX;
				else
					next_state <= HOLD;
				end if;
			end case;		
	end process;
	
	tx_en  	<= '1' when current_state = TX else '0';
	adr 	<= std_logic_vector(to_unsigned(A,19));
	
state_transition:
	process (reset, clk) is
	begin
		if (reset = '1') then
			current_state <= BUTTON_WAIT;
		elsif (rising_edge(clk)) then
			current_state <= next_state;
			if ((next_state = INC) and (current_state = HOLD)) then
				A <= A + 1;
			elsif(next_state = BUTTON_WAIT) then
				A <= 0;
			end if;	
		end if;	
	end process;	
	
end behavioral;