library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.TemplateMatchingTypePckg.all;
--library unisim;
--use unisim.vcomponents.all;

-- --------------------------------------------------------------------
-- Description:
-- Window_buffer saves the amount of image rows needed for a window, 
-- then snips the rows into parts, the size of a window divided by the 
-- computational steps available for each window (2)
-- --------------------------------------------------------------------

entity window_buffer is
  port (
    -- inputs
    clk               : in    std_logic;
    reset             : in    std_logic;

    in_data           : in    ImageRow_t;
    in_valid          : in    std_logic;
    
    -- Bidirectional

    -- Outputs
    out_data          : buffer WindowInfo16_t;
    out_valid         : buffer std_logic
  );
end entity;

architecture arch of window_buffer is
  -- declare signals, components here...
  type Row_collector_t is array(0 to TEMPLATE_SIZE - 1) of ImageRow_t;
  signal row_collector : Row_collector_t;
  
  TYPE states_t IS (load_line, snip_window);
  Signal state : states_t := load_line;
  
  signal x_counter : X_t;
  signal y_counter : Y_t;
  signal row_counter : integer range 0 to TEMPLATE_SIZE;
  
  signal windows_sent : integer range 0 to COMPS-1; -- Parts of the window sent
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
          when load_line =>
            out_valid <= '0';
            
            if in_valid = '1' then -- Wait for row  
              if row_counter < TEMPLATE_SIZE then -- Save the amount of ros needed for a window
                row_collector(row_counter) <= in_data;
                row_counter <= row_counter + 1;
              
              else -- Shift all rows up and insert new row in the bottom
                for shift_var in 0 to TEMPLATE_SIZE - 2 loop
                  row_collector(shift_var) <= row_collector(shift_var + 1);
                end loop;  
                row_collector(TEMPLATE_SIZE - 1) <= in_data;               
                y_counter <= y_counter + 1;
              end if;
              
              -- If we have the rows needed for a window, go to snipping state
              if row_counter >= TEMPLATE_SIZE-1 then 
                state <= snip_window;
                windows_sent <= 0;
              end if;
            end if;
            
          when snip_window =>
            out_valid <= '1';
            
            -- Build the window part to be sent from the Image row storage
            for windowRow_var in 0 to (TEMPLATE_SIZE/COMPS) - 1 loop
              temp_row := row_collector(windowRow_var+((TEMPLATE_SIZE/COMPS)*windows_sent));
              out_data.window(windowRow_var) <= WindowRow_t(temp_row(x_counter to (x_counter + TEMPLATE_SIZE - 1)));
            end loop;
            
            out_data.x <= x_counter;
            out_data.y <= y_counter;
            
            -- When a whole window has been sent increment x and
            -- check if all windows has been sent
            if windows_sent = COMPS-1 then
              windows_sent <= 0;
              x_counter <= x_counter + 1;
              
              -- Reset for next row
              if (x_counter = (IMAGE_WIDTH - TEMPLATE_SIZE)) then
                state <= load_line;
                x_counter <= 0;
                
                -- Reset for next image
                if y_counter >= (IMAGE_HEIGHT - TEMPLATE_SIZE) then
                  row_counter <= 0;
                  y_counter   <= 0;  
                end if;
              end if;
              
            else -- If part(s) of the window has not been sent
              windows_sent <= windows_sent+1;
            end if;
          when others =>
            null;
        end case;
      end if;
    end if;
  end process;  
end architecture;
