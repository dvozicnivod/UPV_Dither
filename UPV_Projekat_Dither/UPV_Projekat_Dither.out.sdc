## Generated SDC file "UPV_Projekat_Dither.out.sdc"

## Copyright (C) 2017  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel MegaCore Function License Agreement, or other 
## applicable license agreement, including, without limitation, 
## that your use is for the sole purpose of programming logic 
## devices manufactured by Intel and sold by Intel or its 
## authorized distributors.  Please refer to the applicable 
## agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 17.0.2 Build 602 07/19/2017 SJ Lite Edition"

## DATE    "Mon Sep 09 05:04:15 2019"

##
## DEVICE  "EP4CE6E22C8"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {c_100MHz} -period 1.000 -waveform { 0.000 0.500 } [get_ports {c_sdram}]
create_clock -name {clk_24MHz} -period 40.000 -waveform { 0.000 20.000 } [get_ports {c_cam pclk}]
create_clock -name {clk_50} -period 20.000 -waveform { 0.000 10.000 } [get_ports {clk_50}]


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {pll_inst|altpll_component|auto_generated|pll1|clk[0]} -source [get_pins {pll_inst|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50/1 -multiply_by 13 -divide_by 10 -master_clock {clk_50} [get_pins {pll_inst|altpll_component|auto_generated|pll1|clk[0]}] 
create_generated_clock -name {pll_inst|altpll_component|auto_generated|pll1|clk[1]} -source [get_pins {pll_inst|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50/1 -multiply_by 2 -master_clock {clk_50} [get_pins {pll_inst|altpll_component|auto_generated|pll1|clk[1]}] 
create_generated_clock -name {pll_inst|altpll_component|auto_generated|pll1|clk[2]} -source [get_pins {pll_inst|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50/1 -multiply_by 13 -divide_by 27 -master_clock {clk_50} [get_pins {pll_inst|altpll_component|auto_generated|pll1|clk[2]}] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************



#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

