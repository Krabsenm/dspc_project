library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
--library unisim;
--use unisim.vcomponents.all;
--------------------------------------------------------------------------------
-- project pckgs
use work.TemplateMatchingTypePckg.all; 

entity  Threshold is
	generic(
	    S_MAX   : integer := SCORE_MAX;
        IMG_W   : integer := IMAGE_WIDTH;
        IMG_H   : integer := IMAGE_HEIGHT; 
        TEM_S   : integer := TEMPLATE_SIZE;
		L_X     : integer := LAST_X;
		L_Y     : integer := LAST_Y;
		-- threshold level 
		T_LEVEL : integer := 100;

		-- number of inputs(SAD)
		N_SAD : integer := NUM_SAD; 
	);
	
	-- Inputs
    clk_50MHz            :in    STD_LOGIC;
    reset_n              :in    STD_LOGIC;
	
	-- number of inputs set to number of SAD modules
	score_in  : in array(0 to N_SAD-1) of Score_t; 
	valid_in  : in array(0 to N_SAD-1) of std_logic; 
	x_in      : in array(0 to N_SAD-1) of X_t; 
	y_in      : in array(0 to N_SAD-1) of Y_t; 
	
	-- output
	valid_out : out std_logic; 
	x_out     : out X_t; 
	y_out     : out Y_t;
end entity;


architecture archi of Threshold is

-- state machine here
type sad_state_types is (idle, Threshold, output); -- define states 	
  signal current_state : sad_state_types;  -- create instance of state_types
  
-- declare signals, components here
	signal current_score_max : Score_t := (others => '0'); 
	signal current_x_max : X_t := 0; 
	signal current_y_max : Y_t := 0; 
	  
begin
  -- architecture body...
  
  -- architecture body...
	Threshold_process : process (clk_50MHz, reset_n) 
		variable score_var : unsigned(17 downto 0) := (others => '0');
		variable valid_in_count : integer range 0 to valid_in'high := 0; 
	begin 

		if (reset_n = '0') then   -- reset to idle state 
			current_state <= idle;
			current_score_max := (others => '0'); 
			current_x_max <= (others => '0'); -- clear
			current_y_max <= (others => '0'); -- clear
			
		elsif rising_edge(clk_50MHz) then
		    case current_state is 			
				when idle =>
				
				    for i in 0 to valid_in'range loop
						valid_in_count := valid_in_count + to_integer(valid_in(i));
				    end loop; 
				
					if valid_in_count = valid_in'high then
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
  
end architecture;











