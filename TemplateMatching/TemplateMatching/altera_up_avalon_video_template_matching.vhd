LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.std_logic_misc.all;
USE work.TemplateMatchingTypePckg.all;

ENTITY altera_up_avalon_video_template_matching IS 

GENERIC (
  
  WIDTH  :INTEGER                  := 320 -- Image width in pixels
  
);

PORT (
  
  -- Inputs
  clk                :IN    STD_LOGIC;
  reset              :IN    STD_LOGIC;

  in_data            :IN    STD_LOGIC_VECTOR( 7 DOWNTO  0);  
  in_startofpacket   :IN    STD_LOGIC;
  in_endofpacket     :IN    STD_LOGIC;
  in_valid           :IN    STD_LOGIC;

  out_ready          :IN    STD_LOGIC;

  bypass             :IN    STD_LOGIC;

  in_template        :IN    Window_t; -- remove????  
  -- Bidirectional

  -- Outputs
  in_ready           :BUFFER  STD_LOGIC;

  out_data           :BUFFER  STD_LOGIC_VECTOR( 7 DOWNTO  0);  
  out_startofpacket  :BUFFER  STD_LOGIC;
  out_endofpacket    :BUFFER  STD_LOGIC;
  out_valid          :BUFFER  STD_LOGIC

);

END ENTITY;

ARCHITECTURE arch OF altera_up_avalon_video_template_matching IS
-- *****************************************************************************
-- *                           Constant Declarations                           *
-- *****************************************************************************

-- *****************************************************************************
-- *                       Internal Signals Declarations                       *
-- *****************************************************************************
  
  -- Internal Wires --
  SIGNAL transfer_data        :STD_LOGIC;
  
  -- Row buffer
  signal row_valid            :std_logic;  
  signal row_data             :ImageRow_t; 
  signal row_begin            :std_logic;  
  
  -- Window buffer
  signal window_data          :window_buffer_data_output_t;
  signal window_valid         :std_logic;
  
  -- SADs
  signal template             :Window_t;
  signal sad0_score           :Score_t;
  signal sad0_valid           :std_logic;
  signal sad0_x               :X_t;
  signal sad0_y               :Y_t;
  signal sad1_score           :Score_t;
  signal sad1_valid           :std_logic;
  signal sad1_x               :X_t;
  signal sad1_y               :Y_t;
  --signal sad2_score           :Score_t;
  --signal sad2_valid           :std_logic;
  --signal sad2_x               :X_t;
  --signal sad2_y               :Y_t;
  
  signal sad0_scoreInfo       :ScoreInfo_t;
  signal sad1_scoreInfo       :ScoreInfo_t;
  --signal sad2_scoreInfo       :ScoreInfo_t;
  
  -- Threshold
  signal sad_valid            :std_logic_vector(NUM_SAD-1 downto 0);
  signal sad_scoreInfo        :threshold_data_inputs_t;
  signal threshold_x          :X_t;
  signal threshold_y          :Y_t;
  signal threshold_valid      :std_logic;
  
  -- Square Drawer
  signal final_value          :STD_LOGIC_VECTOR( 7 DOWNTO  0); 
  signal square_drawer_startofpacket :std_logic;
  signal square_drawer_endofpacket   :std_logic;
  signal square_drawer_valid         :std_logic;
  
  -- Pixel info
  SIGNAL pixel_info_in        :STD_LOGIC_VECTOR( 1 DOWNTO  0);  
  SIGNAL pixel_info_out       :STD_LOGIC_VECTOR( 1 DOWNTO  0);  
  
  -- Shifted ST bus
  signal valid_shifted        :std_logic;
  signal startofpacket_shifted:std_logic;
  signal endofpacket_shifted  :std_logic;
  
  -- Internal Registers
  SIGNAL data                 :STD_LOGIC_VECTOR( 7 DOWNTO  0);  
  SIGNAL data_shifted         :STD_LOGIC_VECTOR( 7 DOWNTO  0);  
  SIGNAL startofpacket        :STD_LOGIC;
  SIGNAL endofpacket          :STD_LOGIC;
  SIGNAL valid                :STD_LOGIC;

  SIGNAL  flush_pipeline      :STD_LOGIC;
  
  -- State Machine Registers
  
  -- Integers
  

BEGIN
  template <= in_template;
  sad_scoreInfo.score <= sad_score;
  sad_scoreInfo.x     <= sad_x;
  sad_scoreInfo.y     <= sad_y;
  
  sad_valid            <= sad_valid;
  sad_scoreInfo        <= sad_scoreInfo;
  
-- *****************************************************************************
-- *                         Finite State Machine(s)                           *
-- *****************************************************************************


-- *****************************************************************************
-- *                             Sequential Logic                              *
-- *****************************************************************************

  -- Output Registers ??????????????
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF (reset = '1') THEN
        out_data        <= B"00000000";
        out_startofpacket  <= '0';
        out_endofpacket  <= '0';
        out_valid      <= '0';
      ELSIF (transfer_data = '1') THEN
        if (bypass = '1') then
          out_data         <= data_shifted;
        else
          out_data         <= final_value;
        end if;
        out_startofpacket  <= square_drawer_startofpacket;
        out_endofpacket    <= square_drawer_endofpacket;
        out_valid          <= square_drawer_valid;
      ELSIF (out_ready = '1') THEN
        out_valid          <= '0';
      END IF;
    END IF;
  END PROCESS;


  -- Internal Registers
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF (reset = '1') THEN
        data          <= B"00000000";
        startofpacket <= '0';
        endofpacket   <= '0';
        valid         <= '0';
      ELSIF (in_ready = '1') THEN
        data          <= in_data;
        startofpacket <= in_startofpacket;
        endofpacket   <= in_endofpacket;
        valid         <= in_valid;
      END IF;
    END IF;
  END PROCESS;

  -- Flush pipeline
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF (reset = '1') THEN
        flush_pipeline    <= '0';
      ELSIF ((in_ready = '1') AND (in_endofpacket = '1')) THEN
        flush_pipeline    <= '1';
      ELSIF ((in_ready = '1') AND (in_startofpacket = '1')) THEN
        flush_pipeline    <= '0';
      END IF;
    END IF;
  END PROCESS;


-- *****************************************************************************
-- *                            Combinational Logic                            *
-- *****************************************************************************
  -- Output Assignments
  in_ready <= in_valid AND (out_ready OR NOT out_valid);

  -- Internal Assignments
  transfer_data <= in_ready OR 
      (flush_pipeline AND (out_ready OR NOT out_valid));

  pixel_info_in(1) <= in_valid AND NOT in_endofpacket; 
  pixel_info_in(0) <= in_valid AND NOT in_startofpacket;
  
  valid_shifted         <= (OR_REDUCE (pixel_info_out));
  startofpacket_shifted <= pixel_info_out(1) AND NOT pixel_info_out(0);
  endofpacket_shifted   <= pixel_info_out(0) AND NOT pixel_info_out(1);
-- *****************************************************************************
-- *                          Component Instantiations                         *
-- *****************************************************************************
  Row_buffer_l: entity work.row_buffer
  port map (
    -- inputs
    clk               => clk,
    reset             => reset,

    in_data           => data,
    in_startofpacket  => startofpacket,
    in_endofpacket    => endofpacket,
    in_valid          => transfer_data,

    -- Outputs
    in_ready          => in_ready,
    out_valid         => row_valid,
    out_data          => row_data,
    out_begin         => row_begin
  );
  
  window_buffer_l: entity work.window_buffer
  port map (
    -- inputs
    clk               => clk,
    reset             => reset,

    in_data           => row_data,
    in_valid          => row_valid,
    in_begin          => row_begin,

    -- Outputs
    out_data          => window_data,
    out_valid         => window_valid
  );

  sad_l: entity work.sad
  port map (
    -- inputs
    clk               => clk,
    reset             => reset,
    
    template          => template,
    window_info       => window_data(0),
    valid_in          => window_valid,
    
    -- output
    score_out         => sad_score,
    valid_out         => sad_valid,
    x_out             => sad_x,
    y_out             => sad_y
  );
  
  threshold_l: entity work.threshold
  generic map(
    THRESHOLD => B"000000000001000000",
    X_MAX     => LAST_X,
    Y_MAX     => LAST_Y)
  port map (
  -- Inputs
    clk                   => clk,
    reset                 => reset,
    
    valid_in              => sad_valid,   
    scores_in             => sad_scoreInfo,

    -- Outputs
    x_out                 => threshold_x,
    y_out                 => threshold_y,
    valid_out             => threshold_valid); 
  
  square_drawer_l: entity work.square_drawer
  port map (
    clk               => clk,
    reset             => reset,
    in_data           => data_shifted,
    in_startofpacket  => startofpacket_shifted,
    in_endofpacket    => endofpacket_shifted,
    in_valid          => valid_shifted,
    in_xy_valid       => threshold_valid,
    in_x              => threshold_x,
    in_y              => threshold_y,
    out_data          => final_value,
    out_startofpacket => square_drawer_startofpacket,
    out_endofpacket   => square_drawer_endofpacket,
    out_valid         => square_drawer_valid);
  
  -- defparam Pixel_Info_Shift_Register.SIZE = WIDTH;  
  Pixel_Info_Shift_Register : entity work.altera_up_edge_detection_pixel_info_shift_register 
  GENERIC MAP ( 
    SIZE    => SHIFTS
  )
  PORT MAP (
    -- Inputs
    clock    => clk,
    clken    => transfer_data,
    
    shiftin  => pixel_info_in,

    -- Outputs
    shiftout  => pixel_info_out
  );

  Pixel_Data_Shift_Register : entity work.altera_up_edge_detection_data_shift_register
      generic map (
                   SIZE => SHIFTS,
                   DW   => 8
  )
      port map (
                clken    => transfer_data,
                clock    => clk,
                shiftin  => data,
                shiftout => data_shifted,
                taps     => open
   );  
  

END ARCHITECTURE;
