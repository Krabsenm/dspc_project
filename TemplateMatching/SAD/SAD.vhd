library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
--library unisim;
--use unisim.vcomponents.all;


-- project pckgs
use work.TemplateMatchingTypePckg.all; 
use work.SAD.all; 


ENTITY SAD IS 

PORT (
   -- Inputs
  clk_50MHz            :IN    STD_LOGIC;
  reset                :IN    STD_LOGIC;
  
  -- inputs from softcore 
  template             :IN    Window_t;
  
  -- inputs from window buffer
  windiw_in            :IN    Window_t;
  x_in                 :IN    X_t;
  y_in                 :IN    Y_t;
  valid_in             :IN    STD_LOGIC;
  
  -- Outputs
  score_out             : OUT    Score_t;  
  valid_out             : OUT    STD_LOGIC;
  x_out                 : OUT    X_t;
  y_out                 : OUT    Y_t 
  
);
END ENTITY;




ARCHITECTURE structural OF SAD IS
  -- declare signals, components here...
BEGIN
  -- architecture body...
END ARCHITECTURE;
