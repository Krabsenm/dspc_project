library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.TemplateMatchingTypePckg.all;

-- --------------------------------------------------------------------
-- Description:
-- Window_buffer saves the amount of image rows needed for a window, 
-- then snips the rows into parts, the size of a window 
-- --------------------------------------------------------------------

entity window_buffer is
  port (
    -- inputs
    clk               : in    std_logic;
    reset             : in    std_logic;

    in_data           : in    ImageRow_t;
    in_valid          : in    std_logic;

    -- Outputs
    out_data          : buffer window_buffer_data_output_t;
    out_valid         : buffer std_logic
  );
end entity;

architecture arch of window_buffer is
  -- declare signals, components here...
  type Row_collector_t is array(0 to TEMPLATE_SIZE - 1) of ImageRow_t;
  signal row_collector : Row_collector_t;
  
  TYPE state_type IS (load_line, shift_lines, snip_window);
  Signal state : state_type := load_line;
  
  signal x_counter : X_t;
  signal y_counter : Y_t;
  signal row_counter : integer range 0 to TEMPLATE_SIZE;
begin

  window_buffer: process (clk)
    variable temp_row     : ImageRow_t;
    
  begin
    if rising_edge(clk) then
      -- Sync reset
      if reset = '1' then
        row_counter <= 0;
        x_counter   <= 0;
        y_counter   <= 0;
        state <= load_line;
      
      else
        case state is
          when load_line => -- Save the amount of rows needed for a window
          
            out_valid <= '0';
          
            if in_valid = '1' then -- Wait for row    
              row_collector(row_counter) <= in_data;
              row_counter <= row_counter + 1;
              y_counter <= y_counter + 1;
              
              -- If we have the rows needed for a window, go to snipping state
              if row_counter >= TEMPLATE_SIZE-1 then
                state <= snip_window;
              end if;
            end if;

            
          when shift_lines => -- Shift all rows up and insert new row in the bottom
            out_valid <= '0';
            
            if in_valid = '1' then -- Wait for row
              for shift_var in 0 to TEMPLATE_SIZE - 2 loop
                row_collector(shift_var) <= row_collector(shift_var + 1);
              end loop;
              
              row_collector(TEMPLATE_SIZE - 1) <= in_data;
              y_counter <= y_counter + 1;
              
              state <= snip_window;
            end if;
          
          
          when snip_window =>  
            out_valid <= '1';
           
            -- Build the window part to be sent from the Image row storage
            for window_var in 0 to NUM_SAD - 1 loop
              for windowRow_var in 0 to TEMPLATE_SIZE - 1 loop
                temp_row := row_collector(windowRow_var);
                out_data(window_var).window(windowRow_var) <= WindowRow_t(temp_row(x_counter + window_var to (x_counter + window_var + TEMPLATE_SIZE - 1)));
              end loop;
              
              out_data(window_var).x <= x_counter + window_var;
              out_data(window_var).y <= y_counter;
            end loop;
            
            x_counter <= x_counter + NUM_SAD;
          
            -- When a window has been sent increment x and
            -- check if all windows has been sent
            if (x_counter = (IMAGE_WIDTH - TEMPLATE_SIZE - NUM_SAD)) then
              -- Reset for next row
              state <= shift_lines;
              x_counter <= 0;
              
              -- Reset for next image
              if y_counter >= (IMAGE_HEIGHT - TEMPLATE_SIZE) then
                row_counter <= 0;
                y_counter   <= 0;  
                state <= load_line;
              end if;
            end if;
          
          when others =>
            state <= load_line;
        end case;
      end if;
    end if;
  end process;  
end architecture;
