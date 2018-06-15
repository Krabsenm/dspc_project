# qsys scripting (.tcl) file for soc_video_system
package require -exact qsys 16.0

create_system {soc_video_system}

set_project_property DEVICE_FAMILY {MAX 10}
set_project_property DEVICE {10M50DAF484C6GES}
set_project_property HIDE_FROM_IP_CATALOG {false}

# Instances and instance parameters
# (disabled instances are intentionally culled)
add_instance altpll_0 altpll 17.1
set_instance_parameter_value altpll_0 {AVALON_USE_SEPARATE_SYSCLK} {NO}
set_instance_parameter_value altpll_0 {BANDWIDTH} {}
set_instance_parameter_value altpll_0 {BANDWIDTH_TYPE} {AUTO}
set_instance_parameter_value altpll_0 {CLK0_DIVIDE_BY} {1}
set_instance_parameter_value altpll_0 {CLK0_DUTY_CYCLE} {50}
set_instance_parameter_value altpll_0 {CLK0_MULTIPLY_BY} {2}
set_instance_parameter_value altpll_0 {CLK0_PHASE_SHIFT} {0}
set_instance_parameter_value altpll_0 {CLK1_DIVIDE_BY} {1}
set_instance_parameter_value altpll_0 {CLK1_DUTY_CYCLE} {50}
set_instance_parameter_value altpll_0 {CLK1_MULTIPLY_BY} {2}
set_instance_parameter_value altpll_0 {CLK1_PHASE_SHIFT} {-5139}
set_instance_parameter_value altpll_0 {CLK2_DIVIDE_BY} {}
set_instance_parameter_value altpll_0 {CLK2_DUTY_CYCLE} {}
set_instance_parameter_value altpll_0 {CLK2_MULTIPLY_BY} {}
set_instance_parameter_value altpll_0 {CLK2_PHASE_SHIFT} {}
set_instance_parameter_value altpll_0 {CLK3_DIVIDE_BY} {}
set_instance_parameter_value altpll_0 {CLK3_DUTY_CYCLE} {}
set_instance_parameter_value altpll_0 {CLK3_MULTIPLY_BY} {}
set_instance_parameter_value altpll_0 {CLK3_PHASE_SHIFT} {}
set_instance_parameter_value altpll_0 {CLK4_DIVIDE_BY} {}
set_instance_parameter_value altpll_0 {CLK4_DUTY_CYCLE} {}
set_instance_parameter_value altpll_0 {CLK4_MULTIPLY_BY} {}
set_instance_parameter_value altpll_0 {CLK4_PHASE_SHIFT} {}
set_instance_parameter_value altpll_0 {CLK5_DIVIDE_BY} {}
set_instance_parameter_value altpll_0 {CLK5_DUTY_CYCLE} {}
set_instance_parameter_value altpll_0 {CLK5_MULTIPLY_BY} {}
set_instance_parameter_value altpll_0 {CLK5_PHASE_SHIFT} {}
set_instance_parameter_value altpll_0 {CLK6_DIVIDE_BY} {}
set_instance_parameter_value altpll_0 {CLK6_DUTY_CYCLE} {}
set_instance_parameter_value altpll_0 {CLK6_MULTIPLY_BY} {}
set_instance_parameter_value altpll_0 {CLK6_PHASE_SHIFT} {}
set_instance_parameter_value altpll_0 {CLK7_DIVIDE_BY} {}
set_instance_parameter_value altpll_0 {CLK7_DUTY_CYCLE} {}
set_instance_parameter_value altpll_0 {CLK7_MULTIPLY_BY} {}
set_instance_parameter_value altpll_0 {CLK7_PHASE_SHIFT} {}
set_instance_parameter_value altpll_0 {CLK8_DIVIDE_BY} {}
set_instance_parameter_value altpll_0 {CLK8_DUTY_CYCLE} {}
set_instance_parameter_value altpll_0 {CLK8_MULTIPLY_BY} {}
set_instance_parameter_value altpll_0 {CLK8_PHASE_SHIFT} {}
set_instance_parameter_value altpll_0 {CLK9_DIVIDE_BY} {}
set_instance_parameter_value altpll_0 {CLK9_DUTY_CYCLE} {}
set_instance_parameter_value altpll_0 {CLK9_MULTIPLY_BY} {}
set_instance_parameter_value altpll_0 {CLK9_PHASE_SHIFT} {}
set_instance_parameter_value altpll_0 {COMPENSATE_CLOCK} {CLK0}
set_instance_parameter_value altpll_0 {DOWN_SPREAD} {}
set_instance_parameter_value altpll_0 {DPA_DIVIDER} {}
set_instance_parameter_value altpll_0 {DPA_DIVIDE_BY} {}
set_instance_parameter_value altpll_0 {DPA_MULTIPLY_BY} {}
set_instance_parameter_value altpll_0 {ENABLE_SWITCH_OVER_COUNTER} {}
set_instance_parameter_value altpll_0 {EXTCLK0_DIVIDE_BY} {}
set_instance_parameter_value altpll_0 {EXTCLK0_DUTY_CYCLE} {}
set_instance_parameter_value altpll_0 {EXTCLK0_MULTIPLY_BY} {}
set_instance_parameter_value altpll_0 {EXTCLK0_PHASE_SHIFT} {}
set_instance_parameter_value altpll_0 {EXTCLK1_DIVIDE_BY} {}
set_instance_parameter_value altpll_0 {EXTCLK1_DUTY_CYCLE} {}
set_instance_parameter_value altpll_0 {EXTCLK1_MULTIPLY_BY} {}
set_instance_parameter_value altpll_0 {EXTCLK1_PHASE_SHIFT} {}
set_instance_parameter_value altpll_0 {EXTCLK2_DIVIDE_BY} {}
set_instance_parameter_value altpll_0 {EXTCLK2_DUTY_CYCLE} {}
set_instance_parameter_value altpll_0 {EXTCLK2_MULTIPLY_BY} {}
set_instance_parameter_value altpll_0 {EXTCLK2_PHASE_SHIFT} {}
set_instance_parameter_value altpll_0 {EXTCLK3_DIVIDE_BY} {}
set_instance_parameter_value altpll_0 {EXTCLK3_DUTY_CYCLE} {}
set_instance_parameter_value altpll_0 {EXTCLK3_MULTIPLY_BY} {}
set_instance_parameter_value altpll_0 {EXTCLK3_PHASE_SHIFT} {}
set_instance_parameter_value altpll_0 {FEEDBACK_SOURCE} {}
set_instance_parameter_value altpll_0 {GATE_LOCK_COUNTER} {}
set_instance_parameter_value altpll_0 {GATE_LOCK_SIGNAL} {}
set_instance_parameter_value altpll_0 {HIDDEN_CONSTANTS} {CT#PORT_clk5 PORT_UNUSED CT#PORT_clk4 PORT_UNUSED CT#PORT_clk3 PORT_UNUSED CT#PORT_clk2 PORT_UNUSED CT#PORT_clk1 PORT_USED CT#PORT_clk0 PORT_USED CT#CLK0_MULTIPLY_BY 2 CT#PORT_SCANWRITE PORT_UNUSED CT#PORT_SCANACLR PORT_UNUSED CT#PORT_PFDENA PORT_UNUSED CT#PORT_PLLENA PORT_UNUSED CT#PORT_SCANDATA PORT_UNUSED CT#PORT_SCANCLKENA PORT_UNUSED CT#WIDTH_CLOCK 5 CT#PORT_SCANDATAOUT PORT_UNUSED CT#LPM_TYPE altpll CT#PLL_TYPE AUTO CT#CLK0_PHASE_SHIFT 0 CT#CLK1_DUTY_CYCLE 50 CT#PORT_PHASEDONE PORT_UNUSED CT#OPERATION_MODE NORMAL CT#PORT_CONFIGUPDATE PORT_UNUSED CT#CLK1_MULTIPLY_BY 2 CT#COMPENSATE_CLOCK CLK0 CT#PORT_CLKSWITCH PORT_UNUSED CT#INCLK0_INPUT_FREQUENCY 20000 CT#PORT_SCANDONE PORT_UNUSED CT#PORT_CLKLOSS PORT_UNUSED CT#PORT_INCLK1 PORT_UNUSED CT#AVALON_USE_SEPARATE_SYSCLK NO CT#PORT_INCLK0 PORT_USED CT#PORT_clkena5 PORT_UNUSED CT#PORT_clkena4 PORT_UNUSED CT#PORT_clkena3 PORT_UNUSED CT#PORT_clkena2 PORT_UNUSED CT#PORT_clkena1 PORT_UNUSED CT#PORT_clkena0 PORT_UNUSED CT#CLK1_PHASE_SHIFT -5139 CT#PORT_ARESET PORT_UNUSED CT#BANDWIDTH_TYPE AUTO CT#INTENDED_DEVICE_FAMILY {MAX 10} CT#PORT_SCANREAD PORT_UNUSED CT#PORT_PHASESTEP PORT_UNUSED CT#PORT_SCANCLK PORT_UNUSED CT#PORT_CLKBAD1 PORT_UNUSED CT#PORT_CLKBAD0 PORT_UNUSED CT#PORT_FBIN PORT_UNUSED CT#PORT_PHASEUPDOWN PORT_UNUSED CT#PORT_extclk3 PORT_UNUSED CT#PORT_extclk2 PORT_UNUSED CT#PORT_extclk1 PORT_UNUSED CT#PORT_PHASECOUNTERSELECT PORT_UNUSED CT#PORT_extclk0 PORT_UNUSED CT#PORT_ACTIVECLOCK PORT_UNUSED CT#CLK0_DUTY_CYCLE 50 CT#CLK0_DIVIDE_BY 1 CT#CLK1_DIVIDE_BY 1 CT#PORT_LOCKED PORT_UNUSED}
set_instance_parameter_value altpll_0 {HIDDEN_CUSTOM_ELABORATION} {altpll_avalon_elaboration}
set_instance_parameter_value altpll_0 {HIDDEN_CUSTOM_POST_EDIT} {altpll_avalon_post_edit}
set_instance_parameter_value altpll_0 {HIDDEN_IF_PORTS} {IF#phasecounterselect {input 3} IF#locked {output 0} IF#reset {input 0} IF#clk {input 0} IF#phaseupdown {input 0} IF#scandone {output 0} IF#readdata {output 32} IF#write {input 0} IF#scanclk {input 0} IF#phasedone {output 0} IF#c4 {output 0} IF#c3 {output 0} IF#c2 {output 0} IF#address {input 2} IF#c1 {output 0} IF#c0 {output 0} IF#writedata {input 32} IF#read {input 0} IF#areset {input 0} IF#scanclkena {input 0} IF#scandataout {output 0} IF#configupdate {input 0} IF#phasestep {input 0} IF#scandata {input 0}}
set_instance_parameter_value altpll_0 {HIDDEN_IS_FIRST_EDIT} {0}
set_instance_parameter_value altpll_0 {HIDDEN_IS_NUMERIC} {IN#WIDTH_CLOCK 1 IN#CLK0_DUTY_CYCLE 1 IN#PLL_TARGET_HARCOPY_CHECK 1 IN#CLK1_MULTIPLY_BY 1 IN#SWITCHOVER_COUNT_EDIT 1 IN#INCLK0_INPUT_FREQUENCY 1 IN#PLL_LVDS_PLL_CHECK 1 IN#PLL_AUTOPLL_CHECK 1 IN#PLL_FASTPLL_CHECK 1 IN#CLK1_DUTY_CYCLE 1 IN#PLL_ENHPLL_CHECK 1 IN#DIV_FACTOR1 1 IN#DIV_FACTOR0 1 IN#LVDS_MODE_DATA_RATE_DIRTY 1 IN#GLOCK_COUNTER_EDIT 1 IN#CLK0_DIVIDE_BY 1 IN#MULT_FACTOR1 1 IN#MULT_FACTOR0 1 IN#CLK0_MULTIPLY_BY 1 IN#USE_MIL_SPEED_GRADE 1 IN#CLK1_DIVIDE_BY 1}
set_instance_parameter_value altpll_0 {HIDDEN_MF_PORTS} {MF#areset 1 MF#clk 1 MF#locked 1 MF#inclk 1}
set_instance_parameter_value altpll_0 {HIDDEN_PRIVATES} {PT#GLOCKED_FEATURE_ENABLED 0 PT#SPREAD_FEATURE_ENABLED 0 PT#BANDWIDTH_FREQ_UNIT MHz PT#CUR_DEDICATED_CLK c0 PT#INCLK0_FREQ_EDIT 50.000 PT#BANDWIDTH_PRESET Low PT#PLL_LVDS_PLL_CHECK 0 PT#BANDWIDTH_USE_PRESET 0 PT#AVALON_USE_SEPARATE_SYSCLK NO PT#PLL_ENHPLL_CHECK 0 PT#OUTPUT_FREQ_UNIT1 MHz PT#OUTPUT_FREQ_UNIT0 MHz PT#PHASE_RECONFIG_FEATURE_ENABLED 1 PT#CREATE_CLKBAD_CHECK 0 PT#CLKSWITCH_CHECK 0 PT#INCLK1_FREQ_EDIT 100.000 PT#NORMAL_MODE_RADIO 1 PT#SRC_SYNCH_COMP_RADIO 0 PT#PLL_ARESET_CHECK 0 PT#LONG_SCAN_RADIO 1 PT#SCAN_FEATURE_ENABLED 1 PT#PHASE_RECONFIG_INPUTS_CHECK 0 PT#USE_CLK1 1 PT#USE_CLK0 1 PT#PRIMARY_CLK_COMBO inclk0 PT#BANDWIDTH 1.000 PT#GLOCKED_COUNTER_EDIT_CHANGED 1 PT#PLL_FASTPLL_CHECK 0 PT#SPREAD_FREQ_UNIT KHz PT#PLL_AUTOPLL_CHECK 1 PT#LVDS_PHASE_SHIFT_UNIT1 deg PT#LVDS_PHASE_SHIFT_UNIT0 deg PT#OUTPUT_FREQ_MODE1 0 PT#SWITCHOVER_FEATURE_ENABLED 0 PT#MIG_DEVICE_SPEED_GRADE Any PT#OUTPUT_FREQ_MODE0 0 PT#BANDWIDTH_FEATURE_ENABLED 1 PT#INCLK0_FREQ_UNIT_COMBO MHz PT#ZERO_DELAY_RADIO 0 PT#OUTPUT_FREQ1 100.00000000 PT#OUTPUT_FREQ0 100.00000000 PT#SHORT_SCAN_RADIO 0 PT#LVDS_MODE_DATA_RATE_DIRTY 0 PT#CUR_FBIN_CLK c0 PT#PLL_ADVANCED_PARAM_CHECK 0 PT#CLKBAD_SWITCHOVER_CHECK 0 PT#PHASE_SHIFT_STEP_ENABLED_CHECK 0 PT#DEVICE_SPEED_GRADE Any PT#PLL_FBMIMIC_CHECK 0 PT#LVDS_MODE_DATA_RATE {Not Available} PT#LOCKED_OUTPUT_CHECK 0 PT#SPREAD_PERCENT 0.500 PT#PHASE_SHIFT1 -185.00000000 PT#PHASE_SHIFT0 0.00000000 PT#DIV_FACTOR1 1 PT#DIV_FACTOR0 1 PT#CNX_NO_COMPENSATE_RADIO 0 PT#USE_CLKENA1 0 PT#USE_CLKENA0 0 PT#CREATE_INCLK1_CHECK 0 PT#GLOCK_COUNTER_EDIT 1048575 PT#INCLK1_FREQ_UNIT_COMBO MHz PT#EFF_OUTPUT_FREQ_VALUE1 100.000000 PT#EFF_OUTPUT_FREQ_VALUE0 100.000000 PT#SPREAD_FREQ 50.000 PT#USE_MIL_SPEED_GRADE 0 PT#EXPLICIT_SWITCHOVER_COUNTER 0 PT#STICKY_CLK4 0 PT#STICKY_CLK3 0 PT#STICKY_CLK2 0 PT#STICKY_CLK1 1 PT#STICKY_CLK0 1 PT#EXT_FEEDBACK_RADIO 0 PT#MIRROR_CLK1 0 PT#MIRROR_CLK0 0 PT#SWITCHOVER_COUNT_EDIT 1 PT#SELF_RESET_LOCK_LOSS 0 PT#PLL_PFDENA_CHECK 0 PT#INT_FEEDBACK__MODE_RADIO 1 PT#INCLK1_FREQ_EDIT_CHANGED 1 PT#CLKLOSS_CHECK 0 PT#SYNTH_WRAPPER_GEN_POSTFIX 0 PT#PHASE_SHIFT_UNIT1 deg PT#PHASE_SHIFT_UNIT0 deg PT#BANDWIDTH_USE_AUTO 1 PT#HAS_MANUAL_SWITCHOVER 1 PT#MULT_FACTOR1 2 PT#MULT_FACTOR0 2 PT#SPREAD_USE 0 PT#GLOCKED_MODE_CHECK 0 PT#SACN_INPUTS_CHECK 0 PT#DUTY_CYCLE1 50.00000000 PT#INTENDED_DEVICE_FAMILY {MAX 10} PT#DUTY_CYCLE0 50.00000000 PT#PLL_TARGET_HARCOPY_CHECK 0 PT#INCLK1_FREQ_UNIT_CHANGED 1 PT#RECONFIG_FILE ALTPLL1524215594172164.mif PT#ACTIVECLK_CHECK 0}
set_instance_parameter_value altpll_0 {HIDDEN_USED_PORTS} {UP#locked used UP#c1 used UP#c0 used UP#areset used UP#inclk0 used}
set_instance_parameter_value altpll_0 {INCLK0_INPUT_FREQUENCY} {20000}
set_instance_parameter_value altpll_0 {INCLK1_INPUT_FREQUENCY} {}
set_instance_parameter_value altpll_0 {INTENDED_DEVICE_FAMILY} {MAX 10}
set_instance_parameter_value altpll_0 {INVALID_LOCK_MULTIPLIER} {}
set_instance_parameter_value altpll_0 {LOCK_HIGH} {}
set_instance_parameter_value altpll_0 {LOCK_LOW} {}
set_instance_parameter_value altpll_0 {OPERATION_MODE} {NORMAL}
set_instance_parameter_value altpll_0 {PLL_TYPE} {AUTO}
set_instance_parameter_value altpll_0 {PORT_ACTIVECLOCK} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_ARESET} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_CLKBAD0} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_CLKBAD1} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_CLKLOSS} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_CLKSWITCH} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_CONFIGUPDATE} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_ENABLE0} {}
set_instance_parameter_value altpll_0 {PORT_ENABLE1} {}
set_instance_parameter_value altpll_0 {PORT_FBIN} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_FBOUT} {}
set_instance_parameter_value altpll_0 {PORT_INCLK0} {PORT_USED}
set_instance_parameter_value altpll_0 {PORT_INCLK1} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_LOCKED} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_PFDENA} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_PHASECOUNTERSELECT} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_PHASEDONE} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_PHASESTEP} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_PHASEUPDOWN} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_PLLENA} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_SCANACLR} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_SCANCLK} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_SCANCLKENA} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_SCANDATA} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_SCANDATAOUT} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_SCANDONE} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_SCANREAD} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_SCANWRITE} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_SCLKOUT0} {}
set_instance_parameter_value altpll_0 {PORT_SCLKOUT1} {}
set_instance_parameter_value altpll_0 {PORT_VCOOVERRANGE} {}
set_instance_parameter_value altpll_0 {PORT_VCOUNDERRANGE} {}
set_instance_parameter_value altpll_0 {PORT_clk0} {PORT_USED}
set_instance_parameter_value altpll_0 {PORT_clk1} {PORT_USED}
set_instance_parameter_value altpll_0 {PORT_clk2} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_clk3} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_clk4} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_clk5} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_clk6} {}
set_instance_parameter_value altpll_0 {PORT_clk7} {}
set_instance_parameter_value altpll_0 {PORT_clk8} {}
set_instance_parameter_value altpll_0 {PORT_clk9} {}
set_instance_parameter_value altpll_0 {PORT_clkena0} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_clkena1} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_clkena2} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_clkena3} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_clkena4} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_clkena5} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_extclk0} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_extclk1} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_extclk2} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_extclk3} {PORT_UNUSED}
set_instance_parameter_value altpll_0 {PORT_extclkena0} {}
set_instance_parameter_value altpll_0 {PORT_extclkena1} {}
set_instance_parameter_value altpll_0 {PORT_extclkena2} {}
set_instance_parameter_value altpll_0 {PORT_extclkena3} {}
set_instance_parameter_value altpll_0 {PRIMARY_CLOCK} {}
set_instance_parameter_value altpll_0 {QUALIFY_CONF_DONE} {}
set_instance_parameter_value altpll_0 {SCAN_CHAIN} {}
set_instance_parameter_value altpll_0 {SCAN_CHAIN_MIF_FILE} {}
set_instance_parameter_value altpll_0 {SCLKOUT0_PHASE_SHIFT} {}
set_instance_parameter_value altpll_0 {SCLKOUT1_PHASE_SHIFT} {}
set_instance_parameter_value altpll_0 {SELF_RESET_ON_GATED_LOSS_LOCK} {}
set_instance_parameter_value altpll_0 {SELF_RESET_ON_LOSS_LOCK} {}
set_instance_parameter_value altpll_0 {SKIP_VCO} {}
set_instance_parameter_value altpll_0 {SPREAD_FREQUENCY} {}
set_instance_parameter_value altpll_0 {SWITCH_OVER_COUNTER} {}
set_instance_parameter_value altpll_0 {SWITCH_OVER_ON_GATED_LOCK} {}
set_instance_parameter_value altpll_0 {SWITCH_OVER_ON_LOSSCLK} {}
set_instance_parameter_value altpll_0 {SWITCH_OVER_TYPE} {}
set_instance_parameter_value altpll_0 {USING_FBMIMICBIDIR_PORT} {}
set_instance_parameter_value altpll_0 {VALID_LOCK_MULTIPLIER} {}
set_instance_parameter_value altpll_0 {VCO_DIVIDE_BY} {}
set_instance_parameter_value altpll_0 {VCO_FREQUENCY_CONTROL} {}
set_instance_parameter_value altpll_0 {VCO_MULTIPLY_BY} {}
set_instance_parameter_value altpll_0 {VCO_PHASE_SHIFT_STEP} {}
set_instance_parameter_value altpll_0 {WIDTH_CLOCK} {5}
set_instance_parameter_value altpll_0 {WIDTH_PHASECOUNTERSELECT} {}

add_instance audio_and_video_config_0 altera_up_avalon_audio_and_video_config 17.1
set_instance_parameter_value audio_and_video_config_0 {audio_in} {Microphone to ADC}
set_instance_parameter_value audio_and_video_config_0 {bit_length} {24}
set_instance_parameter_value audio_and_video_config_0 {board} {DE1-SoC}
set_instance_parameter_value audio_and_video_config_0 {d5m_resolution} {2592 x 1944}
set_instance_parameter_value audio_and_video_config_0 {dac_enable} {1}
set_instance_parameter_value audio_and_video_config_0 {data_format} {Left Justified}
set_instance_parameter_value audio_and_video_config_0 {device} {5 Megapixel Camera (TRDB_D5M)}
set_instance_parameter_value audio_and_video_config_0 {eai} {1}
set_instance_parameter_value audio_and_video_config_0 {exposure} {0}
set_instance_parameter_value audio_and_video_config_0 {line_in_bypass} {0}
set_instance_parameter_value audio_and_video_config_0 {mic_attenuation} {-6dB}
set_instance_parameter_value audio_and_video_config_0 {mic_bypass} {0}
set_instance_parameter_value audio_and_video_config_0 {sampling_rate} {48 kHz}
set_instance_parameter_value audio_and_video_config_0 {video_format} {NTSC}

add_instance clk_0 clock_source 17.1
set_instance_parameter_value clk_0 {clockFrequency} {50000000.0}
set_instance_parameter_value clk_0 {clockFrequencyKnown} {1}
set_instance_parameter_value clk_0 {resetSynchronousEdges} {NONE}

add_instance fpga_only_master altera_jtag_avalon_master 17.1
set_instance_parameter_value fpga_only_master {FAST_VER} {0}
set_instance_parameter_value fpga_only_master {FIFO_DEPTHS} {2}
set_instance_parameter_value fpga_only_master {PLI_PORT} {50000}
set_instance_parameter_value fpga_only_master {USE_PLI} {0}

add_instance pixel_buffer altera_avalon_new_sdram_controller 17.1
set_instance_parameter_value pixel_buffer {TAC} {5.4}
set_instance_parameter_value pixel_buffer {TMRD} {3.0}
set_instance_parameter_value pixel_buffer {TRCD} {15.0}
set_instance_parameter_value pixel_buffer {TRFC} {75.0}
set_instance_parameter_value pixel_buffer {TRP} {15.0}
set_instance_parameter_value pixel_buffer {TWR} {20.0}
set_instance_parameter_value pixel_buffer {casLatency} {3}
set_instance_parameter_value pixel_buffer {columnWidth} {10}
set_instance_parameter_value pixel_buffer {dataWidth} {16}
set_instance_parameter_value pixel_buffer {generateSimulationModel} {0}
set_instance_parameter_value pixel_buffer {initNOPDelay} {0.0}
set_instance_parameter_value pixel_buffer {initRefreshCommands} {2}
set_instance_parameter_value pixel_buffer {masteredTristateBridgeSlave} {0}
set_instance_parameter_value pixel_buffer {model} {single_Micron_MT48LC4M32B2_7_chip}
set_instance_parameter_value pixel_buffer {numberOfBanks} {4}
set_instance_parameter_value pixel_buffer {numberOfChipSelects} {1}
set_instance_parameter_value pixel_buffer {pinsSharedViaTriState} {0}
set_instance_parameter_value pixel_buffer {powerUpDelay} {100.0}
set_instance_parameter_value pixel_buffer {refreshPeriod} {57.0}
set_instance_parameter_value pixel_buffer {registerDataIn} {1}
set_instance_parameter_value pixel_buffer {rowWidth} {13}

add_instance pixel_onchip_buffer altera_avalon_onchip_memory2 17.1
set_instance_parameter_value pixel_onchip_buffer {allowInSystemMemoryContentEditor} {0}
set_instance_parameter_value pixel_onchip_buffer {blockType} {AUTO}
set_instance_parameter_value pixel_onchip_buffer {copyInitFile} {0}
set_instance_parameter_value pixel_onchip_buffer {dataWidth} {8}
set_instance_parameter_value pixel_onchip_buffer {dataWidth2} {32}
set_instance_parameter_value pixel_onchip_buffer {dualPort} {0}
set_instance_parameter_value pixel_onchip_buffer {ecc_enabled} {0}
set_instance_parameter_value pixel_onchip_buffer {enPRInitMode} {0}
set_instance_parameter_value pixel_onchip_buffer {enableDiffWidth} {0}
set_instance_parameter_value pixel_onchip_buffer {initMemContent} {0}
set_instance_parameter_value pixel_onchip_buffer {initializationFileName} {onchip_mem.hex}
set_instance_parameter_value pixel_onchip_buffer {instanceID} {NONE}
set_instance_parameter_value pixel_onchip_buffer {memorySize} {153600.0}
set_instance_parameter_value pixel_onchip_buffer {readDuringWriteMode} {DONT_CARE}
set_instance_parameter_value pixel_onchip_buffer {resetrequest_enabled} {0}
set_instance_parameter_value pixel_onchip_buffer {simAllowMRAMContentsFile} {0}
set_instance_parameter_value pixel_onchip_buffer {simMemInitOnlyFilename} {0}
set_instance_parameter_value pixel_onchip_buffer {singleClockOperation} {0}
set_instance_parameter_value pixel_onchip_buffer {slave1Latency} {1}
set_instance_parameter_value pixel_onchip_buffer {slave2Latency} {1}
set_instance_parameter_value pixel_onchip_buffer {useNonDefaultInitFile} {0}
set_instance_parameter_value pixel_onchip_buffer {useShallowMemBlocks} {0}
set_instance_parameter_value pixel_onchip_buffer {writable} {1}

add_instance sobel_edge_detector_0 sobel_edge_detector 1.0
set_instance_parameter_value sobel_edge_detector_0 {WIDTH} {320}

add_instance video_bayer_resampler altera_up_avalon_video_bayer_resampler 17.1
set_instance_parameter_value video_bayer_resampler {custom_height_in} {1944}
set_instance_parameter_value video_bayer_resampler {custom_width_in} {2592}
set_instance_parameter_value video_bayer_resampler {device} {5MP Digital Camera (THDB_D5M)}
set_instance_parameter_value video_bayer_resampler {use_custom_format} {1}

add_instance video_clipper altera_up_avalon_video_clipper 17.1
set_instance_parameter_value video_clipper {add_bottom} {0}
set_instance_parameter_value video_clipper {add_left} {0}
set_instance_parameter_value video_clipper {add_right} {0}
set_instance_parameter_value video_clipper {add_top} {0}
set_instance_parameter_value video_clipper {add_value_plane_1} {0}
set_instance_parameter_value video_clipper {add_value_plane_2} {0}
set_instance_parameter_value video_clipper {add_value_plane_3} {0}
set_instance_parameter_value video_clipper {add_value_plane_4} {0}
set_instance_parameter_value video_clipper {color_bits} {8}
set_instance_parameter_value video_clipper {color_planes} {3}
set_instance_parameter_value video_clipper {drop_bottom} {6}
set_instance_parameter_value video_clipper {drop_left} {8}
set_instance_parameter_value video_clipper {drop_right} {8}
set_instance_parameter_value video_clipper {drop_top} {6}
set_instance_parameter_value video_clipper {height_in} {972}
set_instance_parameter_value video_clipper {width_in} {1296}

add_instance video_decoder_0 altera_up_avalon_video_decoder 17.1
set_instance_parameter_value video_decoder_0 {video_source} {5MP Digital Camera (THDB_D5M)}

add_instance video_dma_controller altera_up_avalon_video_dma_controller 17.1
set_instance_parameter_value video_dma_controller {addr_mode} {X-Y}
set_instance_parameter_value video_dma_controller {back_start_address} {0}
set_instance_parameter_value video_dma_controller {color_bits} {8}
set_instance_parameter_value video_dma_controller {color_planes} {1}
set_instance_parameter_value video_dma_controller {dma_enabled} {1}
set_instance_parameter_value video_dma_controller {height} {240}
set_instance_parameter_value video_dma_controller {mode} {From Stream to Memory}
set_instance_parameter_value video_dma_controller {start_address} {0}
set_instance_parameter_value video_dma_controller {width} {320}

add_instance video_dual_clock_buffer altera_up_avalon_video_dual_clock_buffer 17.1
set_instance_parameter_value video_dual_clock_buffer {color_bits} {10}
set_instance_parameter_value video_dual_clock_buffer {color_planes} {3}

add_instance video_pixel_buffer_dma altera_up_avalon_video_pixel_buffer_dma 17.1
set_instance_parameter_value video_pixel_buffer_dma {addr_mode} {X-Y}
set_instance_parameter_value video_pixel_buffer_dma {back_start_address} {0}
set_instance_parameter_value video_pixel_buffer_dma {color_space} {8-bit Grayscale}
set_instance_parameter_value video_pixel_buffer_dma {image_height} {240}
set_instance_parameter_value video_pixel_buffer_dma {image_width} {320}
set_instance_parameter_value video_pixel_buffer_dma {start_address} {0}

add_instance video_pixel_rgb_resampler_1 altera_up_avalon_video_rgb_resampler 17.1
set_instance_parameter_value video_pixel_rgb_resampler_1 {alpha} {1023}
set_instance_parameter_value video_pixel_rgb_resampler_1 {input_type} {8-bit Grayscale}
set_instance_parameter_value video_pixel_rgb_resampler_1 {output_type} {30-bit RGB}

add_instance video_pll altera_up_avalon_video_pll 17.1
set_instance_parameter_value video_pll {camera} {5MP Digital Camera (THDB_D5M)}
set_instance_parameter_value video_pll {gui_refclk} {50.0}
set_instance_parameter_value video_pll {gui_resolution} {VGA 640x480}
set_instance_parameter_value video_pll {lcd} {2.4" LCD on LT24}
set_instance_parameter_value video_pll {lcd_clk_en} {0}
set_instance_parameter_value video_pll {vga_clk_en} {1}
set_instance_parameter_value video_pll {video_in_clk_en} {1}

add_instance video_rgb_resampler altera_up_avalon_video_rgb_resampler 17.1
set_instance_parameter_value video_rgb_resampler {alpha} {1023}
set_instance_parameter_value video_rgb_resampler {input_type} {24-bit RGB}
set_instance_parameter_value video_rgb_resampler {output_type} {8-bit Grayscale}

add_instance video_scaler altera_up_avalon_video_scaler 17.1
set_instance_parameter_value video_scaler {color_bits} {8}
set_instance_parameter_value video_scaler {color_planes} {3}
set_instance_parameter_value video_scaler {height_in} {960}
set_instance_parameter_value video_scaler {height_scaling} {0.25}
set_instance_parameter_value video_scaler {include_channel} {0}
set_instance_parameter_value video_scaler {width_in} {1280}
set_instance_parameter_value video_scaler {width_scaling} {0.25}

add_instance video_scaler_0 altera_up_avalon_video_scaler 17.1
set_instance_parameter_value video_scaler_0 {color_bits} {8}
set_instance_parameter_value video_scaler_0 {color_planes} {1}
set_instance_parameter_value video_scaler_0 {height_in} {240}
set_instance_parameter_value video_scaler_0 {height_scaling} {2}
set_instance_parameter_value video_scaler_0 {include_channel} {0}
set_instance_parameter_value video_scaler_0 {width_in} {320}
set_instance_parameter_value video_scaler_0 {width_scaling} {2}

add_instance video_stream_router_0 altera_up_avalon_video_stream_router 17.1
set_instance_parameter_value video_stream_router_0 {color_bits} {8}
set_instance_parameter_value video_stream_router_0 {color_planes} {1}
set_instance_parameter_value video_stream_router_0 {router_type} {Split}
set_instance_parameter_value video_stream_router_0 {sync} {0}

add_instance video_stream_router_1 altera_up_avalon_video_stream_router 17.1
set_instance_parameter_value video_stream_router_1 {color_bits} {8}
set_instance_parameter_value video_stream_router_1 {color_planes} {1}
set_instance_parameter_value video_stream_router_1 {router_type} {Merge}
set_instance_parameter_value video_stream_router_1 {sync} {0}

add_instance video_vga_controller altera_up_avalon_video_vga_controller 17.1
set_instance_parameter_value video_vga_controller {board} {DE1-SoC}
set_instance_parameter_value video_vga_controller {device} {VGA Connector}
set_instance_parameter_value video_vga_controller {resolution} {VGA 640x480}
set_instance_parameter_value video_vga_controller {underflow_flag} {0}

# exported interfaces
add_interface clk clock sink
set_interface_property clk EXPORT_OF clk_0.clk_in
add_interface clk_sdram clock source
set_interface_property clk_sdram EXPORT_OF altpll_0.c1
add_interface clk_video clock source
set_interface_property clk_video EXPORT_OF video_pll.video_in_clk
add_interface edge_detect conduit end
set_interface_property edge_detect EXPORT_OF sobel_edge_detector_0.conduit_end
add_interface reset reset sink
set_interface_property reset EXPORT_OF clk_0.clk_in_reset
add_interface vga conduit end
set_interface_property vga EXPORT_OF video_vga_controller.external_interface
add_interface video_config conduit end
set_interface_property video_config EXPORT_OF audio_and_video_config_0.external_interface
add_interface video_in_decoder conduit end
set_interface_property video_in_decoder EXPORT_OF video_decoder_0.external_interface
add_interface video_merge conduit end
set_interface_property video_merge EXPORT_OF video_stream_router_1.external_interface
add_interface video_sdram conduit end
set_interface_property video_sdram EXPORT_OF pixel_buffer.wire
add_interface video_split conduit end
set_interface_property video_split EXPORT_OF video_stream_router_0.external_interface

# connections and connection parameters
add_connection altpll_0.c0 audio_and_video_config_0.clk

add_connection altpll_0.c0 fpga_only_master.clk

add_connection altpll_0.c0 pixel_buffer.clk

add_connection altpll_0.c0 pixel_onchip_buffer.clk1

add_connection altpll_0.c0 sobel_edge_detector_0.clock

add_connection altpll_0.c0 video_bayer_resampler.clk

add_connection altpll_0.c0 video_clipper.clk

add_connection altpll_0.c0 video_decoder_0.clk

add_connection altpll_0.c0 video_dma_controller.clk

add_connection altpll_0.c0 video_dual_clock_buffer.clock_stream_in

add_connection altpll_0.c0 video_pixel_buffer_dma.clk

add_connection altpll_0.c0 video_pixel_rgb_resampler_1.clk

add_connection altpll_0.c0 video_rgb_resampler.clk

add_connection altpll_0.c0 video_scaler.clk

add_connection altpll_0.c0 video_scaler_0.clk

add_connection altpll_0.c0 video_stream_router_0.clk

add_connection altpll_0.c0 video_stream_router_1.clk

add_connection clk_0.clk altpll_0.inclk_interface

add_connection clk_0.clk video_pll.ref_clk

add_connection clk_0.clk_reset altpll_0.inclk_interface_reset

add_connection clk_0.clk_reset audio_and_video_config_0.reset

add_connection clk_0.clk_reset fpga_only_master.clk_reset

add_connection clk_0.clk_reset pixel_buffer.reset

add_connection clk_0.clk_reset pixel_onchip_buffer.reset1

add_connection clk_0.clk_reset sobel_edge_detector_0.reset

add_connection clk_0.clk_reset video_bayer_resampler.reset

add_connection clk_0.clk_reset video_clipper.reset

add_connection clk_0.clk_reset video_decoder_0.reset

add_connection clk_0.clk_reset video_dma_controller.reset

add_connection clk_0.clk_reset video_dual_clock_buffer.reset_stream_in

add_connection clk_0.clk_reset video_dual_clock_buffer.reset_stream_out

add_connection clk_0.clk_reset video_pixel_buffer_dma.reset

add_connection clk_0.clk_reset video_pixel_rgb_resampler_1.reset

add_connection clk_0.clk_reset video_pll.ref_reset

add_connection clk_0.clk_reset video_rgb_resampler.reset

add_connection clk_0.clk_reset video_scaler.reset

add_connection clk_0.clk_reset video_scaler_0.reset

add_connection clk_0.clk_reset video_stream_router_0.reset

add_connection clk_0.clk_reset video_stream_router_1.reset

add_connection clk_0.clk_reset video_vga_controller.reset

add_connection fpga_only_master.master altpll_0.pll_slave
set_connection_parameter_value fpga_only_master.master/altpll_0.pll_slave arbitrationPriority {1}
set_connection_parameter_value fpga_only_master.master/altpll_0.pll_slave baseAddress {0x0000}
set_connection_parameter_value fpga_only_master.master/altpll_0.pll_slave defaultConnection {0}

add_connection fpga_only_master.master audio_and_video_config_0.avalon_av_config_slave
set_connection_parameter_value fpga_only_master.master/audio_and_video_config_0.avalon_av_config_slave arbitrationPriority {1}
set_connection_parameter_value fpga_only_master.master/audio_and_video_config_0.avalon_av_config_slave baseAddress {0x0030}
set_connection_parameter_value fpga_only_master.master/audio_and_video_config_0.avalon_av_config_slave defaultConnection {0}

add_connection fpga_only_master.master pixel_buffer.s1
set_connection_parameter_value fpga_only_master.master/pixel_buffer.s1 arbitrationPriority {1}
set_connection_parameter_value fpga_only_master.master/pixel_buffer.s1 baseAddress {0x04000000}
set_connection_parameter_value fpga_only_master.master/pixel_buffer.s1 defaultConnection {0}

add_connection fpga_only_master.master pixel_onchip_buffer.s1
set_connection_parameter_value fpga_only_master.master/pixel_onchip_buffer.s1 arbitrationPriority {1}
set_connection_parameter_value fpga_only_master.master/pixel_onchip_buffer.s1 baseAddress {0x00040000}
set_connection_parameter_value fpga_only_master.master/pixel_onchip_buffer.s1 defaultConnection {0}

add_connection fpga_only_master.master video_dma_controller.avalon_dma_control_slave
set_connection_parameter_value fpga_only_master.master/video_dma_controller.avalon_dma_control_slave arbitrationPriority {1}
set_connection_parameter_value fpga_only_master.master/video_dma_controller.avalon_dma_control_slave baseAddress {0x0010}
set_connection_parameter_value fpga_only_master.master/video_dma_controller.avalon_dma_control_slave defaultConnection {0}

add_connection fpga_only_master.master video_pixel_buffer_dma.avalon_control_slave
set_connection_parameter_value fpga_only_master.master/video_pixel_buffer_dma.avalon_control_slave arbitrationPriority {1}
set_connection_parameter_value fpga_only_master.master/video_pixel_buffer_dma.avalon_control_slave baseAddress {0x0020}
set_connection_parameter_value fpga_only_master.master/video_pixel_buffer_dma.avalon_control_slave defaultConnection {0}

add_connection fpga_only_master.master_reset altpll_0.inclk_interface_reset

add_connection fpga_only_master.master_reset audio_and_video_config_0.reset

add_connection fpga_only_master.master_reset fpga_only_master.clk_reset

add_connection fpga_only_master.master_reset pixel_buffer.reset

add_connection fpga_only_master.master_reset pixel_onchip_buffer.reset1

add_connection fpga_only_master.master_reset sobel_edge_detector_0.reset

add_connection fpga_only_master.master_reset video_bayer_resampler.reset

add_connection fpga_only_master.master_reset video_clipper.reset

add_connection fpga_only_master.master_reset video_decoder_0.reset

add_connection fpga_only_master.master_reset video_dma_controller.reset

add_connection fpga_only_master.master_reset video_dual_clock_buffer.reset_stream_in

add_connection fpga_only_master.master_reset video_dual_clock_buffer.reset_stream_out

add_connection fpga_only_master.master_reset video_pixel_buffer_dma.reset

add_connection fpga_only_master.master_reset video_pixel_rgb_resampler_1.reset

add_connection fpga_only_master.master_reset video_pll.ref_reset

add_connection fpga_only_master.master_reset video_rgb_resampler.reset

add_connection fpga_only_master.master_reset video_scaler.reset

add_connection fpga_only_master.master_reset video_scaler_0.reset

add_connection fpga_only_master.master_reset video_stream_router_0.reset

add_connection fpga_only_master.master_reset video_stream_router_1.reset

add_connection fpga_only_master.master_reset video_vga_controller.reset

add_connection sobel_edge_detector_0.avalon_streaming_source video_stream_router_1.avalon_stream_router_sink_1

add_connection video_bayer_resampler.avalon_bayer_source video_clipper.avalon_clipper_sink

add_connection video_clipper.avalon_clipper_source video_scaler.avalon_scaler_sink

add_connection video_decoder_0.avalon_decoder_source video_bayer_resampler.avalon_bayer_sink

add_connection video_dma_controller.avalon_dma_master pixel_onchip_buffer.s1
set_connection_parameter_value video_dma_controller.avalon_dma_master/pixel_onchip_buffer.s1 arbitrationPriority {1}
set_connection_parameter_value video_dma_controller.avalon_dma_master/pixel_onchip_buffer.s1 baseAddress {0x00040000}
set_connection_parameter_value video_dma_controller.avalon_dma_master/pixel_onchip_buffer.s1 defaultConnection {0}

add_connection video_dual_clock_buffer.avalon_dc_buffer_source video_vga_controller.avalon_vga_sink

add_connection video_pixel_buffer_dma.avalon_pixel_dma_master pixel_onchip_buffer.s1
set_connection_parameter_value video_pixel_buffer_dma.avalon_pixel_dma_master/pixel_onchip_buffer.s1 arbitrationPriority {1}
set_connection_parameter_value video_pixel_buffer_dma.avalon_pixel_dma_master/pixel_onchip_buffer.s1 baseAddress {0x00040000}
set_connection_parameter_value video_pixel_buffer_dma.avalon_pixel_dma_master/pixel_onchip_buffer.s1 defaultConnection {0}

add_connection video_pixel_buffer_dma.avalon_pixel_source video_scaler_0.avalon_scaler_sink

add_connection video_pixel_rgb_resampler_1.avalon_rgb_source video_dual_clock_buffer.avalon_dc_buffer_sink

add_connection video_pll.reset_source altpll_0.inclk_interface_reset

add_connection video_pll.reset_source audio_and_video_config_0.reset

add_connection video_pll.reset_source fpga_only_master.clk_reset

add_connection video_pll.reset_source pixel_buffer.reset

add_connection video_pll.reset_source pixel_onchip_buffer.reset1

add_connection video_pll.reset_source sobel_edge_detector_0.reset

add_connection video_pll.reset_source video_bayer_resampler.reset

add_connection video_pll.reset_source video_clipper.reset

add_connection video_pll.reset_source video_decoder_0.reset

add_connection video_pll.reset_source video_dma_controller.reset

add_connection video_pll.reset_source video_dual_clock_buffer.reset_stream_in

add_connection video_pll.reset_source video_dual_clock_buffer.reset_stream_out

add_connection video_pll.reset_source video_pixel_buffer_dma.reset

add_connection video_pll.reset_source video_pixel_rgb_resampler_1.reset

add_connection video_pll.reset_source video_pll.ref_reset

add_connection video_pll.reset_source video_rgb_resampler.reset

add_connection video_pll.reset_source video_scaler.reset

add_connection video_pll.reset_source video_scaler_0.reset

add_connection video_pll.reset_source video_stream_router_0.reset

add_connection video_pll.reset_source video_stream_router_1.reset

add_connection video_pll.reset_source video_vga_controller.reset

add_connection video_pll.vga_clk video_dual_clock_buffer.clock_stream_out

add_connection video_pll.vga_clk video_vga_controller.clk

add_connection video_rgb_resampler.avalon_rgb_source video_stream_router_0.avalon_stream_router_sink

add_connection video_scaler.avalon_scaler_source video_rgb_resampler.avalon_rgb_sink

add_connection video_scaler_0.avalon_scaler_source video_pixel_rgb_resampler_1.avalon_rgb_sink

add_connection video_stream_router_0.avalon_stream_router_source_0 video_stream_router_1.avalon_stream_router_sink_0

add_connection video_stream_router_0.avalon_stream_router_source_1 sobel_edge_detector_0.avalon_streaming_sink

add_connection video_stream_router_1.avalon_stream_router_source video_dma_controller.avalon_dma_sink

# interconnect requirements
set_interconnect_requirement {$system} {qsys_mm.clockCrossingAdapter} {HANDSHAKE}
set_interconnect_requirement {$system} {qsys_mm.maxAdditionalLatency} {1}

save_system {soc_video_system.qsys}
