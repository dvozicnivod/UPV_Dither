library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cam_read is

	port
	(
		reset : in	std_logic;
		Pclk, Href, Vsync	: in  std_logic;
		data : in std_logic_vector (7 downto 0);
		R,G,B	: out std_logic_vector (4 downto 0);
		valid: out std_logic := '0';
		x	:out std_logic_vector (9 downto 0);
		y 	:out std_logic_vector (8 downto 0);
		href_out : out std_logic
	);
end cam_read;


architecture cam_read_arch of cam_read is

	type state_type is ( WAIT_FRAME, WAIT_ROW, READ_1, READ_2 );
	
	signal current_state, next_state : state_type := WAIT_FRAME;
	signal data_delayed : std_logic_vector (7 downto 0) := (others => '0');
	signal x_buf	: integer range 0 to 640 := 0;
	signal y_buf : integer range 0 to 480 := 0;
	signal R_buf,G_buf,B_buf	: std_logic_vector (4 downto 0) := (others => '0');

begin

	x <= std_logic_vector(to_unsigned(x_buf,10));
	
	y <= std_logic_vector(to_unsigned(y_buf,9));
	
	R <= R_buf;
	G <= G_buf;
	B <= B_buf;

next_state_logic: 
	process (current_state, Vsync, Href) is
	begin
		next_state <= current_state;
		case (current_state) is
			when WAIT_FRAME =>
				if (Vsync = '0') then
					next_state <= WAIT_ROW;
				end if;
			when WAIT_ROW =>
				if (Vsync = '1') then
					next_state <= WAIT_FRAME;
				elsif (Href = '1') then
					next_state <= READ_1;
				end if;
			when READ_1 =>
				next_state <= READ_2;
			when READ_2 =>
				if ((Href = '0') or (Vsync = '1')) then
					next_state <= WAIT_ROW;
				else
					next_state <= READ_1;
				end if;
		end case;
	end process;
	
state_transition: 
	process (Pclk, reset) is
	begin
		if (reset = '1') then
			current_state <= WAIT_FRAME;
			x_buf <= 0;
			y_buf <= 0;
			R_buf <= "00000";
			G_buf <= "00000";
			B_buf <= "00000";
		elsif (rising_edge(Pclk)) then
			data_delayed <= data;
			current_state <= next_state;
			case (current_state) is
				when WAIT_FRAME =>
					x_buf <= 0;
					y_buf <= 0;
				when WAIT_ROW=> 
					x_buf <= 0;
				when READ_1 =>
					R_buf <= data_delayed(6 downto 2);
					G_buf <= data_delayed(1 downto 0) & data(7 downto 5);
					B_buf <= data(4 downto 0);
				when READ_2 =>
					if (next_state = WAIT_ROW) then
						y_buf <= y_buf + 1;
					else
						x_buf <= x_buf + 1;
					end if;
			end case;
		end if;
	end process;
	
output_logic: 
	process (current_state) is
	begin
		if (current_state = READ_2) then
			valid <= '1';
		else
			valid <= '0';
		end if;
		if (current_state = READ_1 or current_state = READ_2) then
			href_out <= '1';
		else
			href_out <= '0';
		end if;
	end process;
	
end cam_read_arch;