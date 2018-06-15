#************************************************************
# THIS IS A WIZARD-GENERATED FILE.                           
#
# Version 13.1.0 Build 162 10/23/2013 SJ Full Version
#
#************************************************************

# Copyright (C) 1991-2013 Altera Corporation
# Your use of Altera Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License 
# Subscription Agreement, Altera MegaCore Function License 
# Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by 
# Altera or its authorized distributors.  Please refer to the 
# applicable agreement for further details.



# Clock constraints

create_clock -name "clock_50_1" -period 20.000ns [get_ports {CLOCK_50}]
create_clock -name "clock_50_2" -period 20.000ns [get_ports {CLOCK2_50}]
#create_clock -name "clock_50_3" -period 20.000ns [get_ports {CLOCK3_50}]
#create_clock -name "clock_50_4" -period 20.000ns [get_ports {CLOCK4_50}]
#create_clock -name "clock_27_1" -period 37.000ns [get_ports {TD_CLK27}]
#create_clock -name "clock_25_video" -period 40.000ns [get_ports {GPIO[0]}]


# Automatically constrain PLL and other generated clocks
derive_pll_clocks -create_base_clocks

# Alias for PLL clocks found in Time Quest - Report Clocks
set clk_sys u0|altpll_0|sd1|pll7|clk[0]
set clk_dram u0|altpll_0|sd1|pll7|clk[1]
set clk_video u0|video_pll|video_pll|PLL_for_DE_Series_Boards|auto_generated|pll1|clk[0]
set clk_vga u0|video_pll|video_pll|PLL_for_DE_Series_Boards|auto_generated|pll1|clk[1]

# Output clock pin based on SDRAM PLL
create_generated_clock -name clk_dram_ext -source $clk_dram [get_ports {DRAM_CLK}]

# Output clock to camera based on Video PLL
create_generated_clock -name clk_video_ext -source $clk_video [get_ports {GPIO[16]}]
# Input clock from camera (assuming it is delayed 1 ns)
create_generated_clock -name clk_pixel_ext -source [get_ports {GPIO[16]}] [get_ports {GPIO[0]}] -offset 1

# Output clock pin based on Video PLL (Not available on DE10Lite)
#create_generated_clock -name clk_vga_ext -source $clk_video [get_ports {VGA_CLK}]


# Automatically calculate clock uncertainty to jitter and other effects.
derive_clock_uncertainty

#**************************************************************
# Set Input Delay
#**************************************************************
# suppose +- 100 ps skew
# Board Delay (Data) + Propagation Delay - Board Delay (Clock)
# max 5.4(max) +0.4(trace delay) +0.1 = 5.9
# min 2.7(min) +0.4(trace delay) -0.1 = 3.0
set_input_delay -max -clock clk_dram_ext 5.9 [get_ports DRAM_DQ*]
set_input_delay -min -clock clk_dram_ext 3.0 [get_ports DRAM_DQ*]

#shift-window
#set_multicycle_path -from [get_clocks {clk_dram_ext}] \
#                    -to [get_clocks { u0|altpll_0|sd1|pll7|clk[0] }] \
#						  -setup 2

#set_multicycle_path -from [get_clocks {clk_dram_ext}] \
#                    -to [get_ports {CLOCK_50}] \
#						  -setup 2
						  						  
#**************************************************************
# Set Output Delay
#**************************************************************
# suppose +- 100 ps skew
# max : Board Delay (Data) - Board Delay (Clock) + tsu (External Device)
# min : Board Delay (Data) - Board Delay (Clock) - th (External Device)
# max 1.5+0.1 =1.6
# min -0.8-0.1 = 0.9
set_output_delay -max -clock clk_dram_ext 1.6  [get_ports {DRAM_DQ* DRAM_*DQM}]
set_output_delay -min -clock clk_dram_ext -0.9 [get_ports {DRAM_DQ* DRAM_*DQM}]
set_output_delay -max -clock clk_dram_ext 1.6  [get_ports {DRAM_ADDR* DRAM_BA* DRAM_RAS_N DRAM_CAS_N DRAM_WE_N DRAM_CKE DRAM_CS_N}]
set_output_delay -min -clock clk_dram_ext -0.9 [get_ports {DRAM_ADDR* DRAM_BA* DRAM_RAS_N DRAM_CAS_N DRAM_WE_N DRAM_CKE DRAM_CS_N}]

# tsu/th constraints

# tco constraints

# tpd constraints
