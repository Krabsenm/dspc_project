library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
--library unisim;
--use unisim.vcomponents.all;


entity TemplateLoader_tb is
end entity;

architecture arch of TemplateLoader_tb is
  -- declare signals, components here...
  
    -- Avalon Interface
  signal  csi_clockreset_clk     :  std_logic := '0';                     -- Avalon Clk
  signal  csi_clockreset_reset_n :  std_logic  := '1';                     -- Avalon Reset
  signal  avs_s1_write           :  std_logic;                     -- Avalon wr
  signal  avs_s1_read            :  std_logic;                     -- Avalon rd
  signal  avs_s1_chipselect      :  std_logic;                     -- Avalon cs
  signal  avs_s1_byteenable      :  std_logic_vector(1 downto 0);  -- Avalon byteenable
  signal  avs_s1_address         :  std_logic_vector(7 downto 0);  -- Avalon address
  signal  avs_s1_writedata       :  std_logic_vector(15 downto 0); -- Avalon wr data
  signal  avs_s1_readdata        :  std_logic_vector(15 downto 0); -- Avalon rd data

    -- Template for SAD module    
  signal	temp_pixel_out               : std_logic_vector(15 downto 0); 
  signal	valid_out                    : std_logic;
  
  -----------------------------
  -- test bench Signals 
  -----------------------------  
  signal end_sim : std_logic := '0';
  
  -- clock
  constant clockperiod  : time := 20 ns;  -- clk period timex	
  
  begin
  -- architecture body...
   uut: entity work.TemplateLoader  
    port map(
			csi_clockreset_clk        =>     csi_clockreset_clk,    
			csi_clockreset_reset_n    =>     csi_clockreset_reset_n,
			avs_s1_write              =>     avs_s1_write,          
			avs_s1_read               =>     avs_s1_read,           
			avs_s1_chipselect         =>     avs_s1_chipselect,     
			avs_s1_byteenable         =>     avs_s1_byteenable,     
			avs_s1_address            =>     avs_s1_address,        
			avs_s1_writedata          =>     avs_s1_writedata,      
			avs_s1_readdata           =>     avs_s1_readdata,       
			
			
			temp_pixel_out         =>        temp_pixel_out,   
			valid_out              =>        valid_out        
			);

	
  -----------------------------
  -- clock generation 
  ----------------------------- 
  csi_clockreset_clk <= not csi_clockreset_clk after clockperiod/2 when end_sim = '0' else unaffected; 

  -----------------------------
  -- reset generation 
  -----------------------------
  csi_clockreset_reset_n     <= '0', '1' after 125 ns;
  
  
    -----------------------------------------------------------------------------
  -- Stimulus Process
  -- It creates a stream of video data to the ST bus
  -----------------------------------------------------------------------------
  StimuliProcess : process
  
 begin

   avs_s1_write        <= '0'; 
   avs_s1_read         <= '0';
   avs_s1_chipselect   <= '0';
   avs_s1_byteenable   <= B"00";
   avs_s1_address      <= B"00000000";
  

   wait until csi_clockreset_clk = '0'; -- Align clock
   wait for clockperiod; -- one clock periode idle before start 
   wait until csi_clockreset_clk = '1'; -- Align clock
    
	
   avs_s1_writedata   <= B"1111111100000000";	
   avs_s1_write        <= '1'; 
   avs_s1_chipselect   <= '1';
   avs_s1_byteenable   <= B"11";

   wait until csi_clockreset_clk = '0'; -- Align clock
   wait for clockperiod; -- one clock periode idle before start 
   wait until csi_clockreset_clk = '1'; -- Align clock


   avs_s1_write        <= '0'; 
   avs_s1_read         <= '0';
   avs_s1_chipselect   <= '0';
   avs_s1_byteenable   <= B"00";
      
    
    wait;
  end process; 



 
  
  
end architecture;


