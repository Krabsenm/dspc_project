library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
--library unisim;
--use unisim.vcomponents.all;

use work.TemplateMatchingTypePckg.all;

--------------------------------------------------------------------------------
entity  SAD16_tb is
end entity ;
--------------------------------------------------------------------------------


architecture test_bench of SAD16_tb is
  -----------------------------
  -- Stimulus Signals 
  -----------------------------
signal   clk     : std_logic  := '1';
signal   reset       : std_logic  := '0';

signal window_info     : WindowInfo16_t := WindowInfo16_t_init;
--signal  window_in      : Window_t;
signal  template       : Window_t;
--signal  x_in           : X_t;
--signal  y_in           : Y_t;
signal  valid_in       : std_logic := '0';

  -----------------------------
  -- Observed Signals 
  -----------------------------
signal  score_out     : Score_t := (others => '0');
signal  x_out         : X_t;
signal  y_out         : Y_t;
signal  valid_out_tb     : std_logic := '0'; 
  

  -----------------------------
  -- test bench Signals 
  -----------------------------  
signal end_sim : std_logic := '0';
  
  -- clock
constant clockperiod  : time := 20 ns;  -- clk period time


  -----------------------------
  -- Intent Model
  -----------------------------
type intent_model is record
    pixel_in         : Pixel_t; 
    pixel_tem        : Pixel_t;
	expected    : integer range 0 to 261120; 
	x_in             : X_t;
	y_in             : Y_t;
end record;

type intent_model_array is array (natural range <>) of intent_model; 

constant intent_models : intent_model_array := (
-- pixel_in , pixel_tem , expected score, x coordinate, y coordinate
("00000000", "11111111", 261120, 0, 0),
("11111111", "11111111", 0, 32, 57),
("00000000", "00000010", 2048, 1, 7),
("10000001", "10000001", 0, 1, 1),
("11111111", "00111110", 197632, 60, 78));

-- the incrementing count for the response monitor
signal count : integer range 0 to 10 := 0;
signal monitor_count  : integer range 0 to 10 := 0; 
  
begin  -- architecture Bhv

  -----------------------------
  -- clock generation 
  ----------------------------- 
  clk <= not clk after clockperiod/2 when end_sim = '0' else unaffected; 

  -----------------------------
  -- reset generation 
  -----------------------------
  reset        <= '1', '0' after 120 ns;
 
  -----------------------------
  -- component instantiation 
  -----------------------------
  uut: entity work.SAD16
   port map (
	  -- Inputs
      clk              => clk,
      reset                => reset,
      -- inputs from softcore 
      template               => template,
      -- inputs from window buffer
	  window_info            => window_info,   
     -- window_in            => window_in,
      --x_in                 => x_in,
      --y_in                 => y_in,
      valid_in               => valid_in,
      -- Outputs
      score_out              => score_out,  
      valid_out              => valid_out_tb,
	  x_out                  => x_out,
      y_out                  => y_out);
   
  -----------------------------
  -- stimuli process 
  -----------------------------
  
  
  StimuliProcess : process
  
	variable input_pixel : Pixel_t  := (others => '0');
	variable template_pixel : Pixel_t := (others => '0');
	variable input_rows : WindowRow_t := (others => input_pixel);
	variable template_rows : WindowRow_t := (others => template_pixel);
	 
  begin
 
	for i in intent_models'range loop 
 
	input_pixel := intent_models(i).pixel_in;
	template_pixel := intent_models(i).pixel_tem;
 
	input_rows := (others => input_pixel);
	template_rows := (others => template_pixel);
	
	window_info.window   <= (others => input_rows);
	template                <= (others => template_rows);
	window_info.x           <= intent_models(i).x_in;
	window_info.y           <= intent_models(i).y_in;
  
	-- wait for signals to settle
	
    valid_in <= '1';
	wait until clk = '0'; 
	wait for clockperiod;
	wait until clk = '1';
	
	input_pixel := intent_models(i).pixel_in;
	template_pixel := intent_models(i).pixel_tem;
 
	input_rows := (others => input_pixel);
	template_rows := (others => template_pixel);
	
	window_info.window      <= (others => input_rows);
	template                <= (others => template_rows);
	window_info.x           <= intent_models(i).x_in;
	window_info.y           <= intent_models(i).y_in;
  
	-- wait for signals to settle
	
     valid_in <= '1';
	wait until clk = '0'; 
	wait for clockperiod;
	wait until clk = '1';
	
	end loop;
	
	valid_in <= '0';
	
	wait; 
  end process StimuliProcess;
  
  

end architecture test_bench;
