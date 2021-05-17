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
		btn				: in std_logic_vector(3 downto 0);
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


component SDRAM_control_synced is
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


--CONSTANTS
constant H_DISPLAY: integer := 1024;
constant V_DISPLAY: integer := 768;	
constant CAM_WIDTH : integer := 640;
constant CAM_HEIGHT : integer := 480;

--INTERNAL SIGNALS
signal reset : std_logic;
	--pll
signal c_sccb : std_logic;
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
	
	
--c_sdram_int <= clk_50;

pll_inst:  pll
	port map (  
		inclk0	=> clk_50,
		c0 => OPEN, --VGA clk 
		c1	=> c_sdram_int, --Testing SDRAM with 50 MHZ
		c2 => OPEN , --CAM clk
		c3 => c_sccb --CAM sccb clk
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
	
	
	
SDRAM_control_inst:  SDRAM_control_synced
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

	
	
	c_cam <= 'Z';
	S_C <= 'Z';	
	S_D <= 'Z';			
	vga_hsync <= 'Z';
	vga_vsync <= 'Z';
	vga_r <= 'Z';	
	vga_g <= 'Z';
	vga_b <= 'Z';


end struct;
