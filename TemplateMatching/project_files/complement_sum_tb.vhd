library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
--library unisim;
--use unisim.vcomponents.all;

use work.TemplateMatchingTypePckg.all;

--------------------------------------------------------------------------------
entity complement_sum_tb is
end entity ;
--------------------------------------------------------------------------------

architecture test_bench of complement_sum_tb is
  -----------------------------
  -- Stimulus Signals 
  -----------------------------
signal   clk_tb   : std_logic  := '1';
signal   reset_tb       : std_logic  := '0';

signal window_in_tb     : WindowInfo_t := WindowInfo_t_init;
signal  template_tb       : Window_t;
signal  valid_in_tb       : std_logic := '0';

  -----------------------------
  -- Observed Signals 
  -----------------------------
signal  valid_out_tb     : std_logic := '0'; 
signal window_out_tb     : WindowInfoC_t;  

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
	valid_in         : std_logic; 
	x_in             : X_t;
	y_in             : Y_t;
end record;

type intent_model_array is array (natural range <>) of intent_model; 

constant intent_models : intent_model_array := (
-- pixel_in , pixel_tem , expected score, x coordinate, y coordinate
("00011100", "11100011", '1', 1,1),
("11110000", "00001111", '1',2,2),
("01010101", "10101010", '1', 3, 3));

-- the incrementing count for the response monitor
signal count : integer range 0 to 10 := 0;

  
begin  -- architecture Bhv

  -----------------------------
  -- clock generation 
  ----------------------------- 
  clk_tb <= not clk_tb after clockperiod/2; 

  -----------------------------
  -- reset generation 
  -----------------------------
  reset_tb         <= '0', '1' after 20 ns;
 
  -----------------------------
  -- component instantiation 
  -----------------------------
  uut: entity work.complement_sum
   port map (
      clk                   => clk_tb,
      reset                 => reset_tb,
      template              => template_tb,
	  window_in             => window_in_tb,
      valid_in              => valid_in_tb,
      valid_out_comp        => valid_out_tb,
	  window_out            => window_out_tb); 
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
	
		window_in_tb.window      <= (others => input_rows);
		template_tb                <= (others => template_rows);
		window_in_tb.x           <= intent_models(i).x_in;
		window_in_tb.y           <= intent_models(i).y_in;
		wait for 20 ns; 
		valid_in_tb <= '1';
		wait until valid_out_tb = '1';
	end loop;
	
	wait; 
  end process StimuliProcess;
  
end architecture test_bench;
