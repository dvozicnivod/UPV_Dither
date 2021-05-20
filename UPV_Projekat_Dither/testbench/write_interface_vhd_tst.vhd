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
-- Generated on "05/20/2021 15:41:05"
                                                            
-- Vhdl Test Bench template for design  :  write_interface
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;    
use IEEE.numeric_std.all;                            

ENTITY write_interface_vhd_tst IS
END write_interface_vhd_tst;
ARCHITECTURE write_interface_arch OF write_interface_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL address_out : STD_LOGIC_VECTOR(18 DOWNTO 0);
SIGNAL clk : STD_LOGIC := '1';
SIGNAL data_in : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL data_out : STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL reset : STD_LOGIC;
SIGNAL valid : STD_LOGIC;
SIGNAL xpos : STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL ypos : STD_LOGIC_VECTOR(8 DOWNTO 0);
COMPONENT write_interface
	PORT (
	address_out : OUT STD_LOGIC_VECTOR(18 DOWNTO 0);
	clk : IN STD_LOGIC;
	data_in : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	data_out : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
	reset : IN STD_LOGIC;
	valid : IN STD_LOGIC;
	xpos : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
	ypos : IN STD_LOGIC_VECTOR(8 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : write_interface
	PORT MAP (
-- list connections between master ports and signals
	address_out => address_out,
	clk => clk,
	data_in => data_in,
	data_out => data_out,
	reset => reset,
	valid => valid,
	xpos => xpos,
	ypos => ypos
	);
	
	
clk <= not clk after 5 ns;
	
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


	data_in <= std_logic_vector(to_unsigned(0,3));
	reset <= '1';
	valid <= '0';
	xpos <= std_logic_vector(to_unsigned(0,10)); 

	wait for 20 ns;
	
	reset <= '0';

	wait for 20 ns;
	
	ypos <= std_logic_vector(to_unsigned(0,9));

	data_in <= std_logic_vector(to_unsigned(1,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(0,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(2,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(1,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(3,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(2,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(4,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(3,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(5,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(4,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(6,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(5,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(7,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(6,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(0,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(7,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(1,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(8,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(2,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(9,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(3,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(10,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(4,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(11,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(5,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(12,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(6,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(13,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(7,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(14,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(0,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(15,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(1,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(16,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(2,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(17,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(3,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(18,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(4,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(19,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(5,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(20,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(6,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(21,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(7,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(22,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(0,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(23,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(1,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(24,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(2,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(25,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(3,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(26,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(4,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(27,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(5,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(28,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(6,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(29,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(7,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(30,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(0,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(31,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	
	ypos <= std_logic_vector(to_unsigned(1,9));

	data_in <= std_logic_vector(to_unsigned(1,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(0,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(2,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(1,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(3,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(2,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(4,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(3,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(5,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(4,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(6,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(5,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(7,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(6,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(0,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(7,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(1,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(8,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(2,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(9,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(3,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(10,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(4,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(11,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(5,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(12,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(6,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(13,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(7,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(14,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(0,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(15,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(1,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(16,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(2,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(17,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(3,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(18,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(4,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(19,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(5,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(20,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(6,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(21,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(7,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(22,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(0,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(23,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(1,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(24,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(2,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(25,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(3,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(26,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(4,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(27,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(5,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(28,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(6,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(29,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(7,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(30,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(0,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(31,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;
	
	ypos <= std_logic_vector(to_unsigned(2,9));

	data_in <= std_logic_vector(to_unsigned(1,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(0,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(2,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(1,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(3,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(2,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(4,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(3,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(5,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(4,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(6,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(5,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(7,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(6,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(0,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(7,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(1,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(8,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(2,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(9,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(3,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(10,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(4,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(11,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(5,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(12,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(6,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(13,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(7,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(14,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(0,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(15,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(1,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(16,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(2,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(17,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(3,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(18,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(4,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(19,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(5,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(20,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(6,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(21,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(7,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(22,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(0,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(23,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(1,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(24,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(2,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(25,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(3,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(26,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(4,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(27,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(5,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(28,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(6,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(29,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(7,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(30,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

	data_in <= std_logic_vector(to_unsigned(0,3));
	valid <= '1';
	xpos <= std_logic_vector(to_unsigned(31,10)); 
	wait for 10 ns;
	valid <= '0';
	wait for 10 ns;

                                           
        -- code executes for every event on sensitivity list  
WAIT;                                                        
END PROCESS always;                                          
END write_interface_arch;
