library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use std.textio.all;
use work.TemplateMatchingTypePckg.all;
use work.io_utils.all;

entity row_buffer is
  port (
    -- inputs
    clk               :in    std_logic;
    reset             :in    std_logic;

    in_data           :in    std_logic_vector( 7 DOWNTO  0);  
    in_startofpacket  :in    std_logic;
    in_endofpacket    :in    std_logic;
    in_valid          :in    std_logic;

    -- Bidirectional

    -- Outputs
    in_ready          :buffer  std_logic  := '1';
    out_valid         :out   std_logic    := '0';
    out_data          :out   ImageRow_t   := ImageRow_t_init;
    out_begin         :out   std_logic    := '0'

  );
end entity;


architecture arch of row_buffer is
  -- declare signals, components here...
    signal start_row   : std_logic                           := '0';
begin
  row_buffer: process (clk)
    variable counter     : integer range 0 to IMAGE_WIDTH    := 0;
    variable data        : ImageRow_t                        := ImageRow_t_init;
  begin
    if rising_edge(clk) then
      out_valid <= '0';
      if reset = '1' then
        data := ImageRow_t_init;
        counter := 0;
        start_row <= '0';
        out_valid <= '0';
        out_data <= data;
        out_begin <= '0';
      
      elsif in_valid = '1' then
        if in_startofpacket = '1' then
          start_row <= '1';
        end if;
        
        data(counter) := unsigned(in_data);
        counter := counter + 1;
        
        if counter = IMAGE_WIDTH then
          out_data <= data;
          out_valid <= '1';
          out_begin <= start_row;
          start_row <= '0';
          counter := 0;
        end if;
      end if;
    end if;
  end process;
end architecture;
