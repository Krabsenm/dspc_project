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
signal   clk_50MHz     : STD_LOGIC;
signal   reset_n       : STD_LOGIC;

signal  window_in      : Window_t;
signal  template       : Window_t;
signal  x_in           : X_t;
signal  y_in           : Y_t;
signal  valid_in       : STD_LOGIC;

  -----------------------------
  -- Observed Signals 
  -----------------------------
signal  score_out     : Score_t;
signal  x_out         : X_t;
signal  y_out         : Y_t 
signal  valid_out            : STD_LOGIC; 
  

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
      clk_50MHz            => clk_50MHz;
      reset                => reset_n;
      -- inputs from softcore 
      template             =>    template;
      -- inputs from window buffer
      windiw_in            =>    window_in;
      x_in                 =>    x_in;
      y_in                 =>    y_in;
      valid_in             =>    valid_in;
      -- Outputs
      score_out             =>   score_out;  
      valid_out             =>   valid_out;
      x_out                 =>   x_out;
      y_out                 =>   y_out
  ); 

   
  -----------------------------
  -- stimuli process 
  -----------------------------
   
  StimuliProcess : process
    variable win_in : Window_t := '1';
    variable linecount : integer range 0 to image_height;

  
  
  
  begin

  
  window_in      <= ;
  template       : Window_t;
  x_in           : X_t;
  y_in           : Y_t;
  valid_in       : STD_LOGIC;
  
  
  
  
  
  
  end process StimuliProcess;
  
  
  
  
  
  
  
  
--  monitorProcess : process
--  begin

--  end process monitorProcess;
  
  
  
  
 
end architecture test_bench;














