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

    -- Outputs
    in_ready          :buffer   std_logic    := 'Z';
    out_valid         :buffer   std_logic    := '0';
    out_data          :buffer   ImageRow_t   := ImageRow_t_init
  );
end entity;


architecture arch of row_buffer is
    signal data        : ImageRow_t                        := ImageRow_t_init; -- Stores pixels until at row has been collected
    signal counter     : integer range 0 to IMAGE_WIDTH    := 0;               -- Counts the number of pixels put into the data signal                                                                         
begin
  row_buffer: process (clk)
   begin
    if rising_edge(clk) then
      out_valid <= '0';
      
      if reset = '1' then
        data      <= ImageRow_t_init;
        counter   <=  0 ;
        out_valid <= '0';
      
      elsif in_valid = '1' then
        data(counter) <= unsigned(in_data);
        counter <= counter + 1;
        
        -- When counter is at 319, there is 320 pixels in data, which is a whole row.
        -- The row is transferred to the output, valid is set high and the counter is reset.
        if counter = (IMAGE_WIDTH-1) then
          out_data  <= data;
          out_valid <= '1';
          counter   <=  0;
        end if;
      end if;
    end if;
  end process;
end architecture;