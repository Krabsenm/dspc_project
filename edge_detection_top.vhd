-- ============================================================================
-- Copyright (c) 2013 by Terasic Technologies Inc.
-- ============================================================================
--
-- Permission:
--
--   Terasic grants permission to use and modify this code for use
--   in synthesis for all Terasic Development Boards and Altera Development 
--   Kits made by Terasic.  Other use of this code, including the selling 
--   ,duplication, or modification of any portion is strictly prohibited.
--
-- Disclaimer:
--
--   This VHDL/Verilog or C/C++ source code is intended as a design reference
--   which illustrates how these types of functions can be implemented.
--   It is the user's responsibility to verify their design for
--   consistency and functionality through the use of formal
--   verification methods.  Terasic provides no warranty regarding the use 
--   or functionality of this code.
--
-- ============================================================================
--           
--  Terasic Technologies Inc
--  9F., No.176, Sec.2, Gongdao 5th Rd, East Dist, Hsinchu City, 30070. Taiwan
--  
--  
--                     web: http:--www.terasic.com/  
--                     email: support@terasic.com
--
-- ============================================================================
--Date:  Mon Jun 17 20:35:29 2013
-- ============================================================================


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity edge_detection_top is
  port (
    CLOCK_50    : in   std_logic;
    CLOCK2_50    : in   std_logic;
      
    GPIO             : inout   std_logic_vector(35 downto 0);
      
    KEY             :in   std_logic_vector(1 downto 0);
    
    LEDR            :out std_logic_vector(9 downto 0);    
    
    SW              :in   std_logic_vector(9 downto 0);
       
    VGA_R           :out  std_logic_vector(3 downto 0);
    VGA_G           :out  std_logic_vector(3 downto 0);
    VGA_B           :out  std_logic_vector(3 downto 0);
    VGA_HS          :out  std_logic;
    VGA_VS	        :out  std_logic;
    --VGA_CLK         :out  std_logic; -- Not on DE10Lite
    --VGA_SYNC_N      :out  std_logic; -- Not on DE10Lite
    --VGA_BLANK_N     :out  std_logic  -- Not on DE10Lite
	 
	 DRAM_ADDR      : out  std_logic_vector(12 downto 0);
    DRAM_BA        : out  std_logic_vector(1 downto 0);
    DRAM_CAS_N     : out  std_logic;
    DRAM_CKE       : out  std_logic;
    DRAM_CLK       : out  std_logic;
    DRAM_CS_N      : out  std_logic;
    DRAM_DQ        : inout   std_logic_vector(15 downto 0);
    DRAM_LDQM      : out  std_logic;
    DRAM_RAS_N     : out  std_logic;
    DRAM_UDQM      : out  std_logic;
    DRAM_WE_N      : out  std_logic
	 
   );

end edge_detection_top;

architecture behaviour of edge_detection_top is

signal hps_fpga_reset_n : std_logic;
signal hps_cold_reset : std_logic;
signal hps_warm_reset : std_logic;
signal hps_debug_reset : std_logic;
signal stm_hw_events : std_logic_vector(27 downto 0);

-- Video
signal video_data : std_logic_vector (11 downto 0);
signal video_pixel_clk : std_logic; -- Camera pixel clk
signal video_frame_valid : std_logic;
signal video_line_valid : std_logic;
signal video_sda  : std_logic; -- IIC data
signal video_sclk : std_logic; -- IIC clock
signal video_clk : std_logic;  -- Camera base clock
signal sdram_dqm : std_logic_vector (1 downto 0) := "00";
signal vga_clk_s : std_logic;
signal vga_r_s, vga_g_s, vga_b_s: std_logic_vector (7 downto 0) := "00000000";

signal reset_sys_n, reset_in_n : std_logic;
signal sdram_clk : std_logic;
signal video_clk_running, dram_clk_running : std_logic;


    component soc_video_system is
        port (
            clk_clk                          : in    std_logic                     := 'X';             -- clk
            clk_sdram_clk                    : out   std_logic;                                        -- clk
            clk_video_clk                    : out   std_logic;                                        -- clk
            reset_reset_n                    : in    std_logic                     := 'X';             -- reset_n
            vga_CLK                          : out   std_logic;                                        -- CLK
            vga_HS                           : out   std_logic;                                        -- HS
            vga_VS                           : out   std_logic;                                        -- VS
            vga_BLANK                        : out   std_logic;                                        -- BLANK
            vga_SYNC                         : out   std_logic;                                        -- SYNC
            vga_R                            : out   std_logic_vector(7 downto 0);                     -- R
            vga_G                            : out   std_logic_vector(7 downto 0);                     -- G
            vga_B                            : out   std_logic_vector(7 downto 0);                     -- B
            edge_detect_bypass               : in    std_logic;
            video_config_SDAT                : inout std_logic                     := 'X';             -- SDAT
            video_config_SCLK                : out   std_logic;                                        -- SCLK
            video_in_decoder_PIXEL_CLK       : in    std_logic                     := 'X';             -- PIXEL_CLK
            video_in_decoder_LINE_VALID      : in    std_logic                     := 'X';             -- LINE_VALID
            video_in_decoder_FRAME_VALID     : in    std_logic                     := 'X';             -- FRAME_VALID
            video_in_decoder_pixel_clk_reset : in    std_logic                     := 'X';             -- pixel_clk_reset
            video_in_decoder_PIXEL_DATA      : in    std_logic_vector(11 downto 0) := (others => 'X');  -- PIXEL_DATA
            video_sdram_addr                 : out   std_logic_vector(12 downto 0);                    -- addr
            video_sdram_ba                   : out   std_logic_vector(1 downto 0);                     -- ba
            video_sdram_cas_n                : out   std_logic;                                        -- cas_n
            video_sdram_cke                  : out   std_logic;                                        -- cke
            video_sdram_cs_n                 : out   std_logic;                                        -- cs_n
            video_sdram_dq                   : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
            video_sdram_dqm                  : out   std_logic_vector(1 downto 0);                     -- dqm
            video_sdram_ras_n                : out   std_logic;                                        -- ras_n
            video_sdram_we_n                 : out   std_logic;                                         -- we_n
				video_merge_export               : in    std_logic                     := 'X';             -- export
            video_split_export               : in    std_logic
				
        );
    end component soc_video_system;


begin
	
    u0 : component soc_video_system
        port map (
            clk_clk                               => CLOCK_50,
            clk_sdram_clk                         => sdram_clk,
            clk_video_clk                         => video_clk,
            reset_reset_n                         => reset_sys_n,
            vga_CLK                               => open, --vga_clk_s,                         
            vga_HS                                => VGA_HS,                          
            vga_VS                                => VGA_VS,                          
            vga_BLANK                             => open, --VGA_BLANK_N,                       
            vga_SYNC                              => open, --VGA_SYNC_N,
            vga_R                                 => vga_r_s,                           
            vga_G                                 => vga_g_s,                           
            vga_B                                 => vga_b_s,                           
  			edge_detect_bypass                       => SW(0),
            video_config_SDAT                     => video_sda,
            video_config_SCLK                     => video_sclk,
            video_in_decoder_PIXEL_CLK            => video_pixel_clk,
            video_in_decoder_LINE_VALID           => video_line_valid,
            video_in_decoder_FRAME_VALID          => video_frame_valid,
            video_in_decoder_pixel_clk_reset      => not KEY(1), --not KEY(1), -- Positive logic??
            video_in_decoder_PIXEL_DATA           => video_data,
            video_sdram_addr                 => DRAM_ADDR, 
            video_sdram_ba                   => DRAM_BA,   
            video_sdram_cas_n                => DRAM_CAS_N,
            video_sdram_cke                  => DRAM_CKE,  
            video_sdram_cs_n                 => DRAM_CS_N, 
            video_sdram_dq                   => DRAM_DQ,   
            video_sdram_dqm                  => sdram_dqm,  
            video_sdram_ras_n                => DRAM_RAS_N,
            video_sdram_we_n                 => DRAM_WE_N,  
				video_merge_export               => SW(6),
            video_split_export               => SW(5)

				);

    -- DRAM Interface
	DRAM_UDQM <= sdram_dqm(1);
	DRAM_LDQM <= sdram_dqm(0);
	DRAM_CLK  <= sdram_clk;

    -- VGA Interface
	-- VGA_CLK <= vga_clk_s; -- Not used on DE10Lite
	
    -- Debug LEDs
	ledr <= "000000" & dram_clk_running & video_clk_running & KEY;
 
	reset_in_n <= KEY(0);
 
   VGA_R <= vga_r_s(3 downto 0) when SW(9 downto 7) = "000" else
				vga_r_s(4 downto 1) when SW(9 downto 7) = "001" else
				vga_r_s(5 downto 2) when SW(9 downto 7) = "010" else
				vga_r_s(6 downto 3) when SW(9 downto 7) = "011" else
				vga_r_s(7 downto 4) when SW(9 downto 7) = "100" else vga_r_s(3 downto 0);
			
   VGA_G <= vga_g_s(3 downto 0) when SW(9 downto 7) = "000" else
				vga_g_s(4 downto 1) when SW(9 downto 7) = "001" else
				vga_g_s(5 downto 2) when SW(9 downto 7) = "010" else
				vga_g_s(6 downto 3) when SW(9 downto 7) = "011" else
				vga_g_s(7 downto 4) when SW(9 downto 7) = "100" else vga_g_s(3 downto 0);
		
   VGA_B <= vga_b_s(3 downto 0) when SW(9 downto 7) = "000" else
				vga_b_s(4 downto 1) when SW(9 downto 7) = "001" else
				vga_b_s(5 downto 2) when SW(9 downto 7) = "010" else
				vga_b_s(6 downto 3) when SW(9 downto 7) = "011" else
				vga_b_s(7 downto 4) when SW(9 downto 7) = "100" else vga_b_s(3 downto 0);
		
--------------------------------------------------------------------------
-- DB5M Camera Interfacing
-- Camera pin 1 = GPIO(0)
--------------------------------------------------------------------------
   video_pixel_clk <= GPIO(0); -- Pixel clock from Camera
   --video_data <= GPIO(1) & GPIO(3 to 13);
   video_data(11 downto 8) <= (GPIO(1), GPIO(3), GPIO(4), GPIO(5)); -- Video data from Camera    
   video_data(7 downto 4)  <= (GPIO(6), GPIO(7), GPIO(8), GPIO(9)); 
   video_data(3 downto 0)  <= (GPIO(10), GPIO(11), GPIO(12), GPIO(13));
   --video_data(11 downto 8) <= (GPIO(1), GPIO(3), GPIO(4), GPIO(5)); -- Video data from Camera    
   --video_data(7 downto 4)  <= (GPIO(6), GPIO(7), GPIO(8), GPIO(9)); 
   --video_data(3 downto 0)  <= (GPIO(12), GPIO(13), GPIO(14), GPIO(15));
   GPIO(16) <= video_clk;  -- Clock source for Camera
   GPIO(17) <= KEY(1);     -- Reset of Camera
   GPIO(19) <= SW(1);      -- Trigger of Camera
   video_line_valid  <= GPIO(21);
   video_frame_valid <= GPIO(22);
   GPIO(23) <= video_sda;  -- I2C Interface for Camera config
   GPIO(24) <= video_sclk;


   -- Reset Debounce
	reset_proc: process (clock_50)
	   variable reset_status : std_logic_vector(31 downto 0) := (others => '0');
    begin
      if rising_edge(clock_50) then
		 reset_status := reset_status(30 downto 0) & reset_in_n;
		 reset_sys_n <= '1';
		 if reset_status = X"00000000" then
			 reset_sys_n <= '0';
		 end if;
      end if;
    end process;


    -- Flash signal tap clock led at f/2*100M
	flash_led_video_clk: process (video_clk, reset_sys_n)
	variable cnt : integer range 0 to 100000000;
    begin
      if reset_sys_n = '0' then
		cnt := 0;
        video_clk_running <= '0';
      elsif rising_edge(video_clk) then
		  cnt := cnt + 1;
		  if cnt >= 100000000 then 
			 video_clk_running <= not video_clk_running;
			 cnt := 0;
		  end if;
      end if;
    end process;

	 
	 
    -- Flash signal tap clock led at f/2*100M
	flash_led_vga_clk: process (sdram_clk, reset_sys_n)
	variable cnt : integer range 0 to 100000000;
    begin
      if reset_sys_n = '0' then
		cnt := 0;
        dram_clk_running <= '0';
      elsif rising_edge(sdram_clk) then
		  cnt := cnt + 1;
		  if cnt >= 100000000 then 
			 dram_clk_running <= not dram_clk_running;
			 cnt := 0;
		  end if;
      end if;
    end process;
	 
	
end behaviour;
