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

BEGIN


  comp_sum: entity work.complement_sum
   port map (
	  -- Inputs
      clk_50MHz            => clk_50MHz,
      reset                => reset_tb,
      -- inputs from softcore 
      template             => template_tb,
      -- inputs from window buffer
	  window_in          => window_in_tb,   
     -- window_in            => window_in,
      --x_in                 => x_in,
      --y_in                 => y_in,
      valid_in             => valid_in_tb,
      -- Outputs  
      valid_out             => valid_out_tb,
	  window_out            => window_out_tb); 
 
 
 
 
    port map (
	  -- Inputs
      clk_50MHz            => clk_tb,
      reset                => reset_tb,
      -- inputs from softcore 
      template             => template_tb,
      -- inputs from window buffer
	  window_in          => window_in_tb,   
     -- window_in            => window_in,
      --x_in                 => x_in,
      --y_in                 => y_in,
      valid_in             => valid_in_tb,
      -- Outputs  
      valid_out             => valid_out_tb,
	  window_out            => window_out_tb); 


	
END ARCHITECTURE;









