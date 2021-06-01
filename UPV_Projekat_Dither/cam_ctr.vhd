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
	signal cmds_left : integer range 0 to 5 := 5;
	signal bits_left : integer range 0 to 27 := 0;
	signal data_out : std_logic_vector (26 downto 0) := (others => '0');
	
	constant CAMERA_ID : std_logic_vector (7 downto 0) := X"42";
	constant COM7_ADR : std_logic_vector (7 downto 0) := X"12";
	constant COM15_ADR : std_logic_vector (7 downto 0) := X"40";
	constant RGB444_ADR : std_logic_vector (7 downto 0) := X"8C";
	constant COM7_RESET_CMD : std_logic_vector (7 downto 0) := X"80";
	constant COM7_RGB_CMD : std_logic_vector (7 downto 0) := X"04";
	constant COM15_RGB555_CMD : std_logic_vector (7 downto 0) := X"F0";
	constant RGB444_CMD : std_logic_vector (7 downto 0) := X"00";
	
begin
	
next_state_logic: 
	process (current_state, cmds_left, bits_left, count) is
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
				if (cmds_left = 3) then
					next_state <= SETTLE;
				elsif (cmds_left > 0) then
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
			cmds_left <= 5;
			bits_left <= 0;
			data_out <= (others => '0');
			count <= 0;
		elsif (rising_edge(clk)) then
			current_state <= next_state;
			data_out <= data_out;
			bits_left <= bits_left;
			cmds_left <= cmds_left;
			case (current_state) is
				when IDLE =>
					count <= 0;
					if (next_state = SETTLE) then
						cmds_left <= cmds_left - 1;
					end if;
				when SETTLE =>
					count <= count+1;
				when STARTBIT1 =>
					bits_left <= 27;
					cmds_left <= cmds_left - 1;
					case (cmds_left) is
						when 5 =>
							data_out <= CAMERA_ID & '1' & COM7_ADR & '1' & COM7_RESET_CMD & '1';
						when 3  =>
							data_out <= CAMERA_ID & '1' & RGB444_ADR & '1' & RGB444_CMD & '1';
						when 2  =>
							data_out <= CAMERA_ID & '1' & COM7_ADR & '1' & COM7_RGB_CMD & '1';
						when 1 =>
							data_out <= CAMERA_ID & '1' & COM15_ADR & '1' & COM15_RGB555_CMD & '1';
						when others =>
							data_out <= (others => '0');
					end case;
				when DATABIT =>
					bits_left <= bits_left - 1;
				when CDOWN =>
					data_out <= data_out(25 downto 0) & '0';
				when others =>
					data_out <= data_out;
					bits_left <= bits_left;
					cmds_left <= cmds_left;
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
	
end cam_ctr_arch;