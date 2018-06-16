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
  window_in            :IN    Window_t;
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
  signal temp_score : unsigned(17 downto 0) := (others => '0');
 -- signal debug_signal : unsigned(7 downto 0);
BEGIN

	-- conbinatorial output of (x,y) coordinates
	x_out <= x_in;
	y_out <= y_in;
  -- architecture body...
	SAD_process : process (clk_50MHz, reset_n) 
		variable score_var : unsigned(17 downto 0) := (others => '0');
	begin 

		if (reset_n = '0') then   -- reset to idle state 
			current_state <= idle;
			score_var := (others => '0'); 
			temp_score <= (others => '0'); -- clear
			valid_out <= '0';
		elsif rising_edge(clk_50MHz) then
		    case current_state is 			
				when idle =>
					if valid_in = '1' then
						valid_out <= '0';
						current_state <= das; 
					end if; 			
				when das =>
					for i in 0 to TEMPLATE_SIZE-1 loop -- rows
						for j in 0 to TEMPLATE_SIZE-1 loop -- column	
							score_var := (score_var + to_unsigned(abs(to_integer(window_in(i)(j)) - to_integer(template(i)(j))), 18));
						end loop;  -- end columns
					end loop;  -- end rows
					temp_score <= score_var; -- latch data	
					current_state <= output; -- switch state
				when output => 
						score_out <= temp_score; -- set output signal;
						valid_out <= '1'; -- output is valid
						temp_score <= (others => '0'); -- clear
						score_var := (others => '0'); -- clear
						current_state <= idle; -- return to idle
				when others =>
					current_state <= idle; -- something went wrong, return to idle  
					score_var := (others => '0'); -- clear all
					valid_out <= '0';					
					temp_score <= (others => '0'); -- clear
			end case;
		end if;  	
	end process;
	
END ARCHITECTURE;









