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
-- Generated on "05/26/2021 14:38:42"
                                                            
-- Vhdl Test Bench template for design  :  vga_sync_subframe
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;            
use ieee.numeric_std.all;                    

ENTITY vga_sync_subframe_vhd_tst IS
END vga_sync_subframe_vhd_tst;
ARCHITECTURE vga_sync_subframe_arch OF vga_sync_subframe_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL Bin : STD_LOGIC := '1';
SIGNAL blank_n : STD_LOGIC;
SIGNAL Bout : STD_LOGIC;
SIGNAL clk : STD_LOGIC := '1';
SIGNAL Gin : STD_LOGIC := '1';
SIGNAL Gout : STD_LOGIC;
SIGNAL hsync : STD_LOGIC;
SIGNAL reset : STD_LOGIC;
SIGNAL Rin : STD_LOGIC := '1';
SIGNAL Rout : STD_LOGIC;
SIGNAL sync_n : STD_LOGIC;
SIGNAL valid : STD_LOGIC;
SIGNAL vsync : STD_LOGIC;
SIGNAL xpos : integer range 0 to 1023;
SIGNAL ypos : integer range 0 to 1023;
COMPONENT vga_sync_subframe
	PORT (
	Bin : IN STD_LOGIC;
	blank_n : OUT STD_LOGIC;
	Bout : OUT STD_LOGIC;
	clk : IN STD_LOGIC;
	Gin : IN STD_LOGIC;
	Gout : OUT STD_LOGIC;
	hsync : OUT STD_LOGIC;
	reset : IN STD_LOGIC;
	Rin : IN STD_LOGIC;
	Rout : OUT STD_LOGIC;
	sync_n : OUT STD_LOGIC;
	valid : OUT STD_LOGIC;
	vsync : OUT STD_LOGIC;
	xpos : OUT integer;
	ypos : OUT integer
	);
END COMPONENT;
BEGIN
	i1 : vga_sync_subframe
	PORT MAP (
-- list connections between master ports and signals
	Bin => Bin,
	blank_n => blank_n,
	Bout => Bout,
	clk => clk,
	Gin => Gin,
	Gout => Gout,
	hsync => hsync,
	reset => reset,
	Rin => Rin,
	Rout => Rout,
	sync_n => sync_n,
	valid => valid,
	vsync => vsync,
	xpos => xpos,
	ypos => ypos
	);
	
clk <= not clk after 5 ns;
	
init : PROCESS                                               
-- variable declarations                                     
BEGIN                       
reset <= '1';
wait for 20 ns;
reset <= '0';                                 
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
END vga_sync_subframe_arch;
