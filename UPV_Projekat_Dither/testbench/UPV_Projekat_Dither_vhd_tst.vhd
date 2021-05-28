-- Copyright (C) 2020  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "05/27/2021 19:21:41"
                                                            
-- Vhdl Test Bench template for design  :  UPV_Projekat_Dither
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY UPV_Projekat_Dither_vhd_tst IS
END UPV_Projekat_Dither_vhd_tst;
ARCHITECTURE UPV_Projekat_Dither_arch OF UPV_Projekat_Dither_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL button : STD_LOGIC_VECTOR(3 DOWNTO 0) := "1111";
SIGNAL cam_data : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL cam_href : STD_LOGIC;
SIGNAL cam_vsync : STD_LOGIC;
SIGNAL clk_50 : STD_LOGIC := '1';
SIGNAL clk_cam : STD_LOGIC;
SIGNAL clk_sdram : STD_LOGIC;
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
END COMPONENT;

COMPONENT cam_sim_tst is
	port
	(
		pclk :out std_logic;
        clk_cam : in std_logic;
        S_C : in std_logic;    
        S_D : in std_logic;    
        cam_href : out std_logic;    
        cam_vsync : out std_logic;   
        cam_data : out std_logic_vector (7 downto 0)
	);
end COMPONENT;
BEGIN
	i1 : UPV_Projekat_Dither
	PORT MAP (
-- list connections between master ports and signals
	button => button,
	cam_data => cam_data,
	cam_href => cam_href,
	cam_vsync => cam_vsync,
	clk_50 => clk_50,
	clk_cam => clk_cam,
	clk_sdram => clk_sdram,
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
	
cam_sim:cam_sim_tst
	port map
	(
		pclk => pclk,
        clk_cam => clk_cam,
        S_C => S_C,  
        S_D => S_D,
        cam_href => cam_href,
        cam_vsync => cam_vsync,
        cam_data => cam_data
	);
	
	clk_50 <= not clk_50 after 10 ns;
	
init : PROCESS                                               
-- variable declarations                                     
BEGIN           
 reset_n <= '0';
wait for 20 ns;
reset_n <= '1'; 
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
