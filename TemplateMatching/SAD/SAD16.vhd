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
  clk            :IN    STD_LOGIC;
  reset              :IN    STD_LOGIC;
  
  -- inputs from softcore 
  template             :IN    Window_t;
  
  -- inputs from window buffer
  window_info       :IN     WindowInfo16_t; 
  --window_in            :IN    Window_t;
  --x_in                 :IN    X_t;
  --y_in                 :IN    Y_t;
  valid_in             :IN    STD_LOGIC;
  
  -- Outputs
  score_out             : OUT    Score_t := (others => 'Z');  
  valid_out             : OUT    STD_LOGIC;
  x_out                 : OUT    X_t;
  y_out                 : OUT    Y_t 
  
);
end entity;

ARCHITECTURE structural OF SAD IS


-- from complement_sum to adder_tree
signal comp_sum_out : WindowInfoC_t := WindowInfoC_t_init; 
signal comp_sum_valid_out : std_logic := '0'; 


signal template1 : Window16_t := Window_t_init;
signal template2 : Window16_t := Window_t_init;
 
signal temp_score : Score_t := (others => '0');

  -- declare signals, components here...
  type sad_state_types is (first_half, second_half); -- define states 	
  signal current_state : sad_state_types;  -- create instance of state_types 
 
BEGIN

 -----------------------------
  -- component instantiation 
  -----------------------------
  complement_sum_INST: entity work.complement_sum
   port map (
	  -- Inputs
      clk_50MHz            => clk,
      reset              => reset,
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
		clk_50MHz    =>    clk,
		reset        =>    reset,
		comp_sum     =>    comp_sum_out,
		valid_in     =>    comp_sum_valid_out,
		valid_out    =>    valid_out, 
		SAD_out      =>    temp_score,
		x_out        =>    x_out,
		y_out        =>    y_out); 
 
	
	
  SAD_process : process (clk_50MHz, reset_n) 
    variable score_var : unsigned(17 downto 0) := (others => '0');
	begin 
      if rising_edge(clk_50MHz) then
		if (reset_n = '1') then   -- reset to first_half state
			current_state <= first_half;
			score_var := (others => '0'); 
			temp_score <= (others => '0'); -- clear
			valid_out <= '0';
		else 
		  case current_state is 			
				when first_half =>
				  if valid_in = '1' then
						valid_out <= '0'; -- in the middle of calculating
						window_in <= window_info;
						current_state <= second_half; 
					end if; 			
				when second_half =>
									  if valid_in = '1' then
						valid_out <= '0'; -- in the middle of calculating
						window_in <= window_info;
						current_state <= second_half; 
					end if; 			
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










