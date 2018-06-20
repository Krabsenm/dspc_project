library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
--library unisim;
--use unisim.vcomponents.all;


-- project pckgs
use work.TemplateMatchingTypePckg.all; 

entity SAD16 is 
generic(
		P_SIZE  : integer := PIXEL_SIZE;
        T_SIZE  : integer := TEMPLATE_SIZE;
        S_MAX   : integer := SCORE_MAX
);

PORT (
   -- Inputs
  clk                  :IN    STD_LOGIC;
  reset                :IN    STD_LOGIC;
  -- inputs from softcore 
  template             :IN    Window_t;
  -- inputs from window buffer
  window_info          :IN     WindowInfo16_t;
  valid_in              :IN    STD_LOGIC;
  -- Outputs
  score_out             : OUT    Score_t;-- := (others => '0');  
  valid_out             : INOUT    STD_LOGIC;
  x_out                 : OUT    X_t;
  y_out                 : OUT    Y_t 
  
);
end entity;

ARCHITECTURE sarch OF SAD16 IS

-- from complement_sum to adder_tree
signal comp_sum_out : WindowInfoC16_t := WindowInfoC16_t_init; 
signal comp_sum_valid_out : std_logic := '0'; 
 
signal first_half_score : unsigned(17 downto 0);-- := (others => '0');
signal second_half_score : unsigned(17 downto 0);-- := (others => '0');

type sad_state_types is (first_half, second_half); -- define states 	
signal current_state : sad_state_types;  -- create instance of state_types 

signal current_template : Window16_t := Window16_t_init;
 
 
BEGIN

 -----------------------------
  -- component instantiation 
  -----------------------------
  complement_sum_INST: entity work.complement_sum16
   port map (
      clk                => clk,
      reset              => reset,
      template           => current_template,
	  window_in          => window_info,   
      valid_in           => valid_in,
      valid_out_comp     => comp_sum_valid_out,
	  window_out         => comp_sum_out); 
 
 
  -----------------------------
  -- component instantiation 
  -----------------------------
  adder_tree_INST: entity work.adder_tree16
   port map (
		clk          =>    clk,
		reset        =>    reset,
		comp_sum     =>    comp_sum_out,
		valid_in     =>    comp_sum_valid_out,
		valid_out    =>    valid_out, 
		SAD_out      =>    first_half_score,
		x_out        =>    x_out,
		y_out        =>    y_out); 

  SAD_process : process (clk) 
	variable temp_score_out : unsigned(18 downto 0);-- := (others => '0'); 
	begin 
      if rising_edge(clk) then
		if (reset = '1') then   -- reset to first_half state
		  current_state <= first_half;
		  current_template <= Window16_t(template(TEMPLATE_SIZE/2 to TEMPLATE_SIZE-1));
		  --valid_out <= '0';
	    else
		case current_state is 			
		  when first_half =>
		    --valid_out <= '0'; -- in the middle of calculating
		    if valid_out = '1' then
			  second_half_score <= first_half_score;
			  current_template <= Window16_t(template(0 to TEMPLATE_SIZE/2-1));						
			  current_state <= second_half; 
			end if; 			
		  when second_half =>
			temp_score_out := ('0' & second_half_score) + ('0' & first_half_score);
			score_out <= temp_score_out(17 downto 0);
			current_template <= Window16_t(template(TEMPLATE_SIZE/2 to TEMPLATE_SIZE-1));	
			current_state <= first_half;
			--if temp_valid_out = '1' then
			--  valid_out <= '1'; -- output ready
			--end if;
		  when others =>
			current_state <= first_half; -- something went wrong, return to idle  
			--valid_out <= '0';					
			--first_half_score <= (others => '0'); -- clear
		  end case;
		end if;
		end if; 
  end process;
END ARCHITECTURE;