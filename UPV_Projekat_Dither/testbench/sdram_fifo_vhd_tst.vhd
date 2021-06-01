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
-- Generated on "06/01/2021 14:18:30"
                                                            
-- Vhdl Test Bench template for design  :  sdram_fifo
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                          
USE ieee.numeric_std.all;                                

ENTITY sdram_fifo_vhd_tst IS
END sdram_fifo_vhd_tst;
ARCHITECTURE sdram_fifo_arch OF sdram_fifo_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL aclr : STD_LOGIC;
SIGNAL data : STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL q : STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL rdclk : STD_LOGIC := '1';
SIGNAL rdreq : STD_LOGIC;
SIGNAL rdusedw : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL wrclk : STD_LOGIC := '1';
SIGNAL wrreq : STD_LOGIC;
SIGNAL wrusedw : STD_LOGIC_VECTOR(5 DOWNTO 0);
COMPONENT sdram_fifo
	PORT (
	aclr : IN STD_LOGIC;
	data : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	q : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
	rdclk : IN STD_LOGIC;
	rdreq : IN STD_LOGIC;
	rdusedw : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
	wrclk : IN STD_LOGIC;
	wrreq : IN STD_LOGIC;
	wrusedw : OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : sdram_fifo
	PORT MAP (
-- list connections between master ports and signals
	aclr => aclr,
	data => data,
	q => q,
	rdclk => rdclk,
	rdreq => rdreq,
	rdusedw => rdusedw,
	wrclk => wrclk,
	wrreq => wrreq,
	wrusedw => wrusedw
	);
	
rdclk <= wrclk;

wrclk <= not wrclk after 5 ns;
	
rd_process : PROCESS                                         
BEGIN           
rdreq <= '0';
wait for 250 ns;
rdreq <= '1';
wait for 10 ns;
rdreq <= '0';
wait for 10 ns;
rdreq <= '1';
wait for 10 ns;
rdreq <= '0';
wait for 10 ns;
rdreq <= '1';
wait for 10 ns;
rdreq <= '0';
wait for 40 ns;
rdreq <= '1';
wait for 30 ns;
rdreq <= '0';
wait for 40 ns;
rdreq <= '1';

WAIT;                                                       
END PROCESS;

wr_process : PROCESS                  
BEGIN        
	data <= std_logic_vector(to_unsigned(0,64));
	wrreq <= '0';
	aclr <= '1';
	wait for 30 ns;
	aclr <= '0';      	
	wait for 20 ns;
	wrreq <= '1';
	data <= std_logic_vector(to_unsigned(1000,64));
	wait for 10 ns;
	wrreq <= '0';
	wait for 30 ns;
	wrreq <= '1';
	data <= std_logic_vector(to_unsigned(1001,64));
	wait for 10 ns;
	wrreq <= '0';
	wait for 10 ns;
	wrreq <= '1';
	data <= std_logic_vector(to_unsigned(1002,64));
	wait for 10 ns;
	data <= std_logic_vector(to_unsigned(1003,64));
	wait for 10 ns;
	data <= std_logic_vector(to_unsigned(1004,64));
	wait for 10 ns;
	data <= std_logic_vector(to_unsigned(1005,64));
	wait for 10 ns;
	wrreq <= '0';
	wait for 50 ns;
	wrreq <= '1';
	data <= std_logic_vector(to_unsigned(1010,64));
	wait for 30 ns;
	wrreq <= '0';
	
	
                    
WAIT;                                                       
END PROCESS;                                                
END sdram_fifo_arch;
