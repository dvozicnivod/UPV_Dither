library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cam_ctr is

	port
	(
		reset : in	std_logic;
		clk : in std_logic;	--Needs a clock of <770KHz
		S_C, S_D : out std_logic;
		busy : out std_logic
	);
end cam_ctr;


architecture cam_ctr_arch of cam_ctr is
	type state_type is ( SETTLE, IDLE, STARTBIT1, STARTBIT2, DATABIT, CUP, CDOWN, STOPBIT1, STOPBIT2);
	constant COUNT_TO : integer :=1000;
	signal count : integer range 0 to COUNT_TO+1 := 0;
	signal current_state, next_state : state_type := SETTLE;
	signal current_cmd_index : integer range 0 to 127 := 0;
	signal bits_left : integer range 0 to 27 := 0;
	signal data_out : std_logic_vector (26 downto 0) := (others => '0');
	signal current_command : std_logic_vector(15 downto 0);
	
	constant CAMERA_ID : std_logic_vector (7 downto 0) := X"42";
--	constant COM7_ADR : std_logic_vector (7 downto 0) := X"12";
--	constant COM15_ADR : std_logic_vector (7 downto 0) := X"40";
--	constant RGB444_ADR : std_logic_vector (7 downto 0) := X"8C";
--	constant COM7_RESET_CMD : std_logic_vector (7 downto 0) := X"80";
--	constant COM7_RGB_CMD : std_logic_vector (7 downto 0) := X"06";--was 04
--	constant COM15_RGB555_CMD : std_logic_vector (7 downto 0) := X"30";
--	constant RGB444_CMD : std_logic_vector (7 downto 0) := X"00";
--	constant COLORBAR_ADR : std_logic_vector (7 downto 0) := X"71";
--	constant COLORBAR_CMD : std_logic_vector (7 downto 0) := x"C0";
	
begin
	
next_state_logic: 
	process (current_state, bits_left, count, current_cmd_index,current_command) is
	begin
		next_state <= current_state;
		case (current_state) is
			when SETTLE =>
				if (count < COUNT_TO) then
					next_state <= SETTLE;
				else
					next_state <= IDLE;
				end if;
			when IDLE =>
				if (current_cmd_index = 1) then
					next_state <= SETTLE;
				elsif (current_command /= x"FFFF") then
					next_state <= STARTBIT1;
				end if;
			when STARTBIT1 =>
				next_state <= STARTBIT2;
			when STARTBIT2 =>
				next_state <= DATABIT;
			when DATABIT =>
				next_state <= CUP;
			when CUP =>
				next_state <= CDOWN;
			when CDOWN =>
				if (bits_left > 0) then
					next_state <= DATABIT;
				else
					next_state <= STOPBIT1;
				end if;
			when STOPBIT1 =>
					next_state <= STOPBIT2;
			when STOPBIT2 =>
					next_state <= IDLE;
		end case;
	end process;
	
state_transition: 
	process (clk, reset) is
	begin
		if (reset = '1') then
			current_state <= SETTLE;
			current_cmd_index <= 0;
			bits_left <= 0;
			data_out <= (others => '0');
			count <= 0;
		elsif (rising_edge(clk)) then
			current_state <= next_state;
			data_out <= data_out;
			bits_left <= bits_left;
			current_cmd_index <= current_cmd_index;
			case (current_state) is
				when IDLE =>
					count <= 0;
					if (next_state = SETTLE) then
						current_cmd_index <= current_cmd_index + 1;
					end if;
				when SETTLE =>
					count <= count+1;
				when STARTBIT1 =>
					bits_left <= 27;
					current_cmd_index <= current_cmd_index + 1;
					data_out <= CAMERA_ID & '1' & current_command(15 downto 8) & '1' & current_command(7 downto 0) & '1';
				when DATABIT =>
					bits_left <= bits_left - 1;
				when CDOWN =>
					data_out <= data_out(25 downto 0) & '0';
				when others =>
					data_out <= data_out;
					bits_left <= bits_left;
					current_cmd_index <= current_cmd_index;
			end case;
		end if;
	end process;
	
output_logic: 
	process (current_state,next_state,data_out(26)) is
	begin
		if ((current_state = IDLE) and (next_state = IDLE)) then
			busy <= '0';
		else
			busy <= '1';
		end if;
		case (current_state) is
			when IDLE | SETTLE =>
				S_D <= '1';
				S_C <= '1';
			when STARTBIT1 =>
				S_D <= '0';
				S_C <= '1';
			when STARTBIT2 =>
				S_D <= '0';
				S_C <= '0';
			when DATABIT =>
				S_D <= data_out(26);
				S_C <= '0';
			when CUP =>
				S_D <= data_out(26);
				S_C <= '1';
			when CDOWN =>
				S_D <= data_out(26);
				S_C <= '0';
			when STOPBIT1 =>
				S_D <= '0';	
				S_C <= '0';
			when STOPBIT2 =>
				S_D <= '0';	
				S_C <= '1';
		end case;
	end process;
	
	
command_list: process (current_cmd_index) is
begin
	case current_cmd_index is
		when 0 => current_command <= x"1280"; -- COM7   Reset
		when 1 => current_command <= x"0000"; -- DUMMY COMMAND for delay!
		when 2 => current_command <= x"1204"; -- COM7   Default size, RGB
		when 3 => current_command <= x"1100"; -- CLKRC  Prescaler - Fin/(1+1) 										--Meni lici kao Fin/(0+1)
		when 4 => current_command <= x"0C00"; -- COM3   Lots of stuff, enable scaling, all others off		--Deluje kao da nije enablovan scaling
		when 5 => current_command <= x"3E00"; -- COM14  PCLK scaling off												--Scaling auto, clk divide by 1
--Tested color no good
		when 6 => current_command <= x"8C00"; -- RGB444 No RGB 444
		when 7 => current_command <= x"0400"; -- COM1   no CCIR601
		when 8 => current_command <= x"40f0"; -- COM15  Full 0-255 output, RGB 555
--Tested standard
		when 9 => current_command <= x"3a04"; -- TSLB   Set UV ordering,  do not auto-reset window
		when 10 => current_command <= x"1438"; -- COM9  - AGC Celling
		when 11 => current_command <= x"4f40"; --x"4fb3"; -- MTX1  - colour conversion matrix
		when 12 => current_command <= x"5034"; --x"50b3"; -- MTX2  - colour conversion matrix
		when 13 => current_command <= x"510C"; --x"5100"; -- MTX3  - colour conversion matrix
		when 14 => current_command <= x"5217"; --x"523d"; -- MTX4  - colour conversion matrix
		when 15 => current_command <= x"5329"; --x"53a7"; -- MTX5  - colour conversion matrix
		when 16 => current_command <= x"5440"; --x"54e4"; -- MTX6  - colour conversion matrix
		when 17 => current_command <= x"581e"; --x"589e"; -- MTXS  - Matrix sign and auto contrast
--Tested no change
		when 18 => current_command <= x"3dc8"; -- COM13 - Turn on GAMMA and UV Auto adjust
		when 19 => current_command <= x"1100"; -- CLKRC  Prescaler - Fin/(1+1)
		when 20 => current_command <= x"1711"; -- HSTART HREF start (high 8 bits)
		when 21 => current_command <= x"1861"; -- HSTOP  HREF stop (high 8 bits)
		when 22 => current_command <= x"3280"; -- HREF   Edge offset and low 3 bits of HSTART and HSTOP
		when 23 => current_command <= x"1903"; -- VSTART VSYNC start (high 8 bits)
		when 24 => current_command <= x"1A7b"; -- VSTOP  VSYNC stop (high 8 bits)
		when 25 => current_command <= x"030a"; -- VREF   VSYNC low two bits
		
		when 26 => current_command <= x"0e61"; -- COM5(0x0E) 0x61
		when 27 => current_command <= x"0f4b"; -- COM6(0x0F) 0x4B
		when 28 => current_command <= x"1602"; --
		when 29 => current_command <= x"1e27"; -- MVFP (0x1E) 0x07  -- FLIP AND MIRROR IMAGE 0x3x
		
--Still working 
		when 30 => current_command <= x"2102";
		when 31 => current_command <= x"2291";
		when 32 => current_command <= x"2907";
		when 33 => current_command <= x"330b";
--tESTING WHITE LINE
		when 34 => current_command <= x"350b";
		when 35 => current_command <= x"371d";
		when 36 => current_command <= x"3871";
		when 37 => current_command <= x"3900";
		when 38 => current_command <= x"3c78"; -- COM12 (0x3C) 0x78
		when 39 => current_command <= x"4d40";
--Works but white line appears
		when 40 => current_command <= x"4e20";
	when 41 => current_command <= x"6900"; -- GFIX (0x69) 0x00
		
		when 42 => current_command <= x"6b0a";			--Bypass PLL!
		when 43 => current_command <= x"7410";
		when 44 => current_command <= x"8d4f";
		
		when 45 => current_command <= x"8e00";
		when 46 => current_command <= x"8f00";
		when 47 => current_command <= x"9000";
		when 48 => current_command <= x"9100";
		when 49 => current_command <= x"9600";
		
		when 50 => current_command <= x"9a00";
		when 51 => current_command <= x"b084";
		when 52 => current_command <= x"b10c";
		when 53 => current_command <= x"b20e";
		when 54 => current_command <= x"b382";
		when 55 => current_command <= x"b80a";
		when others => current_command <= x"ffff";
	end case;
end process;
	
end cam_ctr_arch;