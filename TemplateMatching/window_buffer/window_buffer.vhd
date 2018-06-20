library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.TemplateMatchingTypePckg.all;
--library unisim;
--use unisim.vcomponents.all;

entity window_buffer is
  port (
    -- inputs
    clk               : in    std_logic;
    reset             : in    std_logic;

    in_data           : in    ImageRow_t;
    in_valid          : in    std_logic;

    -- Bidirectional

    -- Outputs
    out_data          : buffer window_buffer_data_output_t;
    out_valid         : buffer std_logic
  );
end entity;

architecture arch of window_buffer is
  -- declare signals, components here...
  type Row_collector_t is array(0 to TEMPLATE_SIZE - 1) of ImageRow_t;
  signal row_collector : Row_collector_t;
  
  TYPE window_buffer_states_type IS (load_line, snip_window);
  Signal window_buffer_states : window_buffer_states_type := load_line;
  
  signal x_counter : X_t;
  signal y_counter : Y_t;
  signal row_counter : integer range 0 to TEMPLATE_SIZE;
begin

  window_buffer: process (clk)
 --   variable row_counter  : integer range 0 to TEMPLATE_SIZE;
 --   variable x_counter    : integer range 0 to IMAGE_WIDTH - TEMPLATE_SIZE;
 --   variable y_counter    : integer range 0 to IMAGE_HEIGHT - TEMPLATE_SIZE;
    variable temp_row     : ImageRow_t;
  -- variables yo
  
  begin
    if rising_edge(clk) then
      if reset = '1' then
        row_counter <= 0;
        x_counter   <= 0;
        y_counter   <= 0;
        window_buffer_states <= load_line;
      
      else
        case window_buffer_states is
          when load_line =>
          
            out_valid <= '0';
          
            if in_valid = '1' then          
              if row_counter < TEMPLATE_SIZE then
                row_collector(row_counter) <= in_data;
                row_counter <= row_counter + 1;
              
              else
                for shift_var in 0 to TEMPLATE_SIZE - 2 loop
                  row_collector(shift_var) <= row_collector(shift_var + 1);
                end loop;  
                row_collector(TEMPLATE_SIZE - 1) <= in_data;
                
                
                y_counter <= y_counter + 1;
              end if;
              
              if row_counter >= TEMPLATE_SIZE-1 then
                window_buffer_states <= snip_window;
              end if;
            end if;
            
          when snip_window =>  

            out_valid <= '1';
           
            for window_var in 0 to NUM_SAD - 1 loop
              for windowRow_var in 0 to TEMPLATE_SIZE - 1 loop
                temp_row := row_collector(windowRow_var);
                out_data(window_var).window(windowRow_var) <= WindowRow_t(temp_row(x_counter + window_var to (x_counter + window_var + TEMPLATE_SIZE - 1)));
              end loop;
              
              out_data(window_var).x <= x_counter + window_var;
              out_data(window_var).y <= y_counter;
            end loop;
            
            x_counter <= x_counter + NUM_SAD;
          
            if (x_counter = (IMAGE_WIDTH - TEMPLATE_SIZE - NUM_SAD)) then
              window_buffer_states <= load_line;
              x_counter <= 0;
              
              if y_counter >= (IMAGE_HEIGHT - TEMPLATE_SIZE) then
                row_counter <= 0;
                y_counter   <= 0;  
              end if;
            end if;
            
            -- Reset for next image
            
          
          when others =>
            null;
        end case;
      end if;
    end if;
  end process;  
end architecture;
