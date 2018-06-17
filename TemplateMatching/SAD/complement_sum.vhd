library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
--library unisim;
--use unisim.vcomponents.all;

use work.TemplateMatchingTypePckg.all; 

entity complement_sum is
port(
	-- inputs
	clk_50MHz  : in std_logic; 
	reset      : in std_logic; 
	
	template   : in Window_t;
	window_in  : in WindowInfo_t;  
	valid_in   : in std_logic; 
	-- outputs
	window_out : out WindowInfoC_t;
	valid_out  : out std_logic);
	
end entity; 

architecture behavior of complement_sum is

signal template_complement : Window_t; 

begin

compProcess : process(clk_50MHz, reset)
	variable comp_W : WindowC_t;
	variable comp_T : WindowC_t;
	variable comp_WT : WindowC_t;
begin
	if (reset = '0') then   -- reset to idle state 
		valid_out <= '0'; -- no valid output
		window_out <= WindowInfoC_t_init;
		for i in 0 to TEMPLATE_SIZE-1 loop -- rows
			for j in 0 to TEMPLATE_SIZE-1 loop -- column	
				template_complement(i)(j) <= not template(i)(j); 
			end loop;  -- end columns
		end loop;  -- end rows
	elsif rising_edge(clk_50MHz) then
		if valid_in = '1' then
			for i in 0 to TEMPLATE_SIZE-1 loop -- rows
				for j in 0 to TEMPLATE_SIZE-1 loop -- column	
					comp_W(i)(j) := ('0' & (not window_in.window(i)(j))) + ('0' & template(i)(j));
					comp_T(i)(j) := ('0' & (window_in.window(i)(j))) + ('0' & template_complement(i)(j));				
				end loop;  -- end columns
			end loop;  -- end rows
		
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
			valid_out <= '1';
		else 
			valid_out <= '0';
		end if; 
	end if;		
end process;

end architecture; 










