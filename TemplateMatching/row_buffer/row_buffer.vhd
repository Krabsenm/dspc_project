library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use std.textio.all;
use work.TemplateMatchingTypePckg.all;
use work.io_utils.all;

entity row_buffer is
  GENERIC (
    row_width :INTEGER    := IMAGE_WIDTH   -- Image width in pixels
  );
  port (
    -- inputs
    clk               :in    std_logic;
    reset             :in    std_logic;

    in_valid          :in    std_logic;
    in_data           :in    Pixel_t;

    -- Bidirectional

    -- Outputs
    out_valid         :out   std_logic;
    out_data          :out   ImageRow_t

  );
end entity;

architecture arch of row_buffer is
  -- declare signals, components here...
  signal data : ImageRow_t;
  
begin

  input_pixel: process (clk, reset)
    variable counter : integer range 0 to IMAGE_WIDTH;
  begin
    if rising_edge(reset) then
        counter := 0;
    end if;
  
    if falling_edge(clk) then
      if in_valid = '1' then
        data(counter) <= in_data;
        counter := counter + 1;
      else
        counter := 0;
      end if;
    end if;
  end process;

  output_row: process (clk, reset)
    variable in_valid_prev : std_logic;
  begin
    if rising_edge(reset) then
        out_data <= ImageRow_t_init;
        out_valid <= '0';
    end if;
    
    if rising_edge(clk) then
      out_valid <= '0';
      if (in_valid = '0' AND in_valid_prev = '1') then
        out_data <= data;
        out_valid <= '1';
      end if;
      in_valid_prev := in_valid;
    end if;
  end process;
  
end architecture;
