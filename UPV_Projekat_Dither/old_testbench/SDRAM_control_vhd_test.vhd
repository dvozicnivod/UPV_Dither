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
-- Generated on "09/07/2019 03:49:35"
                                                            
-- Vhdl Test Bench template for design  :  SDRAM_control
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                
USE ieee.numeric_std.all;                                

ENTITY SDRAM_control_vhd_tst IS
END SDRAM_control_vhd_tst;
ARCHITECTURE SDRAM_control_arch OF SDRAM_control_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL a_read : STD_LOGIC_VECTOR(21 DOWNTO 0);
SIGNAL a_sdram : STD_LOGIC_VECTOR(13 DOWNTO 0);
SIGNAL a_write : STD_LOGIC_VECTOR(21 DOWNTO 0);
SIGNAL cas_n : STD_LOGIC;
SIGNAL clk : STD_LOGIC := '0';
SIGNAL clk_en : STD_LOGIC;
SIGNAL cs_n : STD_LOGIC;
SIGNAL d_read : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL d_write : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL dq_sdram : STD_LOGIC_VECTOR(15 DOWNTO 0) := (others => 'Z');
SIGNAL dqmh : STD_LOGIC;
SIGNAL dqml : STD_LOGIC;
SIGNAL r_complete : STD_LOGIC;
SIGNAL ras_n : STD_LOGIC;
SIGNAL reset : STD_LOGIC;
SIGNAL w_complete : STD_LOGIC;
SIGNAL we_n : STD_LOGIC;
COMPONENT SDRAM_control
	GENERIC(
		SETUP_CYCLES:integer := 3	--How many cycles to wait before starting initialization
	);
	PORT (
	a_read : IN STD_LOGIC_VECTOR(21 DOWNTO 0);
	a_sdram : OUT STD_LOGIC_VECTOR(13 DOWNTO 0);
	a_write : IN STD_LOGIC_VECTOR(21 DOWNTO 0);
	cas_n : OUT STD_LOGIC;
	clk : IN STD_LOGIC;
	clk_en : OUT STD_LOGIC;
	cs_n : OUT STD_LOGIC;
	d_read : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	d_write : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	dq_sdram : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	dqmh : OUT STD_LOGIC;
	dqml : OUT STD_LOGIC;
	r_complete : OUT STD_LOGIC;
	ras_n : OUT STD_LOGIC;
	reset : IN STD_LOGIC;
	w_complete : OUT STD_LOGIC;
	we_n : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : SDRAM_control
	GENERIC MAP(
		3
	)
	PORT MAP (
-- list connections between master ports and signals
	a_read => a_read,
	a_sdram => a_sdram,
	a_write => a_write,
	cas_n => cas_n,
	clk => clk,
	clk_en => clk_en,
	cs_n => cs_n,
	d_read => d_read,
	d_write => d_write,
	dq_sdram => dq_sdram,
	dqmh => dqmh,
	dqml => dqml,
	r_complete => r_complete,
	ras_n => ras_n,
	reset => reset,
	w_complete => w_complete,
	we_n => we_n
	);
	a_write <= "1100110011001100111100";
	d_write <= "01010101010101010101010101010101";
	a_read <= "1100110011001100111100";
	
	clk <= not clk after 5 ps;
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
END SDRAM_control_arch;
