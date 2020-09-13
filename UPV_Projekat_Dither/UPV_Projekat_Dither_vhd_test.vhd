

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;    
Use ieee.numeric_std.all;                            

ENTITY UPV_Projekat_Dither_vhd_tst IS
END UPV_Projekat_Dither_vhd_tst;
ARCHITECTURE UPV_Projekat_Dither_arch OF UPV_Projekat_Dither_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL c_cam : STD_LOGIC;
SIGNAL c_sdram : STD_LOGIC;
SIGNAL cam_data : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL cam_href : STD_LOGIC;
SIGNAL cam_vsync : STD_LOGIC;
SIGNAL clk_50 : STD_LOGIC;
SIGNAL pclk : STD_LOGIC;
SIGNAL reset_n : STD_LOGIC;
SIGNAL S_C : STD_LOGIC;
SIGNAL S_D : STD_LOGIC;
SIGNAL sd_address : STD_LOGIC_VECTOR(13 DOWNTO 0);
SIGNAL sd_cas : STD_LOGIC;
SIGNAL sd_cen : STD_LOGIC;
SIGNAL sd_cs : STD_LOGIC;
SIGNAL sd_data : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL sd_dqmh : STD_LOGIC;
SIGNAL sd_dqml : STD_LOGIC;
SIGNAL sd_ras : STD_LOGIC;
SIGNAL sd_we : STD_LOGIC;
SIGNAL vga_b : STD_LOGIC;
SIGNAL vga_g : STD_LOGIC;
SIGNAL vga_hsync : STD_LOGIC;
SIGNAL vga_r : STD_LOGIC;
SIGNAL vga_vsync : STD_LOGIC;
COMPONENT UPV_Projekat_Dither
	PORT (
	c_cam : OUT STD_LOGIC;
	c_sdram : OUT STD_LOGIC;
	cam_data : IN STD_LOGIC_VECTOR(7 DOWNTO 0) :=> (others => '0');
	cam_href : IN STD_LOGIC;
	cam_vsync : IN STD_LOGIC;
	clk_50 : IN STD_LOGIC;
	pclk : IN STD_LOGIC;
	reset_n : IN STD_LOGIC;
	S_C : OUT STD_LOGIC;
	S_D : OUT STD_LOGIC;
	sd_address : OUT STD_LOGIC_VECTOR(13 DOWNTO 0);
	sd_cas : OUT STD_LOGIC;
	sd_cen : OUT STD_LOGIC;
	sd_cs : OUT STD_LOGIC;
	sd_data : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	sd_dqmh : OUT STD_LOGIC;
	sd_dqml : OUT STD_LOGIC;
	sd_ras : OUT STD_LOGIC;
	sd_we : OUT STD_LOGIC;
	vga_b : OUT STD_LOGIC;
	vga_g : OUT STD_LOGIC;
	vga_hsync : OUT STD_LOGIC;
	vga_r : OUT STD_LOGIC;
	vga_vsync : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : UPV_Projekat_Dither
	PORT MAP (
-- list connections between master ports and signals
	c_cam => c_cam,
	c_sdram => c_sdram,
	cam_data => cam_data,
	cam_href => cam_href,
	cam_vsync => cam_vsync,
	clk_50 => clk_50,
	pclk => pclk,
	reset_n => reset_n,
	S_C => S_C,
	S_D => S_D,
	sd_address => sd_address,
	sd_cas => sd_cas,
	sd_cen => sd_cen,
	sd_cs => sd_cs,
	sd_data => sd_data,
	sd_dqmh => sd_dqmh,
	sd_dqml => sd_dqml,
	sd_ras => sd_ras,
	sd_we => sd_we,
	vga_b => vga_b,
	vga_g => vga_g,
	vga_hsync => vga_hsync,
	vga_r => vga_r,
	vga_vsync => vga_vsync
	);
	
SIGNAL reset_n : STD_LOGIC;
	
clk_50 <= not clk_50 after 10 ns;	


	SIGNAL cam_data : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL cam_href : STD_LOGIC;
	SIGNAL cam_vsync : STD_LOGIC;
	
	signal cam_x,cam_y : integer range 0 to 2000;
	signal cam_valid : 
	pclk <= c_cam;
	
	
cam_process:
	process(c_cam)
	begin
		if (falling_edge(c_cam)) then
			if (cam_x < 1280 and cam_y < 480) then 
				cam_href <= '1';
				cam_data <= "11011100" & cam_data(5 downto 0)&cam_data(7 downto 6) xor cam_x(7 downto 0) xor cam_y(4 downto 0)&cam_y(7 downto 3);
			else
				cam_href <= '0';
			if (cam_y >482 and cam_y <=484) then
				cam_vsync <=
			if ( cam_x= 640*2 + 5) then
				cam_x <= 0;
				if (cam_y = 480+2+2+2) then
					cam_y <= 0;
				else
					cam_y <= cam_y + 1;
				end if;
			else
				cam_x <= cam_x + 1;
			end;
		end if;
	end;
	
	
	


SIGNAL c_sdram : STD_LOGIC;
SIGNAL sd_address : STD_LOGIC_VECTOR(13 DOWNTO 0);
SIGNAL sd_cas : STD_LOGIC;
SIGNAL sd_cen : STD_LOGIC;
SIGNAL sd_cs : STD_LOGIC;
SIGNAL sd_data : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL sd_dqmh : STD_LOGIC;
SIGNAL sd_dqml : STD_LOGIC;
SIGNAL sd_ras : STD_LOGIC;
SIGNAL sd_we : STD_LOGIC;
SIGNAL vga_b : STD_LOGIC;
SIGNAL vga_g : STD_LOGIC;
SIGNAL vga_hsync : STD_LOGIC;
SIGNAL vga_r : STD_LOGIC;
SIGNAL vga_vsync : STD_LOGIC;
	
	
	
	
init : PROCESS  



                                             
-- variable declarations                                     
BEGIN                                                        
        -- code that executes only once                      
WAIT;                                                       
END PROCESS init;                                           
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
        -- code executes for every event on sensitivity list  
WAIT;                                                        
END PROCESS always;                                          
END UPV_Projekat_Dither_arch;

