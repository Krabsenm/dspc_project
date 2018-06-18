library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
--library unisim;
--use unisim.vcomponents.all;
use work.TemplateMatchingTypePckg.all; 

--------------------------------------------------------------------------------
entity  threshold_tb is
end entity ;
--------------------------------------------------------------------------------

architecture test_bench of threshold_tb is
  -----------------------------
  -- Stimulus Signals 
  -----------------------------
signal   clk           : std_logic  := '1';
signal   reset         : std_logic  := '1';

signal   valid_in      : std_logic_vector(NUM_SAD-1 downto 0);
signal   scores_in     : threshold_data_inputs_t;

  -----------------------------
  -- Observed Signals 
  -----------------------------
signal  x_out         : X_t;
signal  y_out         : Y_t;
signal  valid_out     : std_logic := '0'; 
  

  -----------------------------
  -- test bench Signals 
  -----------------------------   
  -- clock
  signal end_sim : std_logic := '0';
  constant clockperiod  : time := 10 ns;  -- clk period time

  
begin  -- architecture Bhv

  -----------------------------
  -- component instantiation 
  -----------------------------
  uut: entity work.Threshold
    generic map(
      X_MAX     => 3,
      Y_MAX     => 2)
    port map (
	  -- Inputs
      clk                   => clk,
      reset                 => reset,
      
      valid_in              => valid_in,
      scores_in             => scores_in,

      -- Outputs
      x_out                 => x_out,
      y_out                 => y_out,
      valid_out             => valid_out); 
  
  -- clock generation
  clk <= not clk after clockperiod/2 when end_sim = '0' else unaffected; 

  -- reset generation
  reset <= '1', '0' after 125 ns; 
  
  -----------------------------
  -- stimuli process 
  -----------------------------
  
  
  StimuliProcess : process
  begin
    wait until reset = '0'; -- reset
    wait for clockperiod; -- one clock periode idle before start 
    wait until clk = '1'; -- Align clock
    
    scores_in(0) <= ("000000000010000111", 1,1);
    scores_in(1) <= ("000000000001000010", 2,1);
    scores_in(2) <= ("000000100000000001", 3,1);
    valid_in     <= "111";
    
    wait until clk = '0';
    wait until clk = '1';
    
    scores_in(0) <= ("000000000010000111", 1,2);
    scores_in(1) <= ("000000000000000010", 2,2);
    scores_in(2) <= ("000000000000010001", 3,2);
    valid_in     <= "111";
    
    wait until clk = '0';
    wait until clk = '1';
    
    
    valid_in <= "000";
    
    wait;
  end process StimuliProcess;
  
  -----------------------------
  -- monitor process 
  -----------------------------
  
 MonitorProcess : process 
  begin
  
    wait until reset = '0'; -- reset
    wait for clockperiod; -- one clock periode idle before start 
    wait until clk = '1'; -- Align clock
    
    wait until valid_out = '1';
    
    assert (x_out = 2 AND y_out = 0)
      report "Not good"
      severity error;
  
    wait for clockperiod;
    
    end_sim <= '1';
    wait;
    
  end process MonitorProcess;
  
  
end architecture test_bench;