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
-- Generated on "12/22/2019 16:32:23"
                                                            
-- Vhdl Test Bench template for design  :  cam_mem_uart
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY cam_mem_uart_vhd_tst IS
END cam_mem_uart_vhd_tst;
ARCHITECTURE cam_mem_uart_arch OF cam_mem_uart_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL adr : STD_LOGIC_VECTOR(18 DOWNTO 0);
SIGNAL button : STD_LOGIC;
SIGNAL clk : STD_LOGIC := '0';
SIGNAL reset : STD_LOGIC;
SIGNAL tx_busy : STD_LOGIC;
SIGNAL tx_en : STD_LOGIC;
COMPONENT cam_mem_uart
	generic (
		NUM_PXS :integer :=  640 * 480
	);
	PORT (
	adr : OUT STD_LOGIC_VECTOR(18 DOWNTO 0);
	button : IN STD_LOGIC;
	clk : IN STD_LOGIC;
	reset : IN STD_LOGIC;
	tx_busy : IN STD_LOGIC;
	tx_en : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : cam_mem_uart
	GENERIC MAP (10)
	PORT MAP (
-- list connections between master ports and signals
	adr => adr,
	button => button,
	clk => clk,
	reset => reset,
	tx_busy => tx_busy,
	tx_en => tx_en
	);              
	 
clk <= not clk after 10 ns;  
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                   
BEGIN                    
	button <= '0';
	reset <= '0';
	tx_busy <= '0';
	wait for 80 ns;
	button <= '1';
	reset <= '0';
	tx_busy <= '0';
	wait for 100 ns;
	button <= '1';
	reset <= '0';
	tx_busy <= '1';
	wait for 210 ns;
	button <= '1';
	reset <= '0';
	tx_busy <= '0';
	wait for 100 ns;
	button <= '1';
	reset <= '0';
	tx_busy <= '1';
	wait for 210 ns;
	button <= '1';
	reset <= '0';
	tx_busy <= '0';
	wait for 100 ns;
	button <= '1';
	reset <= '0';
	tx_busy <= '1';
	wait for 210 ns;
	button <= '1';
	reset <= '0';
	tx_busy <= '0';
	wait for 100 ns;
	button <= '1';
	reset <= '0';
	tx_busy <= '1';
	wait for 210 ns;
	button <= '1';
	reset <= '0';
	tx_busy <= '0';
	wait for 100 ns;
	button <= '1';
	reset <= '0';
	tx_busy <= '1';
	wait for 210 ns;
	button <= '1';
	reset <= '0';
	tx_busy <= '0';
	wait for 100 ns;
	button <= '1';
	reset <= '0';
	tx_busy <= '1';
	wait for 210 ns;
	button <= '1';
	reset <= '0';
	tx_busy <= '0';
	wait for 100 ns;
	button <= '1';
	reset <= '0';
	tx_busy <= '1';
	wait for 210 ns;
	button <= '1';
	reset <= '0';
	tx_busy <= '0';
	wait for 100 ns;
	button <= '1';
	reset <= '0';
	tx_busy <= '1';
	wait for 210 ns;
	button <= '1';
	reset <= '0';
	tx_busy <= '0';
	wait for 100 ns;
	button <= '1';
	reset <= '0';
	tx_busy <= '1';
	wait for 210 ns;
	button <= '1';
	reset <= '0';
	tx_busy <= '0';
	wait for 100 ns;
	button <= '1';
	reset <= '0';
	tx_busy <= '1';
	wait for 210 ns;
	button <= '1';
	reset <= '0';
	tx_busy <= '0';
	wait for 100 ns;
	button <= '1';
	reset <= '0';
	tx_busy <= '1';
	wait for 210 ns;
	button <= '1';
	reset <= '0';
	tx_busy <= '0';
	wait for 100 ns;
	button <= '0';
	reset <= '0';
	tx_busy <= '1';
	wait for 210 ns;
	button <= '0';
	reset <= '0';
	tx_busy <= '0';
	wait for 100 ns;
	button <= '0';
	reset <= '0';
	tx_busy <= '1';
	wait for 210 ns;
	button <= '0';
	reset <= '0';
	tx_busy <= '0';
	wait for 100 ns;
	button <= '0';
	reset <= '0';
	tx_busy <= '1';
	wait for 210 ns;
	button <= '0';
	reset <= '0';
	tx_busy <= '0';
	wait for 100 ns;
	button <= '0';
	reset <= '0';
	tx_busy <= '1';
	wait for 210 ns;
	button <= '0';
	reset <= '0';
	tx_busy <= '0';
	wait for 100 ns;
	button <= '0';
	reset <= '0';
	tx_busy <= '1';
WAIT;                                                        
END PROCESS always;                                          
END cam_mem_uart_arch;
