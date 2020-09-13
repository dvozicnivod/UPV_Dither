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
-- Generated on "08/18/2019 06:27:03"
                                                            
-- Vhdl Test Bench template for design  :  cam_ctr
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY cam_ctr_vhd_tst IS
END cam_ctr_vhd_tst;
ARCHITECTURE cam_ctr_arch OF cam_ctr_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL busy : STD_LOGIC;
SIGNAL clk : STD_LOGIC := '0';
SIGNAL reset : STD_LOGIC;
SIGNAL S_C : STD_LOGIC;
SIGNAL S_D : STD_LOGIC;
COMPONENT cam_ctr
	PORT (
	busy : OUT STD_LOGIC;
	clk : IN STD_LOGIC;
	reset : IN STD_LOGIC;
	S_C : OUT STD_LOGIC;
	S_D : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : cam_ctr
	PORT MAP (
-- list connections between master ports and signals
	busy => busy,
	clk => clk,
	reset => reset,
	S_C => S_C,
	S_D => S_D
	);
	
	
	clk <= not clk after 1 ns;
	
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
END cam_ctr_arch;
