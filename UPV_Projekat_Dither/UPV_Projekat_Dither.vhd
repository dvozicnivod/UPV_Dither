library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity UPV_Projekat_Dither is

	port
	(
		button	: in std_logic_vector(3 downto 0);
		test1: out std_logic;		--TODO   test1 used as TX for MSP UART pin 127
		test2: out std_logic;	--TODO EXTREME , smer bio IN dok se citao btn za uart, sada 125
		--TODO   test2 used as BUTTON for test pin 88, used to be   125
		clk_50 : in std_logic;		
		reset_n : in std_logic;	
		pclk :in std_logic;
			--pll
		c_sdram : out std_logic;
		c_cam : out std_logic;
			--cam_ctr
		S_C : out std_logic;	
		S_D : out std_logic;			
			--cam_read
		cam_href : in std_logic;	
		cam_vsync : in std_logic;	
		cam_data : in std_logic_vector (7 downto 0);		
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

constant CAM_WIDTH : integer := 640;
constant CAM_HEIGHT : integer := 480; 

entity pll is
	port
	(
		inclk0		: in std_logic  := '0';
		c0		: out std_logic ;
		c1		: out std_logic ;
		c2		: out std_logic ;
		c3		: out std_logic 
	);
end pll;

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

component cam_ctr is

	port
	(
		reset : in	std_logic;
		clk : in std_logic;	--Needs a clock of <770KHz
		S_C, S_D : out std_logic;
		busy : out std_logic
	);
end component;

component dither_engine is
	generic
	(
		CAM_WIDTH : integer := 8
	);
	port 
	(
		reset : in std_logic;
		clk	: in std_logic;
		valid	: in std_logic;
		v_sync	: in std_logic;
		h_ref	: in std_logic;
		rin, gin, bin	: in std_logic_vector(4 downto 0);
		dither_out : out std_logic_vector(2 downto 0);
		xpos_out : out std_logic_vector(9 downto 0); 
		ypos_out : out std_logic_vector(8 downto 0);
		valid_out : out std_logic
	);
end component;

component write_interface is
	generic
	(
		FRAME_WIDTH : integer := 640;
		NUM_BYTES : integer := 8
	);
	port
	(
		clk : in std_logic;
		reset : in std_logic;
		valid : in std_logic;
		data_in : in std_logic_vector(2 downto 0);
		xpos : in std_logic_vector(9 downto 0); 
		ypos : in std_logic_vector(8 downto 0);
		address_out : out std_logic_vector(18 downto 0); --307200 pix -> 19 bits needed
		data_out : out std_logic_vector(8 * NUM_BYTES - 1 downto 0)
 	);
end component;

component SDRAM_control_synced is
	generic
	(
		SETUP_CYCLES:integer := 32768	--How many cycles to wait before starting initialization
	);
	
	port
	(
		reset 	: in	std_logic;
		clk		: in	std_logic;
		--Control signals
		a_write, a_read : in std_logic_vector(21 downto 0);
		d_write	:	in std_logic_vector(31 downto 0);
		d_read	:	out std_logic_vector(31 downto 0) := (others => '1');
		--Status signals
		w_complete	: out std_logic;
		r_complete	: out std_logic;
		--Interface with SDRAM
		a_sdram 	: 	out std_logic_vector(13 downto 0);	--top 2 bits bank select
		dq_sdram : 	inout std_logic_vector(15 downto 0);
		cs_n		:	out std_logic;
		ras_n		:	out std_logic;
		cas_n 	:	out std_logic;
		dqmh,dqml:	out std_logic;
		we_n		:	out std_logic;
		clk_en	:	out std_logic
	);
end component;

component read_interface is
	generic
	(
		FRAME_WIDTH : integer := 640;
		NUM_BYTES : integer := 2;
		ADDRESS_WIDTH : integer := 22
	);
	port
	(
		clk : in std_logic;
		reset : in std_logic;
		xpos : in std_logic_vector(9 downto 0); 
		ypos : in std_logic_vector(8 downto 0);
		valid : in std_logic;
		v_sync : in std_logic;
		read_address : out std_logic_vector(ADDRESS_WIDTH-1 downto 0);
		read_data : in std_logic_vector(15 downto 0);
		data_out : out std_logic_vector(2 downto 0)
 	);
end component;

component vga_sync is
	generic (
		-- Default display mode is 1024x768@60Hz -- 60MHz clk
		-- Horizontal line
		H_SYNC	: integer := 136;		-- sync pulse in pixels
		H_BP		: integer := 160;		-- back porch in pixels
		H_FP		: integer := 24;		-- front porch in pixels
		H_DISPLAY: integer := 1024;	-- visible pixels
		-- Vertical line
		V_SYNC	: integer := 6;		-- sync pulse in pixels
		V_BP		: integer := 29;		-- back porch in pixels
		V_FP		: integer := 3;		-- front porch in pixels
		V_DISPLAY: integer := 768		-- visible pixels
	);
	port (
		clk : in std_logic;
		reset : in std_logic;
		hsync, vsync : out std_logic;
		sync_n, blank_n : out std_logic;
		hpos : out integer range 0 to H_DISPLAY - 1;
		vpos : out integer range 0 to V_DISPLAY - 1;
		Rin, Gin, Bin : in std_logic;
		Rout, Gout, Bout : out std_logic
	);
end component;

component frame_sync is
	port (
		clk : in std_logic;
		reset : in std_logic;
		vsync_cam : in std_logic;
		vsync_vga : in std_logic;
		frame_write : out std_logic_vector(1 downto 0);
		frame_read : out std_logic_vector(1 downto 0)
	);
end component;

BEGIN











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

component cam_ctr is

	port
	(
		reset : in	std_logic;
		clk : in std_logic;	--Needs a clock of <770KHz
		S_C, S_D : out std_logic;
		busy : out std_logic
	);
end component;

component dither_engine is
	generic
	(
		CAM_WIDTH : integer := 8
	);
	port 
	(
		reset : in std_logic;
		clk	: in std_logic;
		valid	: in std_logic;
		v_sync	: in std_logic;
		h_ref	: in std_logic;
		rin, gin, bin	: in std_logic_vector(4 downto 0);
		dither_out : out std_logic_vector(2 downto 0);
		xpos_out : out std_logic_vector(9 downto 0); 
		ypos_out : out std_logic_vector(8 downto 0);
		valid_out : out std_logic
	);
end component;

component write_interface is
	generic
	(
		FRAME_WIDTH : integer := 640;
		NUM_BYTES : integer := 8
	);
	port
	(
		clk : in std_logic;
		reset : in std_logic;
		valid : in std_logic;
		data_in : in std_logic_vector(2 downto 0);
		xpos : in std_logic_vector(9 downto 0); 
		ypos : in std_logic_vector(8 downto 0);
		address_out : out std_logic_vector(18 downto 0); --307200 pix -> 19 bits needed
		data_out : out std_logic_vector(8 * NUM_BYTES - 1 downto 0)
 	);
end component;

component SDRAM_control_synced is
	generic
	(
		SETUP_CYCLES:integer := 32768	--How many cycles to wait before starting initialization
	);
	
	port
	(
		reset 	: in	std_logic;
		clk		: in	std_logic;
		--Control signals
		a_write, a_read : in std_logic_vector(21 downto 0);
		d_write	:	in std_logic_vector(31 downto 0);
		d_read	:	out std_logic_vector(31 downto 0) := (others => '1');
		--Status signals
		w_complete	: out std_logic;
		r_complete	: out std_logic;
		--Interface with SDRAM
		a_sdram 	: 	out std_logic_vector(13 downto 0);	--top 2 bits bank select
		dq_sdram : 	inout std_logic_vector(15 downto 0);
		cs_n		:	out std_logic;
		ras_n		:	out std_logic;
		cas_n 	:	out std_logic;
		dqmh,dqml:	out std_logic;
		we_n		:	out std_logic;
		clk_en	:	out std_logic
	);
end component;

component read_interface is
	generic
	(
		FRAME_WIDTH : integer := 640;
		NUM_BYTES : integer := 2;
		ADDRESS_WIDTH : integer := 22
	);
	port
	(
		clk : in std_logic;
		reset : in std_logic;
		xpos : in std_logic_vector(9 downto 0); 
		ypos : in std_logic_vector(8 downto 0);
		valid : in std_logic;
		v_sync : in std_logic;
		read_address : out std_logic_vector(ADDRESS_WIDTH-1 downto 0);
		read_data : in std_logic_vector(15 downto 0);
		data_out : out std_logic_vector(2 downto 0)
 	);
end component;

component vga_sync is
	generic (
		-- Default display mode is 1024x768@60Hz -- 60MHz clk
		-- Horizontal line
		H_SYNC	: integer := 136;		-- sync pulse in pixels
		H_BP		: integer := 160;		-- back porch in pixels
		H_FP		: integer := 24;		-- front porch in pixels
		H_DISPLAY: integer := 1024;	-- visible pixels
		-- Vertical line
		V_SYNC	: integer := 6;		-- sync pulse in pixels
		V_BP		: integer := 29;		-- back porch in pixels
		V_FP		: integer := 3;		-- front porch in pixels
		V_DISPLAY: integer := 768		-- visible pixels
	);
	port (
		clk : in std_logic;
		reset : in std_logic;
		hsync, vsync : out std_logic;
		sync_n, blank_n : out std_logic;
		hpos : out integer range 0 to H_DISPLAY - 1;
		vpos : out integer range 0 to V_DISPLAY - 1;
		Rin, Gin, Bin : in std_logic;
		Rout, Gout, Bout : out std_logic
	);
end component;

component frame_sync is
	port (
		clk : in std_logic;
		reset : in std_logic;
		vsync_cam : in std_logic;
		vsync_vga : in std_logic;
		frame_write : out std_logic_vector(1 downto 0);
		frame_read : out std_logic_vector(1 downto 0)
	);
end component;
















END struct;
