-- Copyright (C) 2017  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Intel and sold by Intel or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "09/07/2019 21:42:20"
                                                            
-- Vhdl Test Bench template for design  :  write_interface
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY write_interface_vhd_tst IS
END write_interface_vhd_tst;
ARCHITECTURE write_interface_arch OF write_interface_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL address_out : STD_LOGIC_VECTOR(21 DOWNTO 0);
SIGNAL adr : STD_LOGIC_VECTOR(18 DOWNTO 0);
SIGNAL clk : STD_LOGIC;
SIGNAL data_out : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL din : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL reset : STD_LOGIC;
SIGNAL vsync : STD_LOGIC;
SIGNAL w_e : STD_LOGIC;
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
	i1 : write_interface
	PORT MAP (
-- list connections between master ports and signals
	address_out => address_out,
	adr => adr,
	clk => clk,
	data_out => data_out,
	din => din,
	reset => reset,
	vsync => vsync,
	w_e => w_e
	);
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
END write_interface_arch;
