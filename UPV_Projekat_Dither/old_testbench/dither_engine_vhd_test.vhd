-- Copyright (C) 2017  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functiops 
-- and other software and tools, and its AMPP partner logic 
-- functiops, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditiops of the Intel Program Licepse 
-- Subscription Agreement, the Intel Quartus Prime Licepse Agreement,
-- the Intel MegaCore Function Licepse Agreement, or other 
-- applicable licepse agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Intel and sold by Intel or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- ***************************************************************************
-- This file contaips a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "09/04/2019 23:12:49"
                                                            
-- Vhdl Test Bench template for design  :  dither_engine
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                               
USE ieee.numeric_std.all;                                

ENTITY dither_engine_vhd_tst IS
END dither_engine_vhd_tst;
ARCHITECTURE dither_engine_arch OF dither_engine_vhd_tst IS
-- copstants                     

SIGNAL reset : STD_LOGIC;   
SIGNAL Vsync : STD_LOGIC;                           

-- signals for dither engine         
SIGNAL rgb_out : std_logic_vector(2 downto 0);
SIGNAL w_e : std_logic;
SIGNAL adr : std_logic_vector(18 downto 0);
--signals for cam read                     
SIGNAL B : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL clk_out : STD_LOGIC;
SIGNAL data : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL G : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL Href : STD_LOGIC:='0';
SIGNAL Pclk : STD_LOGIC:='0';
SIGNAL R : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL valid : STD_LOGIC; 
SIGNAL x : STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL y : STD_LOGIC_VECTOR(8 DOWNTO 0);

--signals for write_interface
SIGNAL s_adr : STD_LOGIC_VECTOR(21 DOWNTO 0);
SIGNAL s_data : STD_LOGIC_VECTOR(15 DOWNTO 0);

COMPONENT dither_engine
	generic
	(
		SCREEN_WIDTH : integer := 15
	);
	port 
	(
		reset : in std_logic;
		clk	: in std_logic;
		valid	: in std_logic;
		Vsync	: in std_logic;
		rin, gin, bin	: in std_logic_vector(4 downto 0);
		rgb_out	: out std_logic_vector(2 downto 0) := "000"; --rgb
		w_e	: out std_logic := '0';
		adr	: out std_logic_vector(18 downto 0)
	);
END COMPONENT;

COMPONENT cam_read
	PORT (
	B : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
	clk_out : OUT STD_LOGIC;
	data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	G : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
	Href : IN STD_LOGIC;
	Pclk : IN STD_LOGIC;
	R : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
	reset : IN STD_LOGIC;
	valid : OUT STD_LOGIC;
	Vsync : IN STD_LOGIC;
	x : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
	y : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
	);
END COMPONENT;

COMPONENT write_interface
	PORT (
	address_out : OUT STD_LOGIC_VECTOR(21 DOWNTO 0);
	adr : IN STD_LOGIC_VECTOR(18 DOWNTO 0);
	clk : IN STD_LOGIC;
	data_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	din : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	reset : IN STD_LOGIC;
	vsync : IN STD_LOGIC;
	w_e : IN STD_LOGIC
	);
END COMPONENT;

BEGIN
	cam_rd : cam_read
	PORT MAP (
-- list connectiops between master ports and signals
	B => B,
	clk_out => clk_out,
	data => data,
	G => G,
	Href => Href,
	Pclk => Pclk,
	R => R,
	reset => reset,
	valid => valid,
	Vsync => Vsync,
	x => x,
	y => y
	);
	
	dit_en : dither_engine
	GENERIC MAP (4)
	PORT MAP (
-- list connectiops between master ports and signals
	clk => clk_out,
	rin => R,
	gin => G,
	bin => B,
	rgb_out => rgb_out,
	reset => reset,
	valid => valid,
	Vsync => Vsync,
	w_e => w_e,
	adr => adr
	);
	
	wr_int : write_interface
	PORT MAP(
	address_out => s_adr,
	adr => adr,
	clk => clk_out, --izuzetno pazljivo sa ovim
	data_out => s_data,
	din => rgb_out,
	reset => reset,
	vsync => vsync,
	w_e => w_e
	);
	
	
Pclk <= not Pclk after 20 ps;
	
	
init : PROCESS                                               
-- variable declaratiops                                     
BEGIN          
	Vsync <= '1';
	Href <= '0';
	DATA <= "00000000";
	
	
	WAIT for 80 ps;
	Vsync <= '0';
	
	WAIT for 80 ps;
	Href <= '1';
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	Href <= '0';
	
	wait for 80 ps;
	Href <= '1';
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	Href <= '0';
	
	wait for 80 ps;
	Href <= '1';
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	Href <= '0';
	
	WAIT for 80 ps;
	Vsync <= '1';
	
	
	WAIT for 80 ps;
	Vsync <= '0';
	
	WAIT for 80 ps;
	Href <= '1';
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	Href <= '0';
	
	wait for 80 ps;
	Href <= '1';
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	Href <= '0';
	
	wait for 80 ps;
	Href <= '1';
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	Href <= '0';
	
	WAIT for 80 ps;
	Vsync <= '1';
	
	
	WAIT for 80 ps;
	Vsync <= '0';
	
	WAIT for 80 ps;
	Href <= '1';
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	Href <= '0';
	
	wait for 80 ps;
	Href <= '1';
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	Href <= '0';
	
	wait for 80 ps;
	Href <= '1';
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	Href <= '0';
	
	WAIT for 80 ps;
	Vsync <= '1';
	
	
	WAIT for 80 ps;
	Vsync <= '0';
	
	WAIT for 80 ps;
	Href <= '1';
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	Href <= '0';
	
	wait for 80 ps;
	Href <= '1';
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	Href <= '0';
	
	wait for 80 ps;
	Href <= '1';
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	DATA <= "10110000";
	WAIT for 40 ps;
	DATA <= "00001111";
	WAIT for 40 ps;
	Href <= '0';
	
	WAIT for 80 ps;
	Vsync <= '1';
	
	
WAIT;                                                       
END PROCESS init;     
                                      
END dither_engine_arch;
