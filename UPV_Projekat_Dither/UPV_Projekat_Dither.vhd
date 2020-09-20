library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity UPV_Projekat_Dither is

	port
	(
		button : in std_logic;
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

--TODO - ubaceno za testiranje
component cam_mem_uart is
	generic (
		NUM_PXS :integer :=  640 * 480
	);
	port (
		clk 	: in std_logic;
		reset 	: in std_logic;
		button 	: in std_logic;
		tx_busy	: in std_logic;
		tx_en	: out std_logic;
		adr		: out std_logic_vector(18 downto 0)		
	);
end component;



--TODO - ubaceno za testiranje
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
--TODO endblock



--TODO-extreme   Ubacen metatest za kontorler ram-aentity memory_debug is
--component memory_debug is
--	port (
--		clk 	: in std_logic;
--		reset 	: in std_logic;
--		
--		a_write, a_read : out std_logic_vector(21 downto 0);
--		d_write			: out std_logic_vector(15 downto 0);
--		d_read			: in std_logic_vector(15 downto 0) := (others => '1');
--		
--		w_complete		: in std_logic;
--		r_complete		: in std_logic;
--		
--		equals 			: out std_logic;
--		equals_valid	: out std_logic
--
--	);
--end component;
--TODO endblock

component memory_debug_uart is
	generic (
		Atot : integer := 100000	--How many adresses to test, will take 
	);
	port (
		clk 	: in std_logic;
		reset 	: in std_logic;
		
		a_write, a_read : out std_logic_vector(21 downto 0);
		d_write			: out std_logic_vector(31 downto 0);
		d_read			: in std_logic_vector(31 downto 0) := (others => '1');
		btn				: in std_logic;
		w_complete		: in std_logic;
		r_complete		: in std_logic;
		
		uart_data		: out std_logic_vector(7 downto 0);
		uart_req			: out std_logic := '0';
		waiting : out std_logic;
		uart_busy 		: in std_logic
	);
end component;
--TODO final test

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

component write_interface is
	port
	(
		din : in std_logic_vector(2 downto 0);
		adr : in std_logic_vector(18 downto 0); --307200 pix -> 19 bits needed
		w_e : in std_logic;
		vsync:in std_logic;
		clk : in std_logic;
		finished_frame : out std_logic_vector(1 downto 0);
		reset : in std_logic;
		address_out:	out std_logic_vector(21 downto 0);
		data_out : out std_logic_vector(15 downto 0)
 	);
end component;

component SDRAM_control is
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
	port
	(
		dout : out std_logic_vector(2 downto 0);
		adr : in std_logic_vector(18 downto 0); --307200 pix -> 19 bits needed
		finished_frame : in std_logic_vector(1 downto 0);
		vsync:in std_logic;		--carefull, vsync is inverted here, pulses are 0
		clk : in std_logic;
		reset : in std_logic;
		address_out:	out std_logic_vector(21 downto 0);
		data_in : in std_logic_vector(15 downto 0)
 	);
end component;

component vga_interface is
	generic (
		H_DISPLAY: integer := 1024;	-- visible pixels
		V_DISPLAY: integer := 768;		-- visible pixels
		CAM_WIDTH : integer := 640;
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

--CONSTANTS
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
	--write_interface
signal finished_frame : std_logic_vector(1 downto 0);	--finished_frame
signal s_ctr_wr_adr : std_logic_vector(21 downto 0);	--address_out
signal s_ctr_wr_data : std_logic_vector(31 downto 0);	--data_out
	--SDRAM_control
signal s_ctr_rd_data : std_logic_vector(31 downto 0);	--d_read
	--read_interface
signal RGB_dither_read : std_logic_vector(2 downto 0);	--dout
signal s_ctr_rd_adr : std_logic_vector(21 downto 0);	--address_out
	--vga_interface
signal vga_data : std_logic_vector(2 downto 0);	--dout
signal read_adr : std_logic_vector(18 downto 0);	--adr
	--vga_sync
signal vga_x : integer range 0 to H_DISPLAY - 1;	--hpos
signal vga_y : integer range 0 to V_DISPLAY - 1;	--vpos
signal vga_vsync_int : std_logic;


--TODO EXTREME za testiranje mem debug
signal w_complete : std_logic;
signal r_complete : std_logic;
signal waiting : std_logic;


--SIGNALI za test TODO
signal tx_busy, tx_en : std_logic;



signal x_cam : std_logic_vector(9 downto 0);

signal tx_data : std_logic_vector(7 downto 0);

begin

	reset <= not reset_n;

	vga_vsync <= vga_vsync_int;	--Zbog problema sa citanjem izlaznog porta
	c_sdram <= c_sdram_int;
	--PAZI,  MOZDA JE RESET INVERTOVAN
	
	--test1 <= write_pixel;					--Zakomentarisao TODO, zbog testa
	--test2 <= finished_frame(0);
	
	
	
	--TEST
	--TEST
	
	
	
	
	--TODO ubaceno za test
--	
--cam_mem_uart_inst: cam_mem_uart
--	port map(
--		clk 	=> clk_50,
--		reset 	=> reset,
--		button 	=> '0',			--TODO EXTREME, mem)debug test   bio : not test2,  	--TODO, ovde test2 koristi za bttn pin88
--		tx_busy	=>tx_busy,
--		tx_en	=> tx_en,
--		adr	=>  read_adr  --kad otkacis TODO		
--	);
--	--TODO done

	
	-- TODO ubacena instanca UARTA !!!!! za testiranje
	uart_inst:uart_bullshit
	PORT MAP(
		clk		=>clk_50,
		reset_n	=> not reset,
		tx_ena	=> tx_en,
		tx_data	=> tx_data,
		rx			=> '1',							
		rx_busy	=> OPEN,							
		rx_error	=> OPEN,							
		rx_data	=> OPEN,
		tx_busy	=> tx_busy,	
		tx			=> test1 	--TODO EXTREME   test1 ovdje bio za uart--TODO pazi, test1 je RX, pin 127
		);			
		--Uart inst TODO done
	
	

c_sdram_int <= clk_50;	

pll_inst:  pll
	port map (  
		inclk0	=> clk_50,
		c0 => c_vga, 
		c1	=> OPEN, --Testing SDRAM with 50 MHZ
		c2 => c_cam ,
		c3 => c_sccb
	);
	

cam_ctr_inst:  cam_ctr
	port map (  
		reset => reset,
		clk => c_sccb,
		S_C => S_C, 
		S_D => S_D,
		busy => cam_busy
	);

cam_read_inst:  cam_read
	port map (  
		reset => cam_busy,
		Pclk => pclk,
		Href => cam_href,
		Vsync => cam_vsync,
		data => cam_data,
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
		Vsync => cam_vsync,
		rin => R_cam,
		gin => G_cam,
		bin => B_cam,
		rgb_out	=> RGB_dither_write,
		w_e	=> write_pixel,
		adr	=> write_adr
	);


write_interface_inst:  write_interface
	port map (  
		din => "101",		-- TODOTODO (write_adr(2),write_adr(2),write_adr(2) ),					-- TODO changed    RGB_dither_write,
		adr => write_adr,
		w_e => write_pixel,
		vsync => cam_vsync,
		clk => pclk,
		finished_frame => finished_frame,
		reset => cam_busy,
		address_out =>  OPEN , 		--TODO EXTREME  vrati ovo 							s_ctr_wr_adr,
		data_out => OPEN 				--TODO EXTREME   vrati ovo, mem debug test 	s_ctr_wr_data
 	);
	
--	
--	--TODO testiranje
-- memory_debug_inst: memory_debug 
--	port map(
--		clk 	=> c_sccb,
--		reset => reset,
--		
--		a_write => s_ctr_wr_adr,
--		a_read => s_ctr_rd_adr,
--		d_write	=> s_ctr_wr_data,
--		d_read => s_ctr_rd_data,
--		
--		w_complete		=> w_complete,
--		r_complete		=> r_complete,
--		
--		equals 			=> test1,
--		equals_valid	=> test2
--
--	);
--	


mem_deb_inst: memory_debug_uart
	generic map(
		Atot => 100000	--How many adresses to test, will take 
	)
	port map(
		clk 	=> c_sccb,
		reset => reset,
		
		a_write => s_ctr_wr_adr,
		a_read => s_ctr_rd_adr,
		d_write => s_ctr_wr_data,
		d_read => s_ctr_rd_data,
		btn	=> button,
		w_complete		=> w_complete,
		r_complete		=> r_complete,
		uart_data		=> tx_data,
		uart_req			=> tx_en,
		waiting => waiting,
		uart_busy  => tx_busy
	);
--TODO final test
	
	test2 <= waiting ;		--TODO this is status led, was   waiting
	
	
	
SDRAM_control_inst:  SDRAM_control
	port map (  
		reset 	=> reset,
		clk	=> c_sdram_int,
		a_write => s_ctr_wr_adr,
		a_read => s_ctr_rd_adr,
		d_write	=> s_ctr_wr_data,
		d_read => s_ctr_rd_data,
		w_complete => w_complete,
		r_complete => r_complete,
		a_sdram => sd_address,
		
		dq_sdram => sd_data,
		cs_n => sd_cs,
		ras_n => sd_ras,
		cas_n => sd_cas,
		dqmh => sd_dqmh,
		dqml => sd_dqml,
		we_n => sd_we,
		clk_en => sd_cen
	);

read_interface_inst:  read_interface
	port map (  
		dout => RGB_dither_read,
		adr => read_adr,
		finished_frame => finished_frame,
		vsync => vga_vsync_int,
		clk => c_sdram_int,
		reset => reset,
		address_out => OPEN,			--TODO EXTREME vrati   s_ctr_rd_adr,
		data_in => (others => '1')			--TODO EXTREME vrati    s_ctr_rd_data
 	);

vga_interface_inst:  vga_interface
	generic map (
		H_DISPLAY => H_DISPLAY,
		V_DISPLAY => V_DISPLAY,
		CAM_WIDTH => CAM_WIDTH,
		CAM_HEIGHT => CAM_HEIGHT 
	)
	port map (  
		clk => c_vga,
		reset => reset,
		hpos => vga_x,
		vpos => vga_y,
		vsync => vga_vsync_int,
		din => RGB_dither_read,
		dout => vga_data,
		adr => OPEN    --TODO read_adr bilo ovde, otkaceno
 	);

vga_sync_inst:  vga_sync
	generic map (
		H_DISPLAY => H_DISPLAY,
		V_DISPLAY => V_DISPLAY
	)
	port map (  
		clk => c_vga,
		reset => reset,
		hsync => vga_hsync,
		vsync => vga_vsync_int,
		sync_n => OPEN,
		blank_n => OPEN,
		hpos => vga_x,
		vpos => vga_y,
		Rin => vga_data(2),
		Gin => vga_data(1),
		Bin => vga_data(0),
		Rout => vga_r,
		Gout => vga_g,
		Bout => vga_b
	);

end struct;
