library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity vga_interface_vhd_test is

end vga_interface_vhd_test;
 

architecture arch of vga_interface_vhd_test is

	constant H_DISPLAY: integer := 8;	-- visible pixels
	constant V_DISPLAY: integer := 8;		-- visible pixels
	constant CAM_WIDTH : integer := 4;	-- size of picture from camera
	constant CAM_HEIGHT : integer := 4;


	component vga_interface is
		generic (
			H_DISPLAY: integer := 1024;	-- visible pixels
			V_DISPLAY: integer := 768;		-- visible pixels
			CAM_WIDTH : integer := 640;	-- size of picture from camera
			CAM_HEIGHT : integer := 480
		);
		port
		(
			clk : in std_logic := '0';
			reset : in std_logic;
			hpos : in integer range 0 to H_DISPLAY-1;
			vpos : in integer range 0 to V_DISPLAY-1;
			vsync : in std_logic;
			din : in std_logic_vector(2 downto 0);
			dout : out std_logic_vector(2 downto 0);
			adr : out std_logic_vector(18 downto 0)
		);
	end component;
	
		signal	clk :  std_logic := '0';
		signal	reset : std_logic;
		signal	hpos :  integer range 0 to H_DISPLAY-1;
		signal	vpos :  integer range 0 to V_DISPLAY-1;
		signal	vsync : std_logic;
		signal	din :  std_logic_vector(2 downto 0);
		signal	dout :  std_logic_vector(2 downto 0) := (others => '0');
		signal	adr :  std_logic_vector(18 downto 0);
	
begin

vga_int: vga_interface 
		generic map(
			H_DISPLAY => H_DISPLAY,	
			V_DISPLAY => V_DISPLAY, 
			CAM_WIDTH => CAM_WIDTH,
			CAM_HEIGHT => CAM_HEIGHT
		)
		port map
		(
			clk	=>	clk,	
			reset	=>	reset,	 
			hpos	=>	hpos,	 	
			vpos	=>	vpos, 
			vsync	=>	vsync,	
			din	=>	din,	 	
			dout	=>	dout,	 
			adr	=>	adr		 	
		);

		
		clk <= not clk after 5 ps; --period 10ps
test_process:
	process is
	begin
		hpos <= 0;
		vpos <= 0;
		vsync <= '0';
		din <= "000";
			wait for 25 ps;
		vsync <= '1';
			wait for 30 ps;
			
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
		
		wait for 30 ps;
		hpos <= 0;
		vpos <= vpos + 1;
			wait for 30 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
		
		wait for 30 ps;
		hpos <= 0;
		vpos <= vpos + 1;
			wait for 30 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
		
		din <= "111";
		wait for 30 ps;
		hpos <= 0;
		vpos <= vpos + 1;
			wait for 30 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
		din <= "001";
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			
		
		wait for 30 ps;
		hpos <= 0;
		vpos <= vpos + 1;
			wait for 30 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
		
		wait for 30 ps;
		hpos <= 0;
		vpos <= vpos + 1;
			wait for 30 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1; 
		din <= "111";
		wait for 30 ps;
		hpos <= 0;
		vpos <= vpos + 1;
			wait for 30 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;

		din <= "101";
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
		
		
		wait for 30 ps;
		hpos <= 0;
		vpos <= vpos + 1;
			wait for 30 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		din <= "101";
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
		
		wait for 30 ps;
		
		vsync <= '0';
		wait for 30 ps;
		vsync <= '1';
			wait for 30 ps;
			
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
		din <= "001";
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
		
		wait for 30 ps;
		hpos <= 0;
		vpos <= vpos + 1;
			wait for 30 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
		
		wait for 30 ps;
		hpos <= 0;
		vpos <= vpos + 1;
			wait for 30 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
		
		wait for 30 ps;
		hpos <= 0;
		vpos <= vpos + 1;
			wait for 30 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			
		
		wait for 30 ps;
		hpos <= 0;
		vpos <= vpos + 1;
			wait for 30 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
		
		wait for 30 ps;
		hpos <= 0;
		vpos <= vpos + 1;
			wait for 30 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1; 
		
		wait for 30 ps;
		hpos <= 0;
		vpos <= vpos + 1;
			wait for 30 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
		
		
		wait for 30 ps;
		hpos <= 0;
		vpos <= vpos + 1;
			wait for 30 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
			wait for 10 ps;
		hpos <= hpos + 1;
		
		wait for 30 ps;
		
		vsync <= '0';
		wait for 30 ps;
		
		
		
	
	
	
	
		wait;
	end process;
		
	
end arch;
