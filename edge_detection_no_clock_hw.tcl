# _hw.tcl file for edge_detection_no_clock
package require -exact qsys 14.0

# module properties
set_module_property NAME {edge_detection_no_clock_export}
set_module_property DISPLAY_NAME {edge_detection_no_clock_export_display}

# default module properties
set_module_property VERSION {1.0}
set_module_property GROUP {default group}
set_module_property DESCRIPTION {default description}
set_module_property AUTHOR {author}

set_module_property COMPOSITION_CALLBACK compose
set_module_property opaque_address_map false

proc compose { } {
    # Instances and instance parameters
    # (disabled instances are intentionally culled)
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

    # connections and connection parameters
    add_connection sobel_edge_detector_0.avalon_streaming_source video_stream_router_1.avalon_stream_router_sink_1 avalon_streaming

    add_connection video_bayer_resampler.avalon_bayer_source video_clipper.avalon_clipper_sink avalon_streaming

    add_connection video_clipper.avalon_clipper_source video_scaler.avalon_scaler_sink avalon_streaming

    add_connection video_decoder_0.avalon_decoder_source video_bayer_resampler.avalon_bayer_sink avalon_streaming

    add_connection video_dma_controller.avalon_dma_master pixel_onchip_buffer.s1 avalon
    set_connection_parameter_value video_dma_controller.avalon_dma_master/pixel_onchip_buffer.s1 arbitrationPriority {1}
    set_connection_parameter_value video_dma_controller.avalon_dma_master/pixel_onchip_buffer.s1 baseAddress {0x00040000}
    set_connection_parameter_value video_dma_controller.avalon_dma_master/pixel_onchip_buffer.s1 defaultConnection {0}

    add_connection video_dual_clock_buffer.avalon_dc_buffer_source video_vga_controller.avalon_vga_sink avalon_streaming

    add_connection video_pixel_buffer_dma.avalon_pixel_dma_master pixel_onchip_buffer.s1 avalon
    set_connection_parameter_value video_pixel_buffer_dma.avalon_pixel_dma_master/pixel_onchip_buffer.s1 arbitrationPriority {1}
    set_connection_parameter_value video_pixel_buffer_dma.avalon_pixel_dma_master/pixel_onchip_buffer.s1 baseAddress {0x00040000}
    set_connection_parameter_value video_pixel_buffer_dma.avalon_pixel_dma_master/pixel_onchip_buffer.s1 defaultConnection {0}

    add_connection video_pixel_buffer_dma.avalon_pixel_source video_scaler_0.avalon_scaler_sink avalon_streaming

    add_connection video_pixel_rgb_resampler_1.avalon_rgb_source video_dual_clock_buffer.avalon_dc_buffer_sink avalon_streaming

    add_connection video_pll.reset_source audio_and_video_config_0.reset reset

    add_connection video_pll.reset_source pixel_onchip_buffer.reset1 reset

    add_connection video_pll.reset_source sobel_edge_detector_0.reset reset

    add_connection video_pll.reset_source video_bayer_resampler.reset reset

    add_connection video_pll.reset_source video_clipper.reset reset

    add_connection video_pll.reset_source video_decoder_0.reset reset

    add_connection video_pll.reset_source video_dma_controller.reset reset

    add_connection video_pll.reset_source video_dual_clock_buffer.reset_stream_in reset

    add_connection video_pll.reset_source video_dual_clock_buffer.reset_stream_out reset

    add_connection video_pll.reset_source video_pixel_buffer_dma.reset reset

    add_connection video_pll.reset_source video_pixel_rgb_resampler_1.reset reset

    add_connection video_pll.reset_source video_pll.ref_reset reset

    add_connection video_pll.reset_source video_rgb_resampler.reset reset

    add_connection video_pll.reset_source video_scaler.reset reset

    add_connection video_pll.reset_source video_scaler_0.reset reset

    add_connection video_pll.reset_source video_stream_router_0.reset reset

    add_connection video_pll.reset_source video_stream_router_1.reset reset

    add_connection video_pll.reset_source video_vga_controller.reset reset

    add_connection video_pll.vga_clk video_dual_clock_buffer.clock_stream_out clock

    add_connection video_pll.vga_clk video_vga_controller.clk clock

    add_connection video_rgb_resampler.avalon_rgb_source video_stream_router_0.avalon_stream_router_sink avalon_streaming

    add_connection video_scaler.avalon_scaler_source video_rgb_resampler.avalon_rgb_sink avalon_streaming

    add_connection video_scaler_0.avalon_scaler_source video_pixel_rgb_resampler_1.avalon_rgb_sink avalon_streaming

    add_connection video_stream_router_0.avalon_stream_router_source_0 video_stream_router_1.avalon_stream_router_sink_0 avalon_streaming

    add_connection video_stream_router_0.avalon_stream_router_source_1 sobel_edge_detector_0.avalon_streaming_sink avalon_streaming

    add_connection video_stream_router_1.avalon_stream_router_source video_dma_controller.avalon_dma_sink avalon_streaming

    # exported interfaces
    add_interface clk_video clock source
    set_interface_property clk_video EXPORT_OF video_pll.video_in_clk
    add_interface edge_detect conduit end
    set_interface_property edge_detect EXPORT_OF sobel_edge_detector_0.conduit_end
    add_interface vga conduit end
    set_interface_property vga EXPORT_OF video_vga_controller.external_interface
    add_interface video_config conduit end
    set_interface_property video_config EXPORT_OF audio_and_video_config_0.external_interface
    add_interface video_in_decoder conduit end
    set_interface_property video_in_decoder EXPORT_OF video_decoder_0.external_interface
    add_interface video_merge conduit end
    set_interface_property video_merge EXPORT_OF video_stream_router_1.external_interface
    add_interface video_split conduit end
    set_interface_property video_split EXPORT_OF video_stream_router_0.external_interface

    # interconnect requirements
    set_interconnect_requirement {$system} {qsys_mm.clockCrossingAdapter} {HANDSHAKE}
    set_interconnect_requirement {$system} {qsys_mm.maxAdditionalLatency} {1}
}
