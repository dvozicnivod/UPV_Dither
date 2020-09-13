-- Copyright (C) 2017  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus bPrime License Agreement,
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
-- Generated on "08/18/2019 03:08:06"
                                                            
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
SIGNAL clk_out : STD_LOGIC;
SIGNAL data : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL G : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL Href : STD_LOGIC:='0';
SIGNAL Pclk : STD_LOGIC:='0';
SIGNAL R : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL reset : STD_LOGIC;
SIGNAL valid : STD_LOGIC;
SIGNAL Vsync : STD_LOGIC:='1';
SIGNAL x : STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL y : STD_LOGIC_VECTOR(8 DOWNTO 0);
COMPONENT cam_read
	PORT (
	B : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
	clk_out : OUT STD_LOGIC;
	data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	G : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
	Href : IN STD_LOGIC;
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
	clk_out => clk_out,
	data => data,
	G => G,
	Href => Href,
	Pclk => Pclk,
	R => R,
	reset => reset,
	valid => valid,
	Vsync => Vsync,
	x => x,
	y => y
	);
	
	Pclk <= not Pclk after 20 ns;
	
	
init : PROCESS                                               
-- variable declarations                                     
BEGIN          
	Vsync <= '1';
	Href <= '0';
	DATA <= "00000000";
	
	
	WAIT for 80 ns;
	Vsync <= '0';
	
	WAIT for 80 ns;
	Href <= '1';
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	Href <= '0';
	
	wait for 80 ns;
	Href <= '1';
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	Href <= '0';
	
	wait for 80 ns;
	Href <= '1';
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	Href <= '0';
	
	WAIT for 80 ns;
	Vsync <= '1';
	
	
	WAIT for 80 ns;
	Vsync <= '0';
	
	WAIT for 80 ns;
	Href <= '1';
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	Href <= '0';
	
	wait for 80 ns;
	Href <= '1';
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	Href <= '0';
	
	wait for 80 ns;
	Href <= '1';
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	Href <= '0';
	
	WAIT for 80 ns;
	Vsync <= '1';
	
	
	WAIT for 80 ns;
	Vsync <= '0';
	
	WAIT for 80 ns;
	Href <= '1';
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	Href <= '0';
	
	wait for 80 ns;
	Href <= '1';
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	Href <= '0';
	
	wait for 80 ns;
	Href <= '1';
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	Href <= '0';
	
	WAIT for 80 ns;
	Vsync <= '1';
	
	
	WAIT for 80 ns;
	Vsync <= '0';
	
	WAIT for 80 ns;
	Href <= '1';
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	Href <= '0';
	
	wait for 80 ns;
	Href <= '1';
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	Href <= '0';
	
	wait for 80 ns;
	Href <= '1';
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	DATA <= "11110000";
	WAIT for 40 ns;
	DATA <= "00001111";
	WAIT for 40 ns;
	Href <= '0';
	
	WAIT for 80 ns;
	Vsync <= '1';
	
	
WAIT;                                                       
END PROCESS init;     

                                                            
END cam_read_arch;
