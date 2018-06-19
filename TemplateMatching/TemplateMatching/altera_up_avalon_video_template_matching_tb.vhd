library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use std.textio.all;
use work.TemplateMatchingTypePckg.all;
use work.io_utils.all;


ENTITY altera_up_avalon_video_template_matching_tb IS 
  GENERIC (
    image_width :INTEGER    := 320;   -- Image width in pixels
    image_height:INTEGER    := 240;   -- Image height in pixels
    image_name: string      := "nature_doge.txt"; -- Contains image as text hex input format
    image_outName: string   := "ImageOut.txt";
    template_image: string  := "nature_doge_temp.txt"
  );
END ENTITY;

architecture test_bench of altera_up_avalon_video_template_matching_tb is
  -- inputs
  signal clk                :  STD_LOGIC := '0';
  signal reset              :  STD_LOGIC := '0';

  signal in_data            :  STD_LOGIC_VECTOR( 7 DOWNTO  0);  
  signal in_startofpacket   :  STD_LOGIC;
  signal in_endofpacket     :  STD_LOGIC;
  signal in_valid           :  STD_LOGIC;

  signal out_ready          :  STD_LOGIC;

  signal bypass             :  STD_LOGIC;
  signal in_template        : Window_t;
  -- outputs
  signal in_ready           :  STD_LOGIC;

  signal out_data           :  STD_LOGIC_VECTOR( 7 DOWNTO  0);  
  signal out_startofpacket  :  STD_LOGIC;
  signal out_endofpacket    :  STD_LOGIC;
  signal out_valid          :  STD_LOGIC;

   -- clock
  signal end_sim : std_logic := '0';
  constant clockperiod  : time := 10 ns;  -- clk period time
 
  -- template
  signal template           : Window_t;
begin

  uut: entity work.altera_up_avalon_video_template_matching
    port map (
       clk                =>      clk,              
       reset              =>      reset,            
       in_data            =>      in_data,          
       in_startofpacket   =>      in_startofpacket, 
       in_endofpacket     =>      in_endofpacket,   
       in_valid           =>      in_valid,         
       out_ready          =>      out_ready,        
       bypass             =>      bypass,         
       in_template        =>      in_template,
       in_ready           =>      in_ready,         
       out_data           =>      out_data,         
       out_startofpacket  =>      out_startofpacket,
       out_endofpacket    =>      out_endofpacket,  
       out_valid          =>      out_valid);        

  -- clock generation
  clk <= not clk after clockperiod/2 when end_sim = '0' else unaffected; 

  -- reset generation
  reset <= '1', '0' after 125 ns;
     
    -----------------------------------------------------------------------------
  -- Stimulus Process
  -- It creates a stream of video data to the ST bus
  -----------------------------------------------------------------------------
  genVideoSTData : process
    variable pixelcount : integer range 0 to image_width;
    variable linecount  : integer range 0 to image_height;
     -- files
    variable line: LINE;
    variable data: integer;
    variable val: signed(31 downto 0);
    file videoinfile: TEXT;-- open read_mode is image_name;
    file templateinfile: TEXT;-- open read_mode is image_name;
 begin
    out_ready <= '1';
    bypass <= '0';
    in_valid <= '0';    
    in_endofpacket <= '0';
    in_startofpacket <= '0';    

    -- Open simulation files
    file_open(templateinfile, template_image);
    file_open(videoinfile, image_name);
    
    wait until reset = '0'; -- reset
    wait for clockperiod; -- one clock periode idle before start 
    wait until clk = '1'; -- Align clock
    
    report "Reading template file";
    for linecount in 0 to TEMPLATE_SIZE-1 loop
      for pixelcount in 0 to TEMPLATE_SIZE-1 loop
        if not endfile(templateinfile) then
          readline(templateinfile, line); -- read next text line from file
          read(line, data, 10); -- convert decimal (10) numbers to integer value
          template(linecount)(pixelcount) <= (TO_UNSIGNED(data, 8)); -- convert to 8 bit 
        end if;
      end loop; -- rows
    end loop; -- columns
    
    wait until clk = '1';
    in_template <= template;
    report "Done reading template file";
    file_close(templateinfile);
    
    wait until clk = '0';
    wait until clk = '1';
    
    
    report "Reading video file";
    -- Read video 
    while not endfile(videoinfile) loop
  
      report "Starting to read file"; 

      for images in 0 to 1 loop
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
            else
              in_endofpacket <= '1';
              wait until clk = '1';
            end if;
            
          end loop; -- rows
        end loop; -- columns
        
        in_endofpacket <= '0'; -- end of packet (frame)
        report "Done reading an image";
      end loop;
      
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
  monitor : process
    variable line: LINE;
    variable data: integer;
    file videooutfile: TEXT open write_mode is image_outName;
  begin
    -- Create simulation files    
    --file_open(videooutfile, image_outName);
    
    wait until reset = '0';
    wait until out_startofpacket = '1';
    wait until out_startofpacket = '0';
    wait until out_startofpacket = '1';
    
    while (out_valid = '1' ) loop
      wait until clk = '0';
      data := TO_INTEGER(unsigned(out_data));
      write(line, data, right, 0, decimal); -- convert to decimal numbers
      
      -- Frame pixels stored in file
      writeline(videooutfile, line); -- write next text line to file
      --report "Writing to file: " & integer'image(data);
      wait until clk = '1';
      
      wait for 1 ns;
    end loop;
    
    file_close(videooutfile);  
    report "Done writing output file";
    
    end_sim <= '1';
    wait;
  end process;
  
  
end architecture;
