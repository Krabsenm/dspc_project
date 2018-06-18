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
    -- threshold level 
    THRESHOLD : unsigned := B"000000000001000000";
    X_MAX     : X_t := LAST_X;
    Y_MAX     : Y_t := LAST_Y
  );
  port (
    -- Inputs
    clk       : in    STD_LOGIC;
    reset     : in    STD_LOGIC;
    
    -- number of inputs set to number of SAD modules
    valid_in  : in std_logic_vector(NUM_SAD-1 downto 0);
    scores_in : in threshold_data_inputs_t;
    
    -- output
    valid_out : out std_logic; 
    x_out     : out X_t; 
    y_out     : out Y_t
  );
end entity;


architecture arch of Threshold is
  -- State machine
  type states_t is (compare, output);
  signal state : states_t;

  signal score : Score_t := B"111111110000000000";  -- max score: 32*32*255 = 261.120 = 0b‭111111110000000000
  signal x     : X_t := 0; 
  signal y     : Y_t := 0; 
  
begin
  
  threshold_l: process (clk)
    variable local_score   :Score_t;
    variable local_score_i :integer range 0 to NUM_SAD-1;
  begin
    if rising_edge(clk) then
      if reset = '1' then
        state <= compare;
        score <= B"111111110000000000";  -- max score: 32*32*255 = 261.120 = 0b‭111111110000000000
        x     <= 0;
        y     <= 0;
        valid_out <= '0';
      else
      
        case state is
          when compare =>
            valid_out <= '0';
            local_score := score; --scores_in(2).score;
            
            for i in 0 to NUM_SAD-1 loop
              if valid_in(i) = '1' then
                if scores_in(i).score < local_score then
                  local_score := scores_in(i).score;
                  x <= scores_in(i).x;
                  y <= scores_in(i).y;
                end if;
                -- 
                if scores_in(i).x <= (X_MAX-(NUM_SAD-1)) AND scores_in(i).y = (Y_MAX) then
                  state <= output;
                end if;
              end if;
            end loop;
              
              score <= local_score;
              
          when output =>
            if score < THRESHOLD then
              valid_out <= '1';
              x_out <= x;
              y_out <= y;
            end if;
            
            score <= B"111111110000000000"; -- max score: 32*32*255 = 261.120 = 0b‭111111110000000000
            state <= compare;
            
          when others =>
            state <= compare;
        end case;
      end if;
    end if;
  end process;
end architecture;











