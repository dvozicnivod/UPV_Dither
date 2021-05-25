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
-- Generated on "05/21/2021 19:57:15"
                                                            
-- Vhdl Test Bench template for design  :  read_interface
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all; 
use IEEE.numeric_std.all;                               

ENTITY read_interface_vhd_tst IS
END read_interface_vhd_tst;
ARCHITECTURE read_interface_arch OF read_interface_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clk : STD_LOGIC := '1';
SIGNAL data_out : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL read_address : STD_LOGIC_VECTOR(21 DOWNTO 0);
SIGNAL read_data : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL reset : STD_LOGIC;
SIGNAL v_sync : STD_LOGIC;
SIGNAL valid : STD_LOGIC;
SIGNAL xpos : STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL ypos : STD_LOGIC_VECTOR(8 DOWNTO 0);
COMPONENT read_interface
	generic
	(
		FRAME_WIDTH : integer := 640;
		NUM_BYTES : integer := 4;
		ADDRESS_WIDTH : integer := 22
	);
	port
	(
		clk : in std_logic;
		reset : in std_logic;
		xpos : in std_logic_vector(9 downto 0); 
		ypos : in std_logic_vector(8 downto 0);
		valid : in std_logic;
		v_sync : in std_logic;
		read_address : out std_logic_vector(ADDRESS_WIDTH-1 downto 0);
		read_data : in std_logic_vector(31 downto 0);
		data_out : out std_logic_vector(2 downto 0)
 	);
END COMPONENT;
BEGIN
	i1 : read_interface
	generic map
 	(
		FRAME_WIDTH => 32,
		NUM_BYTES => 4,
		ADDRESS_WIDTH => 22
	)
	PORT MAP (
-- list connections between master ports and signals
	clk => clk,
	data_out => data_out,
	read_address => read_address,
	read_data => read_data,
	reset => reset,
	v_sync => v_sync,
	valid => valid,
	xpos => xpos,
	ypos => ypos
	);
	
init : PROCESS                                               
-- variable declarations                                     
BEGIN                    

wait for 50 ns;
read_data <= "00110010000100000011001000010000"; 
wait for 50 ns;
read_data <= "01010100001100100101010000110010"; 
wait for 50 ns;
read_data <= "01100101010000110110010101000011"; 
wait for 50 ns;
read_data <= "01110110010101000111011001010100"; 
wait for 50 ns;
read_data <= "00000111011001010000011101100101"; 
wait for 50 ns;
read_data <= "00010000011101100001000001110110"; 
wait for 50 ns;
read_data <= "00100001000001110010000100000111"; 
wait for 50 ns;
read_data <= "00110010000100000011001000010000"; 
wait for 50 ns;
read_data <= "01000011001000010100001100100001"; 
wait for 50 ns;
wait for 50 ns;
read_data <= "00110010000100000011001000010000"; 
wait for 50 ns;
read_data <= "01010100001100100101010000110010"; 
wait for 50 ns;
read_data <= "01100101010000110110010101000011"; 
wait for 50 ns;
read_data <= "01110110010101000111011001010100"; 
wait for 50 ns;
read_data <= "00000111011001010000011101100101"; 
wait for 50 ns;
read_data <= "00010000011101100001000001110110"; 
wait for 50 ns;
read_data <= "00100001000001110010000100000111"; 
wait for 50 ns;
read_data <= "00110010000100000011001000010000"; 
wait for 50 ns;
read_data <= "01000011001000010100001100100001"; 
wait for 50 ns;
wait for 50 ns;
read_data <= "00110010000100000011001000010000"; 
wait for 50 ns;
read_data <= "01010100001100100101010000110010"; 
wait for 50 ns;
read_data <= "01100101010000110110010101000011"; 
wait for 50 ns;
read_data <= "01110110010101000111011001010100"; 
wait for 50 ns;
read_data <= "00000111011001010000011101100101"; 
wait for 50 ns;
read_data <= "00010000011101100001000001110110"; 
wait for 50 ns;
read_data <= "00100001000001110010000100000111"; 
wait for 50 ns;
read_data <= "00110010000100000011001000010000"; 
wait for 50 ns;
read_data <= "01000011001000010100001100100001"; 
wait for 50 ns;
wait for 50 ns;
read_data <= "00110010000100000011001000010000"; 
wait for 50 ns;
read_data <= "01010100001100100101010000110010"; 
wait for 50 ns;
read_data <= "01100101010000110110010101000011"; 
wait for 50 ns;
read_data <= "01110110010101000111011001010100"; 
wait for 50 ns;
read_data <= "00000111011001010000011101100101"; 
wait for 50 ns;
read_data <= "00010000011101100001000001110110"; 
wait for 50 ns;
read_data <= "00100001000001110010000100000111"; 
wait for 50 ns;
read_data <= "00110010000100000011001000010000"; 
wait for 50 ns;
read_data <= "01000011001000010100001100100001"; 
wait for 50 ns;
wait for 50 ns;
read_data <= "00110010000100000011001000010000"; 
wait for 50 ns;
read_data <= "01010100001100100101010000110010"; 
wait for 50 ns;
read_data <= "01100101010000110110010101000011"; 
wait for 50 ns;
read_data <= "01110110010101000111011001010100"; 
wait for 50 ns;
read_data <= "00000111011001010000011101100101"; 
wait for 50 ns;
read_data <= "00010000011101100001000001110110"; 
wait for 50 ns;
read_data <= "00100001000001110010000100000111"; 
wait for 50 ns;
read_data <= "00110010000100000011001000010000"; 
wait for 50 ns;
read_data <= "01000011001000010100001100100001"; 
wait for 50 ns;
wait for 50 ns;
read_data <= "00110010000100000011001000010000"; 
wait for 50 ns;
read_data <= "01010100001100100101010000110010"; 
wait for 50 ns;
read_data <= "01100101010000110110010101000011"; 
wait for 50 ns;
read_data <= "01110110010101000111011001010100"; 
wait for 50 ns;
read_data <= "00000111011001010000011101100101"; 
wait for 50 ns;
read_data <= "00010000011101100001000001110110"; 
wait for 50 ns;
read_data <= "00100001000001110010000100000111"; 
wait for 50 ns;
read_data <= "00110010000100000011001000010000"; 
wait for 50 ns;
read_data <= "01000011001000010100001100100001"; 
wait for 50 ns;
wait for 50 ns;
read_data <= "00110010000100000011001000010000"; 
wait for 50 ns;
read_data <= "01010100001100100101010000110010"; 
wait for 50 ns;
read_data <= "01100101010000110110010101000011"; 
wait for 50 ns;
read_data <= "01110110010101000111011001010100"; 
wait for 50 ns;
read_data <= "00000111011001010000011101100101"; 
wait for 50 ns;
read_data <= "00010000011101100001000001110110"; 
wait for 50 ns;
read_data <= "00100001000001110010000100000111"; 
wait for 50 ns;
read_data <= "00110010000100000011001000010000"; 
wait for 50 ns;
read_data <= "01000011001000010100001100100001"; 
wait for 50 ns;
wait for 50 ns;
read_data <= "00110010000100000011001000010000"; 
wait for 50 ns;
read_data <= "01010100001100100101010000110010"; 
wait for 50 ns;
read_data <= "01100101010000110110010101000011"; 
wait for 50 ns;
read_data <= "01110110010101000111011001010100"; 
wait for 50 ns;
read_data <= "00000111011001010000011101100101"; 
wait for 50 ns;
read_data <= "00010000011101100001000001110110"; 
wait for 50 ns;
read_data <= "00100001000001110010000100000111"; 
wait for 50 ns;
read_data <= "00110010000100000011001000010000"; 
wait for 50 ns;
read_data <= "01000011001000010100001100100001"; 
wait for 50 ns;
wait for 50 ns;
read_data <= "00110010000100000011001000010000"; 
wait for 50 ns;
read_data <= "01010100001100100101010000110010"; 
wait for 50 ns;
read_data <= "01100101010000110110010101000011"; 
wait for 50 ns;
read_data <= "01110110010101000111011001010100"; 
wait for 50 ns;
read_data <= "00000111011001010000011101100101"; 
wait for 50 ns;
read_data <= "00010000011101100001000001110110"; 
wait for 50 ns;
read_data <= "00100001000001110010000100000111"; 
wait for 50 ns;
read_data <= "00110010000100000011001000010000"; 
wait for 50 ns;
read_data <= "01000011001000010100001100100001"; 
wait for 50 ns;
wait for 50 ns;
read_data <= "00110010000100000011001000010000"; 
wait for 50 ns;
read_data <= "01010100001100100101010000110010"; 
wait for 50 ns;
read_data <= "01100101010000110110010101000011"; 
wait for 50 ns;
read_data <= "01110110010101000111011001010100"; 
wait for 50 ns;
read_data <= "00000111011001010000011101100101"; 
wait for 50 ns;
read_data <= "00010000011101100001000001110110"; 
wait for 50 ns;
read_data <= "00100001000001110010000100000111"; 
wait for 50 ns;
read_data <= "00110010000100000011001000010000"; 
wait for 50 ns;
read_data <= "01000011001000010100001100100001"; 
wait for 50 ns;
                           
        -- code that executes only once                      
WAIT;                                                       
END PROCESS init;    

clk <= not clk after 5 ns;
                                       
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                

reset <= '1';
v_sync <= '0';
valid <= '0';
xpos <= std_logic_vector(to_unsigned(0 ,10));
ypos <= std_logic_vector(to_unsigned(0 ,9));
--read_data <= (others => '0');
wait for 10 ns;

reset <= '0';

v_sync <= '0';
valid <= '0';
xpos <= std_logic_vector(to_unsigned(0 ,10));
ypos <= std_logic_vector(to_unsigned(0 ,9));
--read_data <= "01000011001000010100001100100001";
wait for 10 ns;

v_sync <= '1';
wait for 40 ns;

v_sync <= '0';
wait for 40 ns;

valid <= '1';
ypos <= std_logic_vector(to_unsigned(0 ,9));
xpos <= std_logic_vector(to_unsigned(0 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(1 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(2 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(3 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(4 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(5 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(6 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(7 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(8 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(9 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(10 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(11 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(12 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(13 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(14 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(15 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(16 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(17 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(18 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(19 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(20 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(21 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(22 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(23 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(24 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(25 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(26 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(27 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(28 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(29 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(30 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(31 ,10));

wait for 10 ns;
valid <= '0';
xpos <= std_logic_vector(to_unsigned(32 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(33 ,10));

wait for 10 ns;
valid <= '0';
xpos <= std_logic_vector(to_unsigned(34 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(35 ,10));

wait for 10 ns;

valid <= '1';
ypos <= std_logic_vector(to_unsigned(1 ,9));
xpos <= std_logic_vector(to_unsigned(0 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(1 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(2 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(3 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(4 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(5 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(6 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(7 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(8 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(9 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(10 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(11 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(12 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(13 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(14 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(15 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(16 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(17 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(18 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(19 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(20 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(21 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(22 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(23 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(24 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(25 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(26 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(27 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(28 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(29 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(30 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(31 ,10));

wait for 10 ns;
valid <= '0';
xpos <= std_logic_vector(to_unsigned(32 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(33 ,10));

wait for 10 ns;
valid <= '0';
xpos <= std_logic_vector(to_unsigned(34 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(35 ,10));

wait for 10 ns;

valid <= '1';
ypos <= std_logic_vector(to_unsigned(2 ,9));
xpos <= std_logic_vector(to_unsigned(0 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(1 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(2 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(3 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(4 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(5 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(6 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(7 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(8 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(9 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(10 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(11 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(12 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(13 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(14 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(15 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(16 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(17 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(18 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(19 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(20 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(21 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(22 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(23 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(24 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(25 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(26 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(27 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(28 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(29 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(30 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(31 ,10));

wait for 10 ns;
valid <= '0';
xpos <= std_logic_vector(to_unsigned(32 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(33 ,10));

wait for 10 ns;
valid <= '0';
xpos <= std_logic_vector(to_unsigned(34 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(35 ,10));

wait for 10 ns;

valid <= '1';
ypos <= std_logic_vector(to_unsigned(3 ,9));
xpos <= std_logic_vector(to_unsigned(0 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(1 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(2 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(3 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(4 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(5 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(6 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(7 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(8 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(9 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(10 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(11 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(12 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(13 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(14 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(15 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(16 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(17 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(18 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(19 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(20 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(21 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(22 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(23 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(24 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(25 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(26 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(27 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(28 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(29 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(30 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(31 ,10));

wait for 10 ns;
valid <= '0';
xpos <= std_logic_vector(to_unsigned(32 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(33 ,10));

wait for 10 ns;
valid <= '0';
xpos <= std_logic_vector(to_unsigned(34 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(35 ,10));

wait for 40 ns;

v_sync <= '1';
wait for 40 ns;
v_sync <= '0';
wait for 40 ns;


valid <= '1';
ypos <= std_logic_vector(to_unsigned(0 ,9));
xpos <= std_logic_vector(to_unsigned(0 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(1 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(2 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(3 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(4 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(5 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(6 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(7 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(8 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(9 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(10 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(11 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(12 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(13 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(14 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(15 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(16 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(17 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(18 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(19 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(20 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(21 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(22 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(23 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(24 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(25 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(26 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(27 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(28 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(29 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(30 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(31 ,10));

wait for 10 ns;
valid <= '0';
xpos <= std_logic_vector(to_unsigned(32 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(33 ,10));

wait for 10 ns;
valid <= '0';
xpos <= std_logic_vector(to_unsigned(34 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(35 ,10));

wait for 10 ns;

valid <= '1';
ypos <= std_logic_vector(to_unsigned(1 ,9));
xpos <= std_logic_vector(to_unsigned(0 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(1 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(2 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(3 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(4 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(5 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(6 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(7 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(8 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(9 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(10 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(11 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(12 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(13 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(14 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(15 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(16 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(17 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(18 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(19 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(20 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(21 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(22 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(23 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(24 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(25 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(26 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(27 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(28 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(29 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(30 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(31 ,10));

wait for 10 ns;
valid <= '0';
xpos <= std_logic_vector(to_unsigned(32 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(33 ,10));

wait for 10 ns;
valid <= '0';
xpos <= std_logic_vector(to_unsigned(34 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(35 ,10));

wait for 10 ns;

valid <= '1';
ypos <= std_logic_vector(to_unsigned(2 ,9));
xpos <= std_logic_vector(to_unsigned(0 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(1 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(2 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(3 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(4 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(5 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(6 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(7 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(8 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(9 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(10 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(11 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(12 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(13 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(14 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(15 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(16 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(17 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(18 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(19 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(20 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(21 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(22 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(23 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(24 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(25 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(26 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(27 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(28 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(29 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(30 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(31 ,10));

wait for 10 ns;
valid <= '0';
xpos <= std_logic_vector(to_unsigned(32 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(33 ,10));

wait for 10 ns;
valid <= '0';
xpos <= std_logic_vector(to_unsigned(34 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(35 ,10));

wait for 10 ns;

valid <= '1';
ypos <= std_logic_vector(to_unsigned(3 ,9));
xpos <= std_logic_vector(to_unsigned(0 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(1 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(2 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(3 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(4 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(5 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(6 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(7 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(8 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(9 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(10 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(11 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(12 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(13 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(14 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(15 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(16 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(17 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(18 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(19 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(20 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(21 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(22 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(23 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(24 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(25 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(26 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(27 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(28 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(29 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(30 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(31 ,10));

wait for 10 ns;
valid <= '0';
xpos <= std_logic_vector(to_unsigned(32 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(33 ,10));

wait for 10 ns;
valid <= '0';
xpos <= std_logic_vector(to_unsigned(34 ,10));

wait for 10 ns;
xpos <= std_logic_vector(to_unsigned(35 ,10));

wait for 40 ns;

v_sync <= '1';
wait for 40 ns;
v_sync <= '0';


                                         
        -- code executes for every event on sensitivity list  
WAIT;                                                        
END PROCESS always;                                          
END read_interface_arch;
