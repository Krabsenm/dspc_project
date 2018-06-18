library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.TemplateMatchingTypePckg.all;
--library unisim;
--use unisim.vcomponents.all;

entity square_drawer is
  generic (
    square_color : std_logic_vector := X"FF"
  );  -- Default value
  port (
  
    -- Inputs --
    -- Pixel stream
    clk                 : in  std_logic;   -- 50 MHz
    reset               : in  std_logic;
	
    in_data             : in std_logic_vector(7 downto 0);
    in_startofpacket    : in std_logic;
    in_endofpacket      : in std_logic;
    in_valid            : in std_logic;
    
    -- From threshold
    in_xy_valid         : in std_logic; 
    in_x                : in X_t; 
    in_y                : in Y_t;
    
    -- outputs --
    out_data             : out std_logic_vector(7 downto 0);
    out_startofpacket    : out std_logic;
    out_endofpacket      : out std_logic;
    out_valid            : out std_logic
    );
end entity;

architecture arch of square_drawer is
  -- declare signals, components here...
  signal x, x_current, x_drawing  : X_t := 0;
  signal y, y_current, y_drawing  : Y_t := 0;
  signal draw     : std_logic := '0';
  
  TYPE square_drawer_state_type IS (pass_through, drawing);
  Signal square_drawer_state : square_drawer_state_type := pass_through;
  
begin

  square_drawer_l: process (clk)
  begin
    if rising_edge(clk) then
      out_valid <= in_valid;
      out_startofpacket <= in_startofpacket;
      out_endofpacket <= in_endofpacket;
      
      if reset = '1' then
        out_data            <= (others => '0');
        out_startofpacket   <= '0';
        out_endofpacket     <= '0';
        out_valid           <= '0';
        x                   <= 0;
        y                   <= 0;
        draw                <= '0';
        x_drawing           <= 0;
        y_drawing           <= 0;
        x_current           <= 0;
        y_current           <= 0;
      
       else
        -- Get draw coordiantes from threshold module
        if in_xy_valid = '1' then
          draw <= '1';
          x <= in_x;
          y <= in_y;
        end if;
        
        -- Draw sqaure on stream or pass stream
        if in_valid = '1' then
          case square_drawer_state is
            when pass_through =>
              out_data <= in_data;
              
            when drawing =>
              out_data <= in_data;
              if (y_current = y_drawing) OR (y_current = (y_drawing+TEMPLATE_SIZE-1)) then
                if (x_drawing <= x_current) AND (x_current < (x_drawing+TEMPLATE_SIZE)) then
                  out_data <= square_color;
                end if;
              elsif y_drawing < y_current AND y_current < (y_drawing+TEMPLATE_SIZE-1) then
                if x_current = x_drawing OR x_current = (x_drawing+TEMPLATE_SIZE-1) then
                  out_data <= square_color;
                end if;
              end if;
            
              -- set coordinate of next pixel
              
              if x_current = (IMAGE_WIDTH - 1) then
                x_current <= 0;
                y_current <= y_current + 1;
              else
                x_current <= x_current + 1;
              end if;
              
              
            when others =>
              null;
          end case;
          
          if in_endofpacket = '1' then
            x_current <= 0;
            y_current <= 0;
            
            if draw = '1' then
              square_drawer_state <= drawing;
              x_drawing <= x;
              y_drawing <= y;
              draw <= '0';
            else
              square_drawer_state <= pass_through;
            end if;
          end if; -- endofpacket
        end if;
      end if; -- reset
    end if; -- rising_edge
  end process;
  
end architecture;

