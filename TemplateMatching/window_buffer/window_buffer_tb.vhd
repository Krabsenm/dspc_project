library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use std.textio.all;
use work.TemplateMatchingTypePckg.all;
use work.io_utils.all;
--library unisim;
--use unisim.vcomponents.all;

--------------------------------------------------------------------------------
entity  window_buffer_tb is
  GENERIC (
    image_width :INTEGER    := IMAGE_WIDTH;   -- Image width in pixels
    image_height:INTEGER    := IMAGE_HEIGHT;            -- Image height in pixels
    image_name: string      := "ImageIn.txt" -- Contains image as text hex input format
  );
end entity ;
--------------------------------------------------------------------------------


architecture arch of window_buffer_tb is
  -----------------------------
  -- Port Signals 
  -----------------------------
  signal   clk       : std_logic := '0';
  signal   reset     : std_logic := '1';
  signal   in_data   : ImageRow_t;
  signal   in_valid  : std_logic := '0';
  
  signal   out_data  : WindowInfo16_t;
  signal   out_valid : std_logic;

      -- clock
  signal end_sim : std_logic := '0';
  constant clockperiod  : time := 10 ns;  -- clk period time
  
begin  -- architecture

  -----------------------------
  -- component instantiation 
  -----------------------------
  window_buffer_INST: entity work.window_buffer
   port map (
      clk       => clk,
      reset     => reset,
      in_data   => in_data,
      in_valid  => in_valid,
      out_data  => out_data,
      out_valid => out_valid);

  -- clock generation
  clk <= not clk after clockperiod/2 when end_sim = '0' else unaffected; 

  -- reset generation
  reset <= '1', '0' after 125 ns;
	

  
  -----------------------------
  -- Stimuli Process
  -----------------------------
  StimuliProcess : process
    variable pixelcount : integer range 0 to image_width;
    variable linecount  : integer range 0 to image_height;
     -- files
    variable line: LINE;
    variable data: integer;
    variable val: signed(31 downto 0);
    file videoinfile: TEXT;-- open read_mode is image_name;
    variable image_row: ImageRow_t;
 begin
    -- Open simulation files
    file_open(videoinfile, image_name);

    wait until reset = '0'; -- reset
    wait for clockperiod; -- one clock periode idle before start 
    wait until clk = '1'; -- Align clock
    
    report "Reading file";
    -- Read video 
    while not endfile(videoinfile) loop
  
      report "Starting to read file";  
      for image in 0 to 1 loop 
      for linecount in 0 to image_height-1 loop
        for pixelcount in 0 to image_width-1 loop
          if not endfile(videoinfile) then
            readline(videoinfile, line); -- read next text line from file
            read(line, data, 10); -- convert decimal (10) numbers to integer value
            image_row(pixelcount) := to_unsigned(data,8);
          end if;
        end loop; -- rows
        
        in_valid <= '1'; -- start sending valid package   
        in_data <= image_row;
      
        wait until clk = '0';
        wait until clk = '1'; --for clockperiod;
        
        in_valid <= '0';
        
        -- Wait the time it would take for 1 row to finish loading
        for i in 0 to IMAGE_WIDTH*2 -2 loop
          wait until clk = '0';
          wait until clk = '1'; --for clockperiod;
        end loop;
        
      end loop; -- columns
    end loop; -- reading video file
    end loop; -- image loop
    
    report "Done reading file"; 
    file_close(videoinfile);     
      
    wait; 
  end process StimuliProcess;
  
  
  -------------------------------------------------------
  -- Monitor Process
  -------------------------------------------------------
  monitor : process
    variable line: LINE;
    variable data: integer;
    file videooutfile: TEXT open write_mode is "ImageOut.txt";
  begin
    -- Create simulation files    
    --file_open(videooutfile, image_outName);
    
    wait until reset = '0';
    wait until out_valid = '1';
    
    assert out_data.x = 0 AND out_data.y = 0
      report "Got: [" & integer'image((out_data.x)) & "," 
        & integer'image((out_data.y)) & "]. Expected: [0,0]"
      severity error;
    
    for row in 0 to TEMPLATE_SIZE/2 - 1 loop
      for pixel in 0 to TEMPLATE_SIZE - 1 loop
        -- Frame pixels stored in file
        data := to_integer(out_data.window(row)(pixel));
        write(line, data, right, 0, decimal); -- convert to decimal numbers
        writeline((videooutfile), line); -- write next text line to file
      end loop;
    end loop;
    
    file_close(videooutfile);  
    report "Done writing output file";
    
    wait until out_valid = '0';
    wait for 1 us;
    end_sim <= '1';
    wait;
  end process;
  
end architecture;