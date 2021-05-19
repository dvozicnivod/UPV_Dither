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
-- Generated on "05/19/2021 16:32:36"
                                                            
-- Vhdl Test Bench template for design  :  dither_engine
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY dither_engine_vhd_tst IS
END dither_engine_vhd_tst;
ARCHITECTURE dither_engine_arch OF dither_engine_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL bin : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL clk : STD_LOGIC := '0';
SIGNAL dither_out : STD_LOGIC;
SIGNAL gin : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL h_ref : STD_LOGIC;
SIGNAL reset : STD_LOGIC;
SIGNAL rin : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL v_sync : STD_LOGIC;
SIGNAL valid : STD_LOGIC;
SIGNAL xpos_out : STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL ypos_out : STD_LOGIC_VECTOR(8 DOWNTO 0);
COMPONENT dither_engine
	PORT (
	bin : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
	clk : IN STD_LOGIC;
	dither_out : OUT STD_LOGIC;
	gin : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
	h_ref : IN STD_LOGIC;
	reset : IN STD_LOGIC;
	rin : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
	v_sync : IN STD_LOGIC;
	valid : IN STD_LOGIC;
	xpos_out : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
	ypos_out : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
	);
END COMPONENT;
BEGIN

	clk <= not clk after 5 ns;

	i1 : dither_engine
	PORT MAP (
-- list connections between master ports and signals
	bin => bin,
	clk => clk,
	dither_out => dither_out,
	gin => gin,
	h_ref => h_ref,
	reset => reset,
	rin => rin,
	v_sync => v_sync,
	valid => valid,
	xpos_out => xpos_out,
	ypos_out => ypos_out
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
	rin <= "10000";                                           
	gin <= "00000";                                           
	bin <= "00000";
	h_ref <= '0';
	reset <= '1';
	v_sync <= '0';
	valid <= '0';
	
	wait for 15 ns;
	reset <= '0';
	
	wait for 50 ns;
	h_ref <= '1';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	h_ref <= '0';
	
	wait for 50 ns;
	h_ref <= '1';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	h_ref <= '0';
	
	wait for 50 ns;
	h_ref <= '1';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	h_ref <= '0';
	
	wait for 40 ns;
	v_sync <= '1';
	wait for 200 ns;
	v_sync <= '0';
	
	wait for 50 ns;
	
	h_ref <= '1';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	h_ref <= '0';
	
	wait for 50 ns;
	h_ref <= '1';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	h_ref <= '0';
	
	wait for 50 ns;
	h_ref <= '1';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	h_ref <= '0';
	
	
	wait for 40 ns;
	v_sync <= '1';
	wait for 200 ns;
	v_sync <= '0';
	
	wait for 50 ns;
	
	h_ref <= '1';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	h_ref <= '0';
	
	wait for 50 ns;
	h_ref <= '1';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	h_ref <= '0';
	
	wait for 50 ns;
	h_ref <= '1';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	valid <= '1';
	wait for 10 ns;
	valid <= '0';
	h_ref <= '0';
	
	
WAIT;                                                        
END PROCESS always;                                          
END dither_engine_arch;
