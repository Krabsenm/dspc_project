library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

use work.TemplateMatchingTypePckg.all; 

entity complement_sum is
port(
	-- inputs
	clk  : in std_logic; 
	reset      : in std_logic; 
	
	template   : in Window_t;
	window_in  : in WindowInfo_t;  
	valid_in   : in std_logic; 
	-- outputs
	window_out : out WindowInfoC_t;
	valid_out_comp  : out std_logic);
	
end entity; 

architecture behavior of complement_sum is

begin

compProcess : process(clk, reset)
	variable comp_W : WindowC_t;
	variable comp_T : WindowC_t;
	variable comp_WT : WindowC_t;
begin
	if (reset = '1') then   -- reset to idle state 
		valid_out_comp <= '0'; -- no valid output
		window_out <= WindowInfoC_t_init;
	elsif rising_edge(clk) then
		if valid_in = '1' then
			for i in 0 to TEMPLATE_SIZE-1 loop -- rows
				for j in 0 to TEMPLATE_SIZE-1 loop -- column	
					-- two sums are calculated, not win + temp   and win + not temp 
					comp_W(i)(j) := ('0' & (not window_in.window(i)(j))) + ('0' & template(i)(j));
					comp_T(i)(j) := ('0' & (window_in.window(i)(j))) + ('0' & (not template(i)(j)));				
				end loop;  -- end columns
			end loop;  -- end rows
		
			-- the value where MSB = 1 is the right value.   
			for i in 0 to TEMPLATE_SIZE-1 loop -- rows
				for j in 0 to TEMPLATE_SIZE-1 loop -- column	
					if comp_W(i)(j)(8 downto 8) = B"1" then 
						comp_WT(i)(j) := comp_W(i)(j);
					else
						comp_WT(i)(j) := comp_T(i)(j);
					end if; 
				end loop;  -- end columns
			end loop;  -- end rows
			window_out.window <= comp_WT;
			window_out.x <= window_in.x; 
			window_out.y <= window_in.y;
			valid_out_comp <= '1';
		else 
			valid_out_comp <= '0';
		end if; 
	end if;		
end process;

end architecture; 

