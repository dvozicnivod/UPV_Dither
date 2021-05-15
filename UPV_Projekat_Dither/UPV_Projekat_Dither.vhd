library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity UPV_Projekat_Dither is

	port
	(
		button	: in std_logic_vector(3 downto 0);
		test1: out std_logic;		--TODO   test1 used as TX for MSP UART pin 127
		test2: in std_logic;	--TODO EXTREME , smer bio IN dok se citao btn za uart, sada 125
		--TODO   test2 used as BUTTON for test pin 88, used to be   125
		--TODO test3
		clk_50 : in std_logic;		
		reset_n : in std_logic;	
		pclk : in std_logic;
			--pll
		c_sdram : out std_logic;
		c_cam : out std_logic;
			--cam_ctr
		S_C : out std_logic;	
		S_D : out std_logic;		
			--SDRAM_control
		sd_address : out std_logic_vector(13 downto 0);
		sd_data : inout std_logic_vector(15 downto 0);
		sd_cs : out std_logic;	
		sd_ras : out std_logic;	
		sd_cas : out std_logic;	
		sd_dqmh : out std_logic;	
		sd_dqml : out std_logic;	
		sd_we : out std_logic;	
		sd_cen : out std_logic;	
			--vga_sync
		vga_hsync : out std_logic;
		vga_vsync : out std_logic;
		vga_r : out std_logic;	
		vga_g : out std_logic;	
		vga_b : out std_logic
	);
end UPV_Projekat_Dither;


architecture struct of UPV_Projekat_Dither is

component uart_bullshit IS
	GENERIC(
		clk_freq		:	INTEGER	:= 50_000_000;
		baud_rate	:	INTEGER	:= 460_800;			--Can do 921_600  <0.5% error for no os, ~3% error for os 2
		os_rate		:	INTEGER	:= 2	;
		d_width		:	INTEGER	:= 8	;
		parity		:	INTEGER	:= 0	;
		parity_eo	:	STD_LOGIC:= '0'	
		);			
	PORT(
		clk		:	IN		STD_LOGIC;										--system clock
		reset_n	:	IN		STD_LOGIC;										--ascynchronous reset
		tx_ena	:	IN		STD_LOGIC;										--initiate transmission
		tx_data	:	IN		STD_LOGIC_VECTOR(d_width-1 DOWNTO 0);  --data to transmit
		rx			:	IN		STD_LOGIC;										--receive pin
		rx_busy	:	OUT	STD_LOGIC;										--data reception in progress
		rx_error	:	OUT	STD_LOGIC;										--start, parity, or stop bit error detected
		rx_data	:	OUT	STD_LOGIC_VECTOR(d_width-1 DOWNTO 0);	--data received
		tx_busy	:	OUT	STD_LOGIC;  									--transmission in progress
		tx			:	OUT	STD_LOGIC);										--transmit pin
END component;

component pll is
	PORT
	(
		inclk0		: IN STD_LOGIC  := '0';
		c0		: OUT STD_LOGIC ;
		c1		: OUT STD_LOGIC ;
		c2		: OUT STD_LOGIC ;
		c3		: OUT STD_LOGIC 
	);
end component;


component cam_ctr is
	port
	(
		reset : in std_logic;
		clk : in std_logic;
		S_C, S_D : out std_logic;
		busy : out std_logic
	);
end component;

component cam_read is
	port
	(
		reset : in	std_logic;
		Pclk, Href, Vsync	: in  std_logic;
		data : in std_logic_vector (7 downto 0);
		R,G,B	: out std_logic_vector (4 downto 0);
		valid: out std_logic := '0';
		x	:out std_logic_vector (9 downto 0);
		y 	:out std_logic_vector (8 downto 0)
	);
end component;

component dither_engine is
	generic
	(
		CAM_WIDTH : integer
	);
	port 
	(
		reset : in std_logic;
		clk	: in std_logic;
		valid	: in std_logic;
		Vsync	: in std_logic;
		rin, gin, bin	: in std_logic_vector(4 downto 0);
		rgb_out	: out std_logic_vector(2 downto 0); --rgb
		w_e	: out std_logic := '0';
		adr	: out std_logic_vector(18 downto 0)
	);
end component;

---CONSTANTS
constant H_DISPLAY: integer := 1024;
constant V_DISPLAY: integer := 768;
constant CAM_WIDTH : integer := 640;
constant CAM_HEIGHT : integer := 480;

--INTERNAL SIGNALS
signal reset : std_logic;
	--pll
signal c_sccb : std_logic;
signal c_vga : std_logic;	--c_vga
signal c_sdram_int : std_logic;
	--cam_ctr
signal cam_busy : std_logic;	--busy
	--cam_read
signal R_cam : std_logic_vector(4 downto 0);	--R
signal G_cam : std_logic_vector(4 downto 0);	--G
signal B_cam : std_logic_vector(4 downto 0);	--B
signal cam_data_valid : std_logic;	--valid
	--dither_engine
signal RGB_dither_write : std_logic_vector(2 downto 0);	--rgb_out
signal write_pixel : std_logic;	--w_e
signal write_adr : std_logic_vector(18 downto 0);	--adr

--interni zbog gejtovanja diter testa
signal pclk_int : std_logic;

--TODO EXTREME za testiranje mem debug
signal w_complete : std_logic;
signal r_complete : std_logic;
signal waiting : std_logic;

--SIGNALI za test TODO
signal tx_busy, tx_en : std_logic;

	--cam_read
signal cam_href_int : std_logic;	
signal cam_vsync_int : std_logic;	
signal cam_data_int : std_logic_vector (7 downto 0);		

signal x_cam : std_logic_vector(9 downto 0);

signal tx_data : std_logic_vector(7 downto 0);

begin

	reset <= not reset_n;
	
	--TODO test3
	-- test2 <= rx
	
	uart_inst:uart_bullshit
	PORT MAP(
		clk		=>clk_50,
		reset_n	=> not reset,
		tx_ena	=> tx_en,
		tx_data	=> tx_data,
		rx			=> test2,	--TODO nadji koji je pin							
		rx_busy	=> OPEN,							
		rx_error	=> OPEN,							
		rx_data	=> OPEN,
		tx_busy	=> tx_busy,	
		tx			=> test1 	--TODO EXTREME   test1 ovdje bio za uart--TODO pazi, test1 je RX, pin 127
		);			
		--Uart inst TODO done
	
	
pll_inst:  pll
	port map (  
		inclk0	=> clk_50,
		c0 => c_vga, 
		c1	=> OPEN, --Testing SDRAM with 50 MHZ
		c2 => OPEN,
		c3 => OPEN	--TODO povezi sa clk u DITHER DEBUG
	);
	

cam_read_inst:  cam_read
	port map (  
		reset => reset,
		Pclk => pclk_int,
		Href => cam_href_int,
		Vsync => cam_vsync_int,
		data => cam_data_int,
		R => R_cam,
		G => G_cam,
		B => B_cam,
		valid => cam_data_valid,
		x => x_cam, 
		y => OPEN
	);

dither_engine_inst:  dither_engine
	generic map (  
		CAM_WIDTH => CAM_WIDTH
	)
	port map (  
		reset => cam_busy,
		clk	=> pclk,
		valid => cam_data_valid,
		Vsync => cam_vsync_int,
		rin => R_cam,
		gin => G_cam,
		bin => B_cam,
		rgb_out	=> RGB_dither_write,
		w_e	=> write_pixel,
		adr	=> write_adr
	);

end struct;
