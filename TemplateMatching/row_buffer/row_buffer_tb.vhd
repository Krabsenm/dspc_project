library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use std.textio.all;
use work.TemplateMatchingTypePckg.all;
use work.io_utils.all;

--------------------------------------------------------------------------------
entity  row_buffer_tb is
    GENERIC (
    image_width :INTEGER    := IMAGE_WIDTH   -- Image width in pixels
    );
end entity ;
--------------------------------------------------------------------------------

architecture Bhv of row_buffer_tb is
  -----------------------------
  -- Port Signals 
  -----------------------------
  signal   clk       : std_logic := '0';
  signal   reset     : std_logic := '1';
  signal   in_valid  : std_logic;
  signal   in_data   : Pixel_t;
  signal   out_valid : std_logic;
  signal   out_data  : ImageRow_t;

    -- clock
  signal end_sim : std_logic := '0';
  constant clockperiod  : time := 10 ns;  -- clk period time
  
begin  -- architecture Bhv

  -----------------------------
  -- component instantiation 
  -----------------------------
  row_buffer_INST: entity work.row_buffer
   port map (
      clk       => clk,
      reset     => reset,
      in_valid  => in_valid,
      in_data   => in_data,
      out_valid => out_valid,
      out_data  => out_data);

	-- clock generation
  clk <= not clk after clockperiod/2 when end_sim = '0' else unaffected; 

  -- reset generation
  reset <= '1', '0' after 125 ns;
  
  StimuliProcess : process
  begin
    in_valid <= '0';
    
    wait until reset = '0';
    wait for clockperiod;
    wait until clk = '1';
    
    in_valid <= '1';

    for i in 0 to image_width-1 loop
      if (i <= 255) then
        in_data <= to_unsigned(i, 8);
      else
        in_data <= to_unsigned(i-255, 8);
      end if;
      
      wait until clk = '0';
      wait until clk = '1';
      
      if i = image_width-1 then
        in_valid <= '0';
      end if;
      
    end loop;
  end process StimuliProcess;
  
  
  MonitorProcess : process
  begin
    wait until reset = '0';
    wait for clockperiod;
    wait until clk = '1';
    
    wait until out_valid = '1';
    
    for i in 0 to image_width-1 loop
      if (i <= 255) then
        assert to_integer(out_data(i)) = i
        report "out_data(" & integer'image(i) & ") got: " & integer'image(to_integer(out_data(i))) & " expected: " & integer'image(i)
        severity error;
      else
        assert to_integer(out_data(i)) = i-255
        report "out_data(" & integer'image(i) & ") got: " & integer'image(to_integer(out_data(i))) & " expected: " & integer'image(i-255)
        severity error;
      end if;
      
      
    
    end loop;
  
    end_sim <= '1';
  end process MonitorProcess;
  
end architecture Bhv;