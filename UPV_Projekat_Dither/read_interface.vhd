library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity read_interface is

	port
	(
		dout : out std_logic_vector(2 downto 0);
		adr : in std_logic_vector(18 downto 0); --307200 pix -> 19 bits needed
		finished_frame : in std_logic_vector(1 downto 0);
		vsync:in std_logic;		--carefull, vsync is inverted here, pulses are 0
		clk : in std_logic;
		reset : in std_logic;
		address_out:	out std_logic_vector(21 downto 0);
		data_in : in std_logic_vector(15 downto 0)
 	);
end read_interface;

architecture read_interface_arch of read_interface is

	type state_type is ( WAIT_FRAME, RD, RD_REFRESH );
	
	signal current_state, next_state : state_type := WAIT_FRAME;
	signal data_buf: std_logic_vector(11 downto 0) := (others => '0');
	signal address_buf : std_logic_vector(21 downto 0) := (others => '0');
	signal address_latch : std_logic_vector(21 downto 0) := (others => '0');
	signal current_frame : std_logic_vector(1 downto 0) := "00";
	signal new_address : std_logic;
	
begin
		
	new_address <= '0' when (address_buf(16 downto 0) = adr(18 downto 2)) else '1';
	
	address_out <= address_latch;
	
next_state_logic:
	process ( current_state , new_address, vsync) is
	begin
		if (vsync = '0') then
			next_state <= WAIT_FRAME;
		elsif (new_address = '1') then
			next_state <= RD_REFRESH;
		else
			next_state <= RD;
		end if;
	end process;

state_transition:
	process (clk, reset) is
	begin
		if (reset = '1') then
			current_state <= WAIT_FRAME;
			current_frame <= "00";
			data_buf <= (others => '0');
			address_buf <= (others => '0');
			address_latch <= (others => '0');
			dout <= "000";
		elsif (rising_edge(clk)) then
			current_state <= next_state;
			case (next_state) is
				when WAIT_FRAME =>
					if not (current_state = WAIT_FRAME) then
						address_latch(21 downto 20) <= finished_frame;
						address_latch(16 downto 0) <= (others => '0');
						current_frame <= finished_frame;
						data_buf <= data_in(11 downto 0);
					end if;
					dout <= "000";
				when RD =>
					case (adr(1 downto 0)) is
						when "00" =>
							dout <= data_buf(2 downto 0);
						when "01" =>
							dout <= data_buf(5 downto 3);
						when "10" =>
							dout <= data_buf(8 downto 6);
						when "11" =>
							dout <= data_buf(11 downto 9);
						when others =>
					end case;
				when RD_REFRESH =>
					case (adr(1 downto 0)) is
						when "00" =>
							dout <= data_in(2 downto 0);
						when "01" =>
							dout <= data_in(5 downto 3);
						when "10" =>
							dout <= data_in(8 downto 6);
						when "11" =>
							dout <= data_in(11 downto 9);
						when others =>
					end case;
					address_buf <= address_latch;
					address_latch <= (others => '0');
					address_latch(21 downto 20) <= current_frame;
					address_latch(16 downto 0) <= std_logic_vector(unsigned(adr(18 downto 2)) + "1"); --hope this works
					data_buf <= data_in(11 downto 0);
			end case;					
		end if;
	end process;
	
end read_interface_arch;
