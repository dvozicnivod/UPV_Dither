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
-- Generated on "05/30/2021 18:44:31"
                                                            
-- Vhdl Test Bench template for design  :  SDRAM_control_B4_fifo
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY SDRAM_control_B4_fifo_vhd_tst IS
END SDRAM_control_B4_fifo_vhd_tst;
ARCHITECTURE SDRAM_control_B4_fifo_arch OF SDRAM_control_B4_fifo_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL a_sdram : STD_LOGIC_VECTOR(13 DOWNTO 0);
SIGNAL cas_n : STD_LOGIC;
SIGNAL clk : STD_LOGIC := '1';
SIGNAL clk_en : STD_LOGIC;
SIGNAL cs_n : STD_LOGIC;
SIGNAL dq_sdram : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL dqmh : STD_LOGIC;
SIGNAL dqml : STD_LOGIC;
SIGNAL ras_n : STD_LOGIC;
SIGNAL rd_reset : STD_LOGIC;
SIGNAL rdclk : STD_LOGIC := '1';
SIGNAL rdreq : STD_LOGIC;
SIGNAL read_q : STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL read_usedw : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL reset : STD_LOGIC := '0';
SIGNAL we_n : STD_LOGIC;
SIGNAL wr_reset : STD_LOGIC;
SIGNAL wrclk : STD_LOGIC := '1';
SIGNAL write_d : STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL write_usedw : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL wrreq : STD_LOGIC;
COMPONENT SDRAM_control_B4_fifo
	PORT (
	a_sdram : OUT STD_LOGIC_VECTOR(13 DOWNTO 0);
	cas_n : OUT STD_LOGIC;
	clk : IN STD_LOGIC;
	clk_en : OUT STD_LOGIC;
	cs_n : OUT STD_LOGIC;
	dq_sdram : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	dqmh : OUT STD_LOGIC;
	dqml : OUT STD_LOGIC;
	ras_n : OUT STD_LOGIC;
	rd_reset : IN STD_LOGIC;
	rdclk : IN STD_LOGIC;
	rdreq : IN STD_LOGIC;
	read_q : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
	read_usedw : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
	reset : IN STD_LOGIC;
	we_n : OUT STD_LOGIC;
	wr_reset : IN STD_LOGIC;
	wrclk : IN STD_LOGIC;
	write_d : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	write_usedw : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
	wrreq : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : SDRAM_control_B4_fifo
	PORT MAP (
-- list connections between master ports and signals
	a_sdram => a_sdram,
	cas_n => cas_n,
	clk => clk,
	clk_en => clk_en,
	cs_n => cs_n,
	dq_sdram => dq_sdram,
	dqmh => dqmh,
	dqml => dqml,
	ras_n => ras_n,
	rd_reset => rd_reset,
	rdclk => rdclk,
	rdreq => rdreq,
	read_q => read_q,
	read_usedw => read_usedw,
	reset => reset,
	we_n => we_n,
	wr_reset => wr_reset,
	wrclk => wrclk,
	write_d => write_d,
	write_usedw => write_usedw,
	wrreq => wrreq
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
        -- code executes for every event on sensitivity list  
WAIT;                                                        
END PROCESS always;      

clk <= not clk after 5 ns; -- 100MHz
rdclk <= not rdclk after 7.5 ns; -- 65MHz
wrclk <= not wrclk after 21 ns; -- 12MHz
--############################
write_process: process is
begin

wr_reset <= '1';
wait for 42*23 ns;
wr_reset <= '0';
wrreq <= '0';
wait for 42*10 ns;

wrreq <= '1';
wait for 42 ns;
wrreq <= '0';
wait for 42*2 ns;
wrreq <= '1';
wait for 42*12 ns;
wrreq <= '0';
wait for 42*5 ns;
wr_reset <= '0';
wait for 42 * 10 ns;
wr_reset <= '0';
wait for 42 * 5 ns;
wrreq <= '1';
wait for 42 * 10 ns;
wrreq <= '0';


WAIT;
end process;
--############################
write_data_process: process is
begin
write_d <= "0011010011010001010110010100110101011110001101010001101101001101";
wait for 23 ns;
write_d <= "0001010110010100110101011110001101010001100011010011101101110100";
wait for 23 ns;
write_d <= "0011010110101011110001101010000110100010100110100110111001010011";
wait for 23 ns;
write_d <= "0101000101011010101111000110101001010011000110101101001101001101";
wait for 23 ns;
write_d <= "1101010111100101001010011001101010001101001101001101000101011001";
wait for 23 ns;
write_d <= "0010111000110110101000011001010011010101110100110100010111000111";
wait for 23 ns;
end process;
--############################
read_process: process is
begin

rd_reset <= '1';
rdreq <= '0';
wait for 15*80 ns;
rd_reset <= '0';
wait for 15*80 ns;
rdreq <= '1';
wait for 15 ns;
rdreq <= '0';
wait for 15*2 ns;
rdreq <= '1';
wait for 15*12 ns;
rdreq <= '0';
wait for 15*5 ns;
rd_reset <= '1';
wait for 15 * 10 ns;
rd_reset <= '0';
wait for 15 * 40 ns;
rdreq <= '1';
wait for 15 * 10 ns;
rdreq <= '0';


WAIT;
end process;
--############################

                                    
END SDRAM_control_B4_fifo_arch;
