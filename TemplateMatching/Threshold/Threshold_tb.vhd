library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
--library unisim;
--use unisim.vcomponents.all;
--------------------------------------------------------------------------------
entity  Threshold_tb is
end entity ;
--------------------------------------------------------------------------------

architecture test_bench of SAD_tb is
  -----------------------------
  -- Stimulus Signals 
  -----------------------------
signal   clk_50MHz     : std_logic  := '1';
signal   reset_n       : std_logic  := '0';

signal window_info     : WindowInfo_t := WindowInfo_t_init;
--signal  window_in      : Window_t;
signal  template       : Window_t;
--signal  x_in           : X_t;
--signal  y_in           : Y_t;
signal  valid_in       : std_logic := '0';

  -----------------------------
  -- Observed Signals 
  -----------------------------
signal  score_out     : Score_t := (others => '1');
signal  x_out         : X_t;
signal  y_out         : Y_t;
signal  valid_out     : std_logic := '0'; 
  

  -----------------------------
  -- test bench Signals 
  -----------------------------   
  -- clock
constant clockperiod  : time := 20 ns;  -- clk period time


  -----------------------------
  -- Intent Model
  -----------------------------
type intent_model is record
    pixel_in         : Pixel_t; 
    pixel_tem        : Pixel_t;
	score_out_exp    : integer range 0 to 261120; 
	x_in             : X_t;
	y_in             : Y_t;
end record;

type intent_model_array is array (natural range <>) of intent_model; 

constant intent_models : intent_model_array := (
-- pixel_in , pixel_tem , expected score, x coordinate, y coordinate
("00000000", "11111111", 261120, 0, 0),
("11111111", "11111111", 0, 32, 57),
("10000000", "00000000", 131072, 45, 10),
("00000000", "00000001", 1024, 1, 7),
("10000001", "10000001", 0, 1, 1),
("11111111", "00000000", 261120	, 60, 78));

  
begin  -- architecture Bhv

  -----------------------------
  -- clock generation 
  ----------------------------- 
  clk_50MHz <= not clk_50MHz after clockperiod/2 when end_sim = '0' else unaffected; 
  -----------------------------
  -- reset generation 
  -----------------------------
  reset_n         <= '0', '1' after 20 ns;
 
  -----------------------------
  -- component instantiation 
  -----------------------------
  uut: entity work.Threshold
   port map (
	  -- Inputs
      clk_50MHz            => clk_50MHz,
      reset_n                => reset_n,
      -- inputs from softcore 
      template             => template,
      -- inputs from window buffer
	  window_info          => window_info,   
     -- window_in            => window_in,
      --x_in                 => x_in,
      --y_in                 => y_in,
      valid_in             => valid_in,
      -- Outputs
      score_out             => score_out,  
      valid_out             => valid_out);
   
  -----------------------------
  -- stimuli process 
  -----------------------------
  
  
  StimuliProcess : process
  
  begin
 
	for i in intent_models'range loop 
 
	xxxx := intent_models(i).xxxx;
	-- wait for signals to settle
	wait for 20 ns; 
	end loop;
	
	wait; 
  end process StimuliProcess;
  
  
 MonitorProcess : process 
	begin
        wait for clockperiod; -- one clock periode idle before start 
	    wait until clk_50MHz = '1'; -- Align clock
	if valid_out = '1' then
		assert ()
		report "good " --& integer'image(output_sc)
		severity note;
	end if;
 end process MonitorProcess;
  
  
end architecture test_bench;