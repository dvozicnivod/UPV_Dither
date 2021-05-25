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
-- Generated on "05/25/2021 16:25:57"
                                                            
-- Vhdl Test Bench template for design  :  cam_read
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY cam_read_vhd_tst IS
END cam_read_vhd_tst;
ARCHITECTURE cam_read_arch OF cam_read_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL B : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL data : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL G : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL Href : STD_LOGIC;
SIGNAL href_out : STD_LOGIC;
SIGNAL Pclk : STD_LOGIC := '1';
SIGNAL R : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL reset : STD_LOGIC;
SIGNAL valid : STD_LOGIC;
SIGNAL Vsync : STD_LOGIC;
SIGNAL x : STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL y : STD_LOGIC_VECTOR(8 DOWNTO 0);
COMPONENT cam_read
	PORT (
	B : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
	data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	G : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
	Href : IN STD_LOGIC;
	href_out : OUT STD_LOGIC;
	Pclk : IN STD_LOGIC;
	R : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
	reset : IN STD_LOGIC;
	valid : OUT STD_LOGIC;
	Vsync : IN STD_LOGIC;
	x : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
	y : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : cam_read
	PORT MAP (
-- list connections between master ports and signals
	B => B,
	data => data,
	G => G,
	Href => Href,
	href_out => href_out,
	Pclk => Pclk,
	R => R,
	reset => reset,
	valid => valid,
	Vsync => Vsync,
	x => x,
	y => y
	);
	
	Pclk <= not Pclk after 5 ns;
	
	
init : PROCESS                                               
-- variable declarations                                     
BEGIN       

	data <= "01010101";
	Href <= '0';
	reset <= '1';
	Vsync <= '0';
	wait for 40 ns;

	data <= "01010101";
	Href <= '0';
	reset <= '0';
	Vsync <= '0';
	wait for 50 ns;

	data <= "01010101";
	Href <= '1';
	Vsync <= '0';
	wait for 80 ns;

	data <= "01010101";
	Href <= '0';
	Vsync <= '0';
	wait for 50 ns;

	data <= "01010101";
	Href <= '1';
	Vsync <= '0';
	wait for 80 ns;

	data <= "01010101";
	Href <= '0';
	Vsync <= '0';
	wait for 50 ns;

	data <= "01010101";
	Href <= '1';
	Vsync <= '0';
	wait for 80 ns;

	data <= "01010101";
	Href <= '0';
	Vsync <= '0';
	wait for 50 ns;

	data <= "01010101";
	Href <= '1';
	Vsync <= '0';
	wait for 80 ns;

	data <= "01010101";
	Href <= '0';
	Vsync <= '0';
	wait for 50 ns;

	data <= "01010101";
	Href <= '0';
	Vsync <= '1';
	wait for 50 ns;

	data <= "01010101";
	Href <= '0';
	reset <= '0';
	Vsync <= '0';
	wait for 50 ns;

	data <= "01010101";
	Href <= '1';
	Vsync <= '0';
	wait for 80 ns;

	data <= "01010101";
	Href <= '0';
	Vsync <= '0';
	wait for 50 ns;

	data <= "01010101";
	Href <= '1';
	Vsync <= '0';
	wait for 80 ns;

	data <= "01010101";
	Href <= '0';
	Vsync <= '0';
	wait for 50 ns;

	data <= "01010101";
	Href <= '1';
	Vsync <= '0';
	wait for 80 ns;

	data <= "01010101";
	Href <= '0';
	Vsync <= '0';
	wait for 50 ns;

	data <= "01010101";
	Href <= '1';
	Vsync <= '0';
	wait for 80 ns;

	data <= "01010101";
	Href <= '0';
	Vsync <= '0';
	wait for 50 ns;

	data <= "01010101";
	Href <= '0';
	Vsync <= '1';
	wait for 50 ns;

	data <= "01010101";
	Href <= '0';
	reset <= '0';
	Vsync <= '0';
	wait for 50 ns;

	data <= "01010101";
	Href <= '1';
	Vsync <= '0';
	wait for 80 ns;

	data <= "01010101";
	Href <= '0';
	Vsync <= '0';
	wait for 50 ns;

	data <= "01010101";
	Href <= '1';
	Vsync <= '0';
	wait for 80 ns;

	data <= "01010101";
	Href <= '0';
	Vsync <= '0';
	wait for 50 ns;

	data <= "01010101";
	Href <= '1';
	Vsync <= '0';
	wait for 80 ns;

	data <= "01010101";
	Href <= '0';
	Vsync <= '0';
	wait for 50 ns;

	data <= "01010101";
	Href <= '1';
	Vsync <= '0';
	wait for 80 ns;

	data <= "01010101";
	Href <= '0';
	Vsync <= '0';
	wait for 50 ns;

	data <= "01010101";
	Href <= '0';
	Vsync <= '1';
	wait for 50 ns;

	data <= "01010101";
	Href <= '0';
	reset <= '0';
	Vsync <= '0';
	wait for 50 ns;

	data <= "01010101";
	Href <= '1';
	Vsync <= '0';
	wait for 80 ns;

	data <= "01010101";
	Href <= '0';
	Vsync <= '0';
	wait for 50 ns;

	data <= "01010101";
	Href <= '1';
	Vsync <= '0';
	wait for 80 ns;

	data <= "01010101";
	Href <= '0';
	Vsync <= '0';
	wait for 50 ns;

	data <= "01010101";
	Href <= '1';
	Vsync <= '0';
	wait for 80 ns;

	data <= "01010101";
	Href <= '0';
	Vsync <= '0';
	wait for 50 ns;

	data <= "01010101";
	Href <= '1';
	Vsync <= '0';
	wait for 80 ns;

	data <= "01010101";
	Href <= '0';
	Vsync <= '0';
	wait for 50 ns;

	data <= "01010101";
	Href <= '0';
	Vsync <= '1';
	wait for 50 ns;

	data <= "01010101";
	Href <= '0';
	reset <= '0';
	Vsync <= '0';
	wait for 50 ns;

	data <= "01010101";
	Href <= '1';
	Vsync <= '0';
	wait for 80 ns;

	data <= "01010101";
	Href <= '0';
	Vsync <= '0';
	wait for 50 ns;

	data <= "01010101";
	Href <= '1';
	Vsync <= '0';
	wait for 80 ns;

	data <= "01010101";
	Href <= '0';
	Vsync <= '0';
	wait for 50 ns;

	data <= "01010101";
	Href <= '1';
	Vsync <= '0';
	wait for 80 ns;

	data <= "01010101";
	Href <= '0';
	Vsync <= '0';
	wait for 50 ns;

	data <= "01010101";
	Href <= '1';
	Vsync <= '0';
	wait for 80 ns;

	data <= "01010101";
	Href <= '0';
	Vsync <= '0';
	wait for 50 ns;

	data <= "01010101";
	Href <= '0';
	Vsync <= '1';
	wait for 50 ns;
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
END cam_read_arch;
