library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

-- project pckgs
use work.TemplateMatchingTypePckg.all; 

entity SAD is 
generic(
		P_SIZE  : integer := PIXEL_SIZE;
        T_SIZE  : integer := TEMPLATE_SIZE;
        S_MAX   : integer := SCORE_MAX
);

PORT (
   -- Inputs
  clk                   :IN      STD_LOGIC;
  reset                 :IN      STD_LOGIC; 
  template              :IN      Window_t;  
  -- inputs from window buffer
  window_info           :IN      WindowInfo_t; 
  valid_in              :IN      STD_LOGIC;
  -- Outputs
  score_out             : OUT    Score_t := (others => 'Z');  
  valid_out             : OUT    STD_LOGIC;
  x_out                 : OUT    X_t;
  y_out                 : OUT    Y_t 
  
);
end entity;

ARCHITECTURE arch OF SAD IS
-- from complement_sum to adder_tree
signal comp_sum_out : WindowInfoC_t := WindowInfoC_t_init; 
signal comp_sum_valid_out : std_logic := '0'; 
BEGIN
 -----------------------------
  -- component instantiation 
  -----------------------------
  complement_sum_INST: entity work.complement_sum
   port map (
      clk             => clk,
      reset           => reset,
      template        => template,
	  window_in       => window_info,   
      valid_in        => valid_in,
      valid_out_comp  => comp_sum_valid_out,
	  window_out      => comp_sum_out); 
  -----------------------------
  -- component instantiation 
  -----------------------------
  adder_tree_INST: entity work.adder_tree
   port map (
		clk          =>    clk,
		reset        =>    reset,
		comp_sum     =>    comp_sum_out,
		valid_in     =>    comp_sum_valid_out,
		valid_out    =>    valid_out, 
		SAD_out      =>    score_out,
		x_out        =>    x_out,
		y_out        =>    y_out); 
END ARCHITECTURE;









