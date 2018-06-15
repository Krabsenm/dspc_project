library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
--library unisim;
--use unisim.vcomponents.all;

use work.TemplateMatchingTypePckg.all;

--------------------------------------------------------------------------------
entity  SAD_tb is
end entity ;
--------------------------------------------------------------------------------


architecture test_bench of SAD_tb is
  -----------------------------
  -- Stimulus Signals 
  -----------------------------
signal   clk_50MHz     : std_logic  := '1';
signal   reset_n       : std_logic  := '0';

signal  window_in      : Window_t;
signal  template       : Window_t;
signal  x_in           : X_t;
signal  y_in           : Y_t;
signal  valid_in       : std_logic := '0';

  -----------------------------
  -- Observed Signals 
  -----------------------------
signal  score_out     : Score_t := 262144;
signal  x_out         : X_t;
signal  y_out         : Y_t;
signal  valid_out     : std_logic := '0'; 
  

  -----------------------------
  -- test bench Signals 
  -----------------------------  
signal end_sim : std_logic := '0';
  
  -- clock
constant clockperiod  : time := 20 ns;  -- clk period time

  
begin  -- architecture Bhv

  -----------------------------
  -- clock generation 
  ----------------------------- 
  clk_50MHz <= not clk_50MHz after clockperiod/2 when end_sim = '0' else unaffected; 

  -----------------------------
  -- reset generation 
  -----------------------------
  reset_n         <= '1', '0' after 125 ns;
 
  -----------------------------
  -- component instantiation 
  -----------------------------
  uut: entity work.SAD
   port map (
	  -- Inputs
      clk_50MHz            => clk_50MHz,
      reset                => reset_n,
      -- inputs from softcore 
      template             => template,
      -- inputs from window buffer
      windiw_in            => window_in,
      x_in                 => x_in,
      y_in                 => y_in,
      valid_in             => valid_in,
      -- Outputs
      score_out             => score_out,  
      valid_out             => valid_out,
      x_out                 => x_out,
      y_out                 => y_out); 

   
  -----------------------------
  -- stimuli process 
  -----------------------------
   
  StimuliProcess : process
  
	variable pixel : Pixel_t := "11111111";
	variable rows : WindowRow_t := (others => pixel);
 
 
  begin

  window_in      <= (others => rows);
  template       <= (others => rows);
  x_in           <= 1;
  y_in           <= 1;
  
    wait until reset_n = '0'; -- reset
    wait for clockperiod; -- one clock periode idle before start 
	wait until clk_50MHz = '1'; -- Align clock
   
	valid_in <= '1';
  
	wait for clockperiod;
	wait for clockperiod;
	wait for clockperiod;
	wait for clockperiod;
		
	assert (score_out = 0)
	report "score_out = 0"
	severity error;
	
  end process StimuliProcess;
  
  
  
  
  
  
  
  
--  monitorProcess : process
--  begin

--  end process monitorProcess;
  
  
  
  
 
end architecture test_bench;














