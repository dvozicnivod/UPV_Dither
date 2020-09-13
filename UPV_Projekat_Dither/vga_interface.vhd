library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity vga_interface is

	generic (
		H_DISPLAY: integer := 1024;	-- visible pixels
		V_DISPLAY: integer := 768;		-- visible pixels
		CAM_WIDTH : integer := 640;	-- size of picture from camera
		CAM_HEIGHT : integer := 480
	);
	
	port
	(
		clk : in std_logic;
		reset : in std_logic;
		hpos : in integer range 0 to H_DISPLAY-1;
		vpos : in integer range 0 to V_DISPLAY-1;
		vsync : in std_logic;
		din : in std_logic_vector(2 downto 0);
		dout : out std_logic_vector(2 downto 0);
		adr : out std_logic_vector(18 downto 0)
 	);
end vga_interface;

architecture vga_interface_arch of vga_interface is

	constant H_OFFSET : integer := (H_DISPLAY - CAM_WIDTH) / 2;
	constant V_OFFSET : integer := (V_DISPLAY - CAM_HEIGHT) / 2;
	constant NO_PIXELS 	: integer := CAM_WIDTH * CAM_HEIGHT; --307200 default

	signal valid_area : std_logic := '0'; 
	signal count : integer range 0 to NO_PIXELS := 0; 
	
begin

	valid_area <= '0' when (hpos < H_OFFSET or hpos>= H_OFFSET+CAM_WIDTH or vpos < V_OFFSET or vpos>= V_OFFSET+CAM_HEIGHT) else '1';
	
	adr <= (others => '0') when (count = 0) else std_logic_vector(to_unsigned(count - 1,19)) ;

clocked_process:
	process (reset, clk) is
	begin
		if (reset = '1') then
			count <= 0;
			dout <= "000";
		elsif (falling_edge(clk)) then 
			if (valid_area = '1') then
				dout <= din ;
			else
				dout <= "000";
			end if;
			--	adr <= std_logic_vector(to_unsigned(count,19));
			if (vsync = '0') then
				count <= 0;
			elsif (valid_area = '1') then
				count <= count + 1;
			end if;
		end if;
	end process;
	
end vga_interface_arch;
