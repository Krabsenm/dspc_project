library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
--library unisim;
--use unisim.vcomponents.all;


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
  clk_50MHz            :IN    STD_LOGIC;
  reset_n              :IN    STD_LOGIC;
  
  -- inputs from softcore 
  template             :IN    Window_t;
  
  -- inputs from window buffer
  window_info       :IN     WindowInfo_t; 
  --window_in            :IN    Window_t;
  --x_in                 :IN    X_t;
  --y_in                 :IN    Y_t;
  valid_in             :IN    STD_LOGIC;
  
  -- Outputs
  score_out             : OUT    Score_t;  
  valid_out             : OUT    STD_LOGIC;
  x_out                 : OUT    X_t;
  y_out                 : OUT    Y_t 
  
);
end entity;

ARCHITECTURE structural OF SAD IS


-- from complement_sum to adder_tree
signal comp_sum_out : WindowInfoC_t := WindowInfoC_t_init; 
signal comp_sum_valid_out : std_logic := '0'; 


BEGIN

 -----------------------------
  -- component instantiation 
  -----------------------------
  complement_sum_INST: entity work.complement_sum
   port map (
	  -- Inputs
      clk_50MHz            => clk_50MHz,
      reset              => reset_n,
      -- inputs from softcore 
      template             => template,
      -- inputs from window buffer
	  window_in          => window_info,   
     -- window_in            => window_in,
      --x_in                 => x_in,
      --y_in                 => y_in,
      valid_in             => valid_in,
      -- Outputs  
      valid_out_comp        => comp_sum_valid_out,
	  window_out            => comp_sum_out); 
 
 
  -----------------------------
  -- component instantiation 
  -----------------------------
  adder_tree_INST: entity work.adder_tree
   port map (
		clk_50MHz    =>    clk_50MHz,
		reset        =>    reset_n,
		comp_sum     =>    comp_sum_out,
		valid_in     =>    comp_sum_valid_out,
		valid_out    =>    valid_out, 
		SAD_out      =>    score_out,
		x_out        =>    x_out,
		y_out        =>    y_out); 
 
	
END ARCHITECTURE;









