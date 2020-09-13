## Generated SDC file "UPV_Projekat_Dither.sdc"

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

## DATE    "Mon Sep 09 08:14:47 2019"

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

create_clock -name {clk_50} -period 20.000 -waveform { 0.000 10.000 } [get_ports {clk_50}]
create_clock -name {pclk} -period 40.000 -waveform { 0.000 20.000 } [get_ports {pclk}]


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {pll_inst|altpll_component|auto_generated|pll1|clk[0]} -source [get_pins {pll_inst|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50/1 -multiply_by 13 -divide_by 10 -master_clock {clk_50} [get_pins {pll_inst|altpll_component|auto_generated|pll1|clk[0]}] 
create_generated_clock -name {pll_inst|altpll_component|auto_generated|pll1|clk[1]} -source [get_pins {pll_inst|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50/1 -multiply_by 2 -master_clock {clk_50} [get_pins {pll_inst|altpll_component|auto_generated|pll1|clk[1]}] 
create_generated_clock -name {pll_inst|altpll_component|auto_generated|pll1|clk[2]} -source [get_pins {pll_inst|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50/1 -multiply_by 13 -divide_by 27 -master_clock {clk_50} [get_pins {pll_inst|altpll_component|auto_generated|pll1|clk[2]}] 
create_generated_clock -name {cam_read_clk} -source [get_ports {pclk}] -divide_by 64 -master_clock {pclk} [get_nets {cam_ctr_inst|clk_count[5]}] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {cam_read_clk}] -rise_to [get_clocks {cam_read_clk}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {cam_read_clk}] -fall_to [get_clocks {cam_read_clk}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {cam_read_clk}] -rise_to [get_clocks {pclk}]  0.010  
set_clock_uncertainty -rise_from [get_clocks {cam_read_clk}] -fall_to [get_clocks {pclk}]  0.010  
set_clock_uncertainty -fall_from [get_clocks {cam_read_clk}] -rise_to [get_clocks {cam_read_clk}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {cam_read_clk}] -fall_to [get_clocks {cam_read_clk}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {cam_read_clk}] -rise_to [get_clocks {pclk}]  0.010  
set_clock_uncertainty -fall_from [get_clocks {cam_read_clk}] -fall_to [get_clocks {pclk}]  0.010  
set_clock_uncertainty -rise_from [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {pclk}] -rise_to [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[1]}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {pclk}] -rise_to [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[1]}] -hold 0.110  
set_clock_uncertainty -rise_from [get_clocks {pclk}] -fall_to [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[1]}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {pclk}] -fall_to [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[1]}] -hold 0.110  
set_clock_uncertainty -fall_from [get_clocks {pclk}] -rise_to [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[1]}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {pclk}] -rise_to [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[1]}] -hold 0.110  
set_clock_uncertainty -fall_from [get_clocks {pclk}] -fall_to [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[1]}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {pclk}] -fall_to [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[1]}] -hold 0.110  


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

