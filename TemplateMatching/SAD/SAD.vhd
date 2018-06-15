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
end entity;

ARCHITECTURE structural OF SAD IS
  -- declare signals, components here...
  type sad_state_types is (idle, das, output); -- define states 	
  signal current_state : sad_state_types;  -- create instance of state_types
  signal temp_score : Score_t;
  
BEGIN
  -- architecture body...
	SAD_process : process (clk_50MHz, reset_n) 
		-- type diff_range : integer range -255 to 255;
		-- type diff_row is array (0 to 31) of diff_range;
		-- type diff_mat is array (0 to 31) of diff_row;
		-- variable d_mat : diff_mat;
		variable score_var : integer range 0 to S_MAX;
				
	begin 

		if (reset_n = '0') then   -- reset to idle state 
			current_state <= idle;
			temp_score <= 0; -- clear
		
		elsif rising_edge(clk_50MHz) then
		    case current_state is 			
				when idle =>
					if valid_in = '1' then
						
						current_state <= das; 
					end if; 
				
				when das =>
					for i in 1 to TEMPLATE_SIZE loop -- rows
						for j in 1 to TEMPLATE_SIZE loop -- columns
							score_var := (score_var + abs(signed(window_in(i)(j)) - signed(template(i)(j)))); 
						end;  -- end columns
					end;  -- end rows
					temp_score <= score_var; -- latch data	
					
				when output => 
						score_out <= temp_score; -- latch sampled data;  
						temp_score <= 0; -- clear
						current_state <= idle; -- return to idle  
				when others =>
					current_state <= idle; 
					temp_score <= 0; -- clear
			end case;
		end if;  	
	end process;

	
END ARCHITECTURE;









