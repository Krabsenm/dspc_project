LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.std_logic_misc.all;


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
  
  -- Internal Wires
  SIGNAL transfer_data       :STD_LOGIC;
  
  signal row_valid           :std_logic;  -- Row_buffer
  signal row_data            :ImageRow_t; -- Row_buffer
  signal row_begin           :std_logic;  -- Row_buffer
  signal window_data         :window_buffer_data_output_t;
  signal window_valid        :std_logic;
  SIGNAL final_value         :STD_LOGIC_VECTOR( 7 DOWNTO  0); 
  
  SIGNAL pixel_info_in       :STD_LOGIC_VECTOR( 1 DOWNTO  0);  
  SIGNAL pixel_info_out      :STD_LOGIC_VECTOR( 1 DOWNTO  0);  
  
  -- Internal Registers
  SIGNAL data                :STD_LOGIC_VECTOR( 7 DOWNTO  0);  
  SIGNAL data_shifted        :STD_LOGIC_VECTOR( 7 DOWNTO  0);  
  SIGNAL startofpacket       :STD_LOGIC;
  SIGNAL endofpacket         :STD_LOGIC;
  SIGNAL valid               :STD_LOGIC;

  SIGNAL  flush_pipeline      :STD_LOGIC;
  
  -- State Machine Registers
  
  -- Integers
  

BEGIN
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
          out_data        <= data_shifted;
        else
          out_data        <= final_value;
        end if;
        out_startofpacket  <= pixel_info_out(1) AND NOT (AND_REDUCE (pixel_info_out));
        out_endofpacket  <= pixel_info_out(0) AND NOT (AND_REDUCE (pixel_info_out));
        out_valid      <= (OR_REDUCE (pixel_info_out));
      ELSIF (out_ready = '1') THEN
        out_valid      <= '0';
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

  -- Output from drawer.........
  final_value <= ???;

  pixel_info_in(1) <= in_valid AND NOT in_endofpacket; 
  pixel_info_in(0) <= in_valid AND NOT in_startofpacket;

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

  sad0_l: entity work.sad
  port map (
    -- inputs
    clk               => clk,
    reset             => reset,
    
    template          => template,
    window_info       => window_data(0),
    valid_in          => window_valid,
    
    -- output
    score_out         => sad0_score,
    valid_out         => sad0_valid,
    x_out             => sad0_x,
    y_out             => sad0_y
  );
  
  sad1_l: entity work.sad
  port map (
    -- inputs
    clk               => clk,
    reset             => reset,
    
    template          => template,
    window_info       => window_data(1),
    valid_in          => window_valid,
    
    -- output
    score_out         => sad1_score,
    valid_out         => sad1_valid,
    x_out             => sad1_x,
    y_out             => sad1_y
  );
  
  sad2_l: entity work.sad
  port map (
    -- inputs
    clk               => clk,
    reset             => reset,
    
    template          => template,
    window_info       => window_data(2),
    valid_in          => window_valid,
    
    -- output
    score_out         => sad2_score,
    valid_out         => sad2_valid,
    x_out             => sad2_x,
    y_out             => sad2_y
  );
  
  
  -- defparam Pixel_Info_Shift_Register.SIZE = WIDTH;  
  Pixel_Info_Shift_Register : entity work.altera_up_edge_detection_pixel_info_shift_register 
  GENERIC MAP ( 
    SIZE    => (WIDTH * 5) + 28
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
                   SIZE => (WIDTH * 5) + 28,
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
