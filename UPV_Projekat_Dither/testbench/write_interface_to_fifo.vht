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
-- Generated on "06/01/2021 17:24:56"
                                                            
-- Vhdl Test Bench template for design  :  write_interface
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                              
USE ieee.numeric_std.all;                                

ENTITY write_interface_vhd_tst IS
END write_interface_vhd_tst;
ARCHITECTURE write_interface_arch OF write_interface_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clk : STD_LOGIC := '1';
SIGNAL data_in : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL data_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL reset : STD_LOGIC;
SIGNAL valid : STD_LOGIC;
SIGNAL vsync : STD_LOGIC;
SIGNAL wr_req : STD_LOGIC;
COMPONENT write_interface
	PORT (
	clk : IN STD_LOGIC;
	data_in : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	data_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	reset : IN STD_LOGIC;
	valid : IN STD_LOGIC;
	vsync : IN STD_LOGIC;
	wr_req : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN


clk <= not clk after 5 ns;

	i1 : write_interface
	PORT MAP (
-- list connections between master ports and signals
	clk => clk,
	data_in => data_in,
	data_out => data_out,
	reset => reset,
	valid => valid,
	vsync => vsync,
	wr_req => wr_req
	);
init : PROCESS                                               
-- variable declarations                                     
BEGIN     
data_in <= "000";
reset <= '1';
vsync <= '0';
valid <= '0';   
wait for 20 ns;
reset <= '0';
wait for 30 ns;
data_in <= "001";
valid <= '1';   
wait for 10 ns;
valid <= '0';
wait for 10 ns;
data_in <= "010";
valid <= '1';   
wait for 10 ns;
valid <= '0';
wait for 10 ns;
data_in <= "011";
valid <= '1';   
wait for 10 ns;
valid <= '0';
wait for 10 ns;
data_in <= "100";
valid <= '1';   
wait for 10 ns;
valid <= '0';
wait for 10 ns;
data_in <= "101";
valid <= '1';   
wait for 10 ns;
valid <= '0';
wait for 10 ns;
data_in <= "110";
valid <= '1';   
wait for 10 ns;
valid <= '0';
wait for 10 ns;
data_in <= "111";
valid <= '1';   
wait for 10 ns;
valid <= '0';
wait for 10 ns;
data_in <= "110";
valid <= '1';   
wait for 10 ns;
valid <= '0';
wait for 10 ns;
data_in <= "101";
valid <= '1';   
wait for 10 ns;
valid <= '0';
wait for 10 ns;
data_in <= "100";
valid <= '1';   
wait for 10 ns;
valid <= '0';
wait for 10 ns;
data_in <= "011";
valid <= '1';   
wait for 10 ns;
valid <= '0';
wait for 10 ns;
data_in <= "010";
valid <= '1';   
wait for 10 ns;
valid <= '0';
wait for 10 ns;
data_in <= "001";
valid <= '1';   
wait for 10 ns;
valid <= '0';
wait for 10 ns;
data_in <= "000";
valid <= '1';  
wait for 10 ns;
valid <= '0';
wait for 10 ns;
data_in <= "010";
valid <= '1';   
wait for 10 ns;
valid <= '0';
wait for 10 ns;
data_in <= "011";
valid <= '1';   
wait for 10 ns;
valid <= '0';
wait for 10 ns;
data_in <= "100";
valid <= '1';   
wait for 10 ns;
valid <= '0';
wait for 10 ns;
data_in <= "100";
valid <= '1'; 
wait for 100 ns;
valid <= '0';
wait for 40 ns;
vsync <= '1';
wait for 30 ns;
vsync <= '0';
wait for 30 ns;     
data_in <= "110";
valid <= '1';   
wait for 10 ns;
valid <= '0';
wait for 10 ns;
data_in <= "111";
valid <= '1';   
wait for 10 ns;
valid <= '0';
wait for 10 ns;
data_in <= "110";
valid <= '1';   
wait for 10 ns;
valid <= '0';
wait for 10 ns;
data_in <= "101";
valid <= '1';   
wait for 10 ns;
valid <= '0';
wait for 10 ns;
data_in <= "100";
valid <= '1';   
wait for 10 ns;
valid <= '0';
wait for 10 ns;
data_in <= "011";
valid <= '1';   
wait for 10 ns;
valid <= '0';
wait for 10 ns;
data_in <= "010";
valid <= '1';   
wait for 10 ns;
valid <= '0';
wait for 10 ns;
data_in <= "001";
valid <= '1';   
wait for 10 ns;
valid <= '0';
wait for 10 ns;
data_in <= "000";
valid <= '1';  
wait for 10 ns;
valid <= '0';
wait for 10 ns;
data_in <= "010";
valid <= '1';   
wait for 10 ns;
valid <= '0';
wait for 10 ns;
data_in <= "011";
valid <= '1';   
wait for 10 ns;
valid <= '0';
wait for 10 ns;
data_in <= "100";
valid <= '1';   
wait for 10 ns;
valid <= '0';
wait for 10 ns;
data_in <= "100";
valid <= '1'; 
wait for 100 ns;
valid <= '0';                        
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
