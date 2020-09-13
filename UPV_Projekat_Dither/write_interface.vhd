library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity write_interface is

	port
	(
		din : in std_logic_vector(2 downto 0);
		adr : in std_logic_vector(18 downto 0); --307200 pix -> 19 bits needed
		w_e : in std_logic;
		vsync:in std_logic;
		clk : in std_logic;
		finished_frame : out std_logic_vector(1 downto 0);
		reset : in std_logic;
		address_out:	out std_logic_vector(21 downto 0);
		data_out : out std_logic_vector(15 downto 0)
 	);
end write_interface;

architecture write_interface_arch of write_interface is

	type state_type is ( WAIT_FRAME, IDLE, WRT, WRT_LATCH );
	
	signal current_state, next_state : state_type := WAIT_FRAME;
	signal data_buf: std_logic_vector(11 downto 0) := (others => '0');
	signal data_latch : std_logic_vector(11 downto 0) := (others => '0');
	signal address_buf : std_logic_vector(21 downto 0) := (others => '0');
	signal address_latch : std_logic_vector(21 downto 0) := (others => '0');
	signal current_frame : std_logic_vector(1 downto 0) := "00";
	signal new_address : std_logic;
	
begin
	
	address_out <= address_latch;
	
	data_out <= "0000" & data_latch;
	
	new_address <= '0' when (address_buf(16 downto 0) = adr(18 downto 2)) else '1';
	
next_state_logic:
	process ( current_state, vsync, w_e, new_address) is
	begin
		case (current_state) is
			when WAIT_FRAME =>
				if (vsync = '1') then
					next_state <= WAIT_FRAME;
				else
					next_state <= IDLE;
				end if;
			when IDLE =>
				if (w_e = '1') then
					if (new_address = '1') then
						next_state <= WRT_LATCH;
					else
						next_state <= WRT;
					end if;
				elsif (vsync = '1') then
					next_state <= WAIT_FRAME;
				else
					next_state <= IDLE;
				end if;
			when WRT | WRT_LATCH =>
				next_state <= IDLE;
		end case;
	end process;
	
state_transition:
	process (clk, reset) is
	begin
		if (reset = '1') then
			current_state <= WAIT_FRAME;
			current_frame <= "00";
			data_buf <= (others => '0');
			data_latch <= (others => '0');
			address_buf <= (others => '0');
			address_latch <= (others => '0');
			finished_frame <= "00";
		elsif (rising_edge(clk)) then
			current_state <= next_state;
			case (next_state) is
				when WAIT_FRAME =>
					if (current_state = IDLE) then
						finished_frame <= current_frame;
						current_frame <= std_logic_vector(unsigned(current_frame)+ "01");
					end if;
				when WRT =>
					case (adr(1 downto 0)) is
						when "00" =>
							data_buf(2 downto 0) <= din;
						when "01" =>
							data_buf(5 downto 3) <= din;
						when "10" =>
							data_buf(8 downto 6) <= din;
						when "11" =>
							data_buf(11 downto 9) <= din;
						when others =>
					end case;
				when WRT_LATCH	=>
					--data_buf <= data_buf;
					case (adr(1 downto 0)) is
						when "00" =>
							data_buf(2 downto 0) <= din;
						when "01" =>
							data_buf(5 downto 3) <= din;
						when "10" =>
							data_buf(8 downto 6) <= din;
						when "11" =>
							data_buf(11 downto 9) <= din;
						when others =>
					end case;
					address_latch <= address_buf;
					address_buf <= (others => '0'); --Just reset bytes
					address_buf(21 downto 20) <= current_frame;
					address_buf(16 downto 0) <= adr(18 downto 2);
					data_latch <= data_buf;
				when others =>
			end case;
		end if;
	end process;
	
	
end write_interface_arch;
