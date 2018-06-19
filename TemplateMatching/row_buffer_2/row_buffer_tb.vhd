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
    image_width :INTEGER    := IMAGE_WIDTH;   -- Image width in pixels
    image_height:INTEGER    := 2;  -- Image height in pixels
    image_name: string      := "ImageIn.txt"; -- Contains image as text hex input format
    image_outName: string   := "ImageOut.txt"
  );
end entity ;
--------------------------------------------------------------------------------

architecture Bhv of row_buffer_tb is
  -----------------------------
  -- Port Signals 
  -----------------------------
  signal   clk              : std_logic := '0';
  signal   reset            : std_logic := '1';
  signal   in_data          : std_logic_vector( 7 DOWNTO  0);
  signal   in_startofpacket : std_logic;
  signal   in_endofpacket   : std_logic;
  signal   in_valid         : std_logic;
  signal   out_valid        : std_logic;
  signal   out_data         : ImageRow_t;

    -- clock
  signal end_sim : std_logic := '0';
  constant clockperiod  : time := 10 ns;  -- clk period time
  
begin  -- architecture Bhv

  -----------------------------
  -- component instantiation 
  -----------------------------
  row_buffer_INST: entity work.row_buffer
   port map (
      clk              => clk,
      reset            => reset,
      in_data          => in_data,
      in_startofpacket => in_startofpacket,
      in_endofpacket   => in_endofpacket,
      in_valid         => in_valid,
      out_valid        => out_valid,
      out_data         => out_data);

	-- clock generation
  clk <= not clk after clockperiod/2 when end_sim = '0' else unaffected; 

  -- reset generation
  reset <= '1', '0' after 125 ns;
  
  --------------------------------------------------------
  -- Stimulus Process
  -- It creates a stream of video data to the ST bus
  ---------------------------------------------------------
  StimuliProcess : process
    variable pixelcount : integer range 0 to image_width;
    variable linecount  : integer range 0 to image_height;
     -- files
    variable line: LINE;
    variable data: integer;
    variable val: signed(31 downto 0);
    file videoinfile: TEXT;-- open read_mode is image_name;
 begin
    in_valid <= '0';    
    in_endofpacket <= '0';
    in_startofpacket <= '0';    

    -- Open simulation files
    file_open(videoinfile, image_name);

    wait until reset = '0'; -- reset
    wait for clockperiod; -- one clock periode idle before start 
    wait until clk = '1'; -- Align clock
    
    report "Reading file";
    -- Read video 
    while not endfile(videoinfile) loop
  
        report "Starting to read file";  
        in_valid <= '1'; -- start sending valid package   
        in_startofpacket <= '1'; -- start of package (frame) 
        
        for linecount in image_height-1 downto 0 loop
          for pixelcount in image_width-1 downto 0 loop
            if not endfile(videoinfile) then
              readline(videoinfile, line); -- read next text line from file
              read(line, data, 10); -- convert decimal (10) numbers to integer value
              in_data <= std_logic_vector(TO_UNSIGNED(data, 8)); -- convert to 8 bit 
              if linecount = 0 and pixelcount = 0 then -- last pixel in frame
                in_endofpacket <= '1';
              end if;
      
              wait until clk = '1'; --for clockperiod;
              in_startofpacket <= '0';
            end if;
            
          end loop; -- rows
        end loop; -- columns
        
    
        in_endofpacket <= '0'; -- end of packet (frame)
        in_valid <= '0';
        
        wait for 3*clockperiod;
          
    end loop; -- reading video file

    report "Done reading file"; 
    file_close(videoinfile);     
      
    wait;
  end process;
  
  -------------------------------------------------------
  -- Monitor Process
  -------------------------------------------------------
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
        assert to_integer(out_data(i)) = i-256
        report "out_data(" & integer'image(i) & ") got: " & integer'image(to_integer(out_data(i))) & " expected: " & integer'image(i-255)
        severity error;
      end if;
    end loop;
    
    
    wait until out_valid = '0';
    wait until out_valid = '1';
    
  
    end_sim <= '1';
  end process MonitorProcess;
  
end architecture Bhv;