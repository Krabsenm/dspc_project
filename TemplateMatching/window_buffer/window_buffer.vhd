library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.TemplateMatchingTypePckg.all;
--library unisim;
--use unisim.vcomponents.all;

entity window_buffer is
  generic (
    -- Generics go here...
  );
  port (
    -- Inputs
    clk               :IN    STD_LOGIC;
    reset             :IN    STD_LOGIC;

    in_data           :IN    STD_LOGIC_VECTOR( 7 DOWNTO  0);  
    in_startofpacket  :IN    STD_LOGIC;
    in_endofpacket    :IN    STD_LOGIC;
    in_valid          :IN    STD_LOGIC;

    out_ready         :IN    STD_LOGIC;

    -- Bidirectional

    -- Outputs
    in_ready          :BUFFER  STD_LOGIC;

    out_data          :BUFFER  STD_LOGIC_VECTOR( 7 DOWNTO  0);  
    out_startofpacket :BUFFER  STD_LOGIC;
    out_endofpacket   :BUFFER  STD_LOGIC;
    out_valid         :BUFFER  STD_LOGIC
  );
end entity;
