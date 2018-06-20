library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
--library unisim;
--use unisim.vcomponents.all;

use work.TemplateMatchingTypePckg.all;

--------------------------------------------------------------------------------
entity adder_tree_tb is
end entity ;
--------------------------------------------------------------------------------


architecture test_bench of adder_tree_tb is
  -----------------------------
  -- Stimulus Signals 
  -----------------------------
signal   clk_tb   : std_logic  := '1';
signal   reset_tb       : std_logic  := '0';

signal comp_sum_tb        : WindowInfoC_t := WindowInfoC_t_init;
signal  valid_in_tb       : std_logic := '0';

  -----------------------------
  -- Observed Signals 
  -----------------------------
signal  valid_out_tb     : std_logic := '0'; 
signal SAD_tb     : unsigned(17 downto 0);  
signal x_out  : X_t;
signal y_out  : Y_t; 
  ----------------- 
  -----------------------------
  -- test bench Signals 
  -----------------------------  
  -- clock
constant clockperiod  : time := 20 ns;  -- clk period time
signal monitor_count  : integer range 0 to 10 := 0; 
   -----------------------------
  -- Intent Model
  -----------------------------
type intent_model is record
    pixel_in         : PixelC_t;
	expected         : integer range 0 to 262120;
	valid_in         : std_logic; 
	x_in             : X_t;
	y_in             : Y_t;
end record;

type intent_model_array is array (natural range <>) of intent_model; 

constant intent_models : intent_model_array := (
-- pixel_in , pixel_tem , expected score, x coordinate, y coordinate
("111111110",262120, '1', 1, 1),
("011111111", 0, '1', 2, 2),
("111100000",230400, '1', 3, 3));

  
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
  uut: entity work.adder_tree
   port map (
		clk          =>    clk_tb,
		reset        =>    reset_tb,
		comp_sum     =>    comp_sum_tb,
		valid_in     =>    valid_in_tb,
		valid_out    =>    valid_out_tb, 
		SAD_out      =>    SAD_tb,
		X_out        => x_out,
		Y_out        => y_out); 
  -----------------------------
  -- stimuli process 
  -----------------------------
  StimuliProcess : process
  
	variable input_pixel : PixelC_t  := (others => '0');
	variable input_rows : WindowRowC_t := (others => input_pixel);

  begin
 
	for i in intent_models'range loop 
 
		input_pixel := intent_models(i).pixel_in;
 
		input_rows := (others => input_pixel);
	
		comp_sum_tb.window      <= (others => input_rows);
		comp_sum_tb.x           <= intent_models(i).x_in;
		comp_sum_tb.y           <= intent_models(i).y_in;
		valid_in_tb <= '1';
		wait for 20 ns; 
	end loop;
	
	valid_in_tb <= '0';
	wait; 
  end process StimuliProcess;
  
  MonitorProcess : process
  
  begin
 
	if valid_out_tb = '1' AND monitor_count < 3 then
		assert (to_integer(SAD_tb) = intent_models(monitor_count).expected)
		report "the numbers are equal" 
		severity note; 
		monitor_count <= monitor_count +1; 
	end if; 
	
	wait for clockperiod; 
 
  end process MonitorProcess;

  
end architecture test_bench;

