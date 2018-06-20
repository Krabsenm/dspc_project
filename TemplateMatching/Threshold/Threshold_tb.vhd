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
signal  valid_out     : std_logic   := '0'; 
  

  -----------------------------
  -- test bench Signals 
  -----------------------------   
  -- clock
  signal end_sim        : std_logic := '0';
  constant clockperiod  : time      := 10 ns;  -- clk period time

  
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
    
    -- Simulate three output from the SAD module
    scores_in(0) <= ("000000000011000111", 1,1);
    valid_in     <= "1";

    wait until clk = '0';
    wait until clk = '1';
      
    -- Simulate three other output from SAD module
    scores_in(0) <= ("000000000010000111", 1,2);
    valid_in     <= "1";
    
    wait until clk = '0';
    wait until clk = '1';
    
    
    valid_in <= "0";
    
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
    
    -- The best output should be the second scores_in(1), which has coordinate (2,2)
    assert (x_out = 1 AND y_out = 2)
      report "Wrong coordinate! Expected: (1,2), but got: (" &  integer'image(x_out) & "," & integer'image(y_out) & ")"
      severity error;
  
    wait for clockperiod;
    
    end_sim <= '1';
    wait;
    
  end process MonitorProcess;
  
  
end architecture test_bench;