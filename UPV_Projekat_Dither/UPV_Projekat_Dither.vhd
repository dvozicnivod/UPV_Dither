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
		NUM_BYTES : integer := 8
	);
	port
	(
		clk : in std_logic;
		reset : in std_logic;
		valid : in std_logic;
		data_in : in std_logic_vector(2 downto 0);
		data_out : out std_logic_vector(8 * NUM_BYTES - 1 downto 0);
		wr_req : out std_logic;
		vsync : in std_logic
 	);
end component;

component SDRAM_control_B4_fifo is
	port
	(
		reset 	: in	std_logic;
		clk		: in	std_logic;
		--Control signals
		wrclk, rdclk : in std_logic;
		wrreq, rdreq, wr_reset, rd_reset: in std_logic;
		write_d	:	in std_logic_vector(63 downto 0);
		read_q	:	out std_logic_vector(63 downto 0);
		read_usedw, write_usedw : out std_logic_vector(5 downto 0);
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
		NUM_BYTES : integer := 8
	);
	port
	(
		clk : in std_logic;
		reset : in std_logic;
		valid : in std_logic;
		data_in : in std_logic_vector(8 * NUM_BYTES - 1 downto 0);
		data_out : out std_logic_vector(2 downto 0);
		rd_req : out std_logic;
		vsync : in std_logic
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
signal sd_rd_req, sd_wr_req : std_logic;
--VGA internal signals
signal vga_x_int : integer range 0 to CAM_WIDTH-1;
signal vga_y_int : integer range 0 to CAM_HEIGHT-1;
signal vga_x : std_logic_vector(9 downto 0);
signal vga_y : std_logic_vector(8 downto 0);
signal vga_valid, vga_vsync_int : std_logic;
signal vga_data : std_logic_vector(2 downto 0);
--Debug signals
signal vga_r_int, vga_g_int, vga_b_int, vga_all: std_logic;
signal vga_choose: integer range 0 to 3;

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
		reset 	=> reset,
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
		reset	=> (reset  or (not button(3))),
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
	

write_interface_inst: write_interface
	generic map
	(
		NUM_BYTES =>  8
	)
	port map
	(
		clk => pclk,
		reset => reset,
		valid => dither_valid,
		data_in => dither_out,
		data_out => sd_data_wr,
		wr_req => sd_wr_req,
		vsync => cam_vsync
 	);
	
	
	
SDRAM_control_inst: SDRAM_control_B4_fifo
	port map
	(
		reset			=> reset,
		clk			=> clk_sdram_int,
		wrclk			=> pclk,
		rdclk 		=> clk_vga,
		wrreq			=> sd_wr_req,
		rdreq			=> sd_rd_req,
		wr_reset		=> cam_vsync,
		rd_reset		=> not vga_vsync_int,
		write_d		=> sd_data_wr,
		read_q		=> sd_data_rd,
		read_usedw	=> open,
		write_usedw	=> open,
		a_sdram 		=> sd_address,
		dq_sdram 	=> sd_data,
		cs_n			=> sd_cs,
		ras_n			=> sd_ras,
		cas_n 		=> sd_cas,
		dqmh			=> sd_dqmh,
		dqml			=> sd_dqml,
		we_n			=> sd_we,
		clk_en		=> sd_cen
	);
	
read_interface_inst: read_interface
	generic map
	(
		NUM_BYTES => 8
	)
	port map
	(
		clk => clk_vga,
		reset => reset,
		valid => vga_valid,
		data_in => sd_data_rd,
		data_out => vga_data,
		rd_req => sd_rd_req,
		vsync => not vga_vsync_int
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
		Rout 	=> vga_r_int, 
		Gout 	=> vga_g_int, 
		Bout 	=> vga_b_int
	);
	
	vga_r <= vga_r_int;
	vga_g <= vga_g_int;
	vga_b <= vga_b_int;


  vga_x <= std_logic_vector(to_unsigned(vga_x_int, 10));
  vga_y <= std_logic_vector(to_unsigned(vga_y_int, 9));



END struct;
