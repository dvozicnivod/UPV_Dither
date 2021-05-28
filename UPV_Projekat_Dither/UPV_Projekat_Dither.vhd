library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity UPV_Projekat_Dither is

	port
	(
		clk_50 : in std_logic;		
		reset_n : in std_logic;	
		pclk :in std_logic;
			--pll
		clk_sdram : out std_logic;
		clk_cam : out std_logic;
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
		vga_b : out std_logic;
		button : in std_logic_vector(3 downto 0)
	);
end UPV_Projekat_Dither;

architecture struct of UPV_Projekat_Dither is

constant CAM_WIDTH : integer := 640;
constant CAM_HEIGHT : integer := 480; 

component pll is
	port
	(
		inclk0		: in std_logic  := '0';
		c0		: out std_logic ;
		c1		: out std_logic ;
		c2		: out std_logic ;
		c3		: out std_logic 
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
		y 	:out std_logic_vector (8 downto 0);
		href_out : out std_logic
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

component SDRAM_control_B4 is
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
		d_write	:	in std_logic_vector(63 downto 0);
		d_read	:	out std_logic_vector(63 downto 0);
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
		FRAME_WIDTH : integer := CAM_WIDTH;
		NUM_BYTES : integer := 8;
		ADDRESS_WIDTH : integer := 19
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
		read_data : in std_logic_vector(63 downto 0);
		data_out : out std_logic_vector(2 downto 0)
 	);
end component;

component vga_sync_subframe is
	generic (
		-- Default display mode is 1024x768@60Hz -- 65MHz clk
		-- Horizontal line
		H_SYNC	: integer := 136;		-- sync pulse in pixels
		H_BP		: integer := 160;		-- back porch in pixels
		H_FP		: integer := 24;		-- front porch in pixels
		H_DISPLAY: integer := 1024;	-- visible pixels
		-- Vertical line
		V_SYNC	: integer := 6;		-- sync pulse in pixels
		V_BP		: integer := 29;		-- back porch in pixels
		V_FP		: integer := 3;		-- front porch in pixels
		V_DISPLAY: integer := 768;		-- visible pixels
		--Active display area:
		H_ACTIVE_DISP : integer := 640;
		V_ACTIVE_DISP : integer := 480
	);
	port (
		clk : in std_logic;
		reset : in std_logic;
		hsync, vsync : out std_logic;
		sync_n, blank_n : out std_logic;
		xpos : out integer range 0 to H_DISPLAY - 1;
		ypos : out integer range 0 to V_DISPLAY - 1;
		valid : out std_logic;
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

--Internal reset signal
signal reset : std_logic;
--Internal clocks
signal clk_vga, clk_sdram_int, clk_cam_ctrl : std_logic;
--Cam read internal signals
signal cam_read_R, cam_read_G, cam_read_B : std_logic_vector(4 downto 0);
signal cam_read_valid, cam_read_href : std_logic;
signal cam_read_x : std_logic_vector(9 downto 0);
signal cam_read_y : std_logic_vector(8 downto 0);
--Dither engine signals
signal dither_out : std_logic_vector(2 downto 0);
signal dither_x : std_logic_vector(9 downto 0);
signal dither_y : std_logic_vector(8 downto 0);
signal dither_valid : std_logic;
--SDRAM control internal signals
signal sd_adr_rd, sd_adr_wr: std_logic_vector(21 downto 0);
signal sd_data_rd, sd_data_wr: std_logic_vector(63 downto 0);
--VGA internal signals
signal vga_x_int : integer range 0 to CAM_WIDTH-1;
signal vga_y_int : integer range 0 to CAM_HEIGHT-1;
signal vga_x : std_logic_vector(9 downto 0);
signal vga_y : std_logic_vector(8 downto 0);
signal vga_valid, vga_vsync_int : std_logic;
signal vga_data : std_logic_vector(2 downto 0);

BEGIN


reset <= not reset_n;

 pll_inst:pll
	port map
	(
		inclk0 	=> clk_50,
		c0 		=> clk_vga,
		c1 		=> clk_sdram_int,
		c2 		=> clk_cam,
		c3 		=> clk_cam_ctrl
	);
	
clk_sdram <= clk_sdram_int;
	
 cam_read_inst:cam_read
	port map
	(
		reset 	=> (reset or (not button(0))),
		Pclk	=> pclk,
		Href	=> cam_href,
		Vsync	=> cam_vsync,
		data	=> cam_data,
		R		=> cam_read_R,
		G 		=> cam_read_G,
		B 		=> cam_read_B,
		valid 	=> cam_read_valid,
		x	 	=> open,
		y 	 	=> open,
		href_out=> cam_read_href
	);

 cam_ctr_inst:cam_ctr
	port map
	(
		reset	=> reset,
		clk  	=> clk_cam_ctrl,
		S_C 	=> S_C, 
		S_D 	=> S_D,
		busy  	=> open
	);

 dither_engine_inst:dither_engine
	generic map
	(
		CAM_WIDTH	=> CAM_WIDTH
	)
	port map 
	(
		reset	=> reset,
		clk	 	=> pclk,
		valid	=> cam_read_valid,
		v_sync	=> cam_vsync,
		h_ref	=> cam_read_href,
		rin 	=> cam_read_R, 
		gin 	=> cam_read_G, 
		bin	 	=> cam_read_B,
		dither_out	=> dither_out,
		xpos_out	=> dither_x,
		ypos_out  	=> dither_y,
		valid_out  	=> dither_valid
	);

 write_interface_inst:write_interface
	generic map
	(
		FRAME_WIDTH	=> CAM_WIDTH,
		NUM_BYTES  	=> 8		--BURST 4
	)
	port map
	(
		clk		=> pclk,
		reset	=> (reset or (not button(1))),
		valid 	=> dither_valid,
		data_in	=> dither_out,
		xpos	=> dither_x,
		ypos	=> dither_y,
		address_out	=> sd_adr_wr(18 downto 0),
		data_out 	=> sd_data_wr
 	);

 SDRAM_control_B4_inst:SDRAM_control_B4
	generic map
	(
		SETUP_CYCLES	=> 32768	--How many cycles to wait before starting initialization
	)
	port map
	(
		reset	=> (reset or (not button(3))),
		clk		=> clk_sdram_int,
		a_write	=> sd_adr_wr, 
		a_read	=> sd_adr_rd,
		d_write	=> sd_data_wr,
		d_read	=> sd_data_rd,
		w_complete	=> open,
		r_complete	=> open,
		a_sdram	=> sd_address,
		dq_sdram=> sd_data,
		cs_n 	=> sd_cs,
		ras_n	=> sd_ras,
		cas_n	=> sd_cas,
		dqmh	=> sd_dqmh,
		dqml 	=> sd_dqml,
		we_n 	=> sd_we,
		clk_en 	=> sd_cen
	);

 read_interface_inst:read_interface
	generic map
	(
		FRAME_WIDTH	=> CAM_HEIGHT,
		NUM_BYTES	=> 8,
		ADDRESS_WIDTH	=> 19
	)
	port map
	(
		clk		=> clk_vga,
		reset	=> (reset or (not button(2))),
		xpos	=> vga_x,
		ypos	=> vga_y,
		valid  	=> vga_valid,
		v_sync	=> not vga_vsync_int, 
		read_address=> sd_adr_rd(18 downto 0),
		read_data  	=> sd_data_rd,
		data_out  	=> vga_data
 	);
	
	vga_vsync <= vga_vsync_int;

 vga_sync_subframe_inst:vga_sync_subframe
	generic map(
		H_SYNC => 136,		
		H_BP => 160,	
		H_FP => 24,
		H_DISPLAY => 1024,
		V_SYNC => 6,
		V_BP => 29,	
		V_FP => 3,
		V_DISPLAY => 768,
		H_ACTIVE_DISP => CAM_WIDTH,
		V_ACTIVE_DISP => CAM_HEIGHT
	)
	port map(
		clk		=> clk_vga,
		reset	=> reset,
		hsync	=> vga_hsync,
		vsync	=> vga_vsync_int,
		sync_n	=> open,
		blank_n	=> open,
		xpos	=> vga_x_int,
		ypos	=> vga_y_int,
		valid	=> vga_valid,
		Rin		=> vga_data(0),
		Gin 	=> vga_data(1), 
		Bin 	=> vga_data(2),
		Rout 	=> vga_r, 
		Gout 	=> vga_g, 
		Bout 	=> vga_b
	);

  vga_x <= std_logic_vector(to_unsigned(vga_x_int,10));
  vga_y <= std_logic_vector(to_unsigned(vga_y_int,9));

 frame_sync_inst:frame_sync
	port map (
		clk  	=> clk_sdram_int,
		reset  	=> reset,
		vsync_cam	=> cam_vsync,
		vsync_vga  	=> not vga_vsync_int,
		frame_write	=> sd_adr_wr(21 downto 20),
		frame_read	=> sd_adr_rd(21 downto 20)
	);

	sd_adr_wr(19) <= '0';
	sd_adr_rd(19) <= '0';


END struct;
