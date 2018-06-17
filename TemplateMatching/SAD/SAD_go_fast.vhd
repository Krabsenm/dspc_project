library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
--library unisim;
--use unisim.vcomponents.all;

use work.TemplateMatchingTypePckg.all; 

entity SAD_go_fast is
port(
 -- Inputs
  clk            :IN    STD_LOGIC;
  reset              :IN    STD_LOGIC;
  
  -- inputs from softcore 
  template             :IN    Window_t;
  
  -- inputs from window buffer
  window_info       :IN     WindowInfo_t; 
  --window_in            :IN    Window_t;
  --x_in                 :IN    X_t;
  --y_in                 :IN    Y_t;
  valid_in             :IN    STD_LOGIC;
  
  -- Outputs
  score_out             : OUT    Score_t;  
  valid_out             : OUT    STD_LOGIC;
  x_out                 : OUT    X_t;
  y_out                 : OUT    Y_t); 
end entity; 


architecture behavioral of SAD_go_fast is
  -- declare signals, components here...
  constant correction_sum : unsigned(10 downto 0) := (10 => '1', others => '0');  
 	
  type stage_512_t is array(0 to 511) of unsigned(9 downto 0);
  type stage_256_t is array(0 to 255) of unsigned(10 downto 0);
  type stage_128_t is array(0 to 127) of unsigned(11 downto 0);  
  type stage_64_t is array(0 to 63)  of unsigned(12 downto 0);
  type stage_32_t is array(0 to 31)  of unsigned(13 downto 0);
  type stage_16_t is array(0 to 15)  of unsigned(14 downto 0);
  type stage_8_t is array(0 to 7)   of unsigned(15 downto 0);
  type stage_4_t is array(0 to 3)   of unsigned(16 downto 0);
  type stage_2_t is array(0 to 1)   of unsigned(17 downto 0);
 

begin
  -- architecture body...
adder_treeProcess : process(clk, reset)

  variable comp_W : WindowC_t;
  variable comp_T : WindowC_t; 
  variable comp_WT : WindowC_t;
 
  variable stage_512 :    stage_512_t;
  variable stage_256 :    stage_256_t;
  variable stage_128 :    stage_128_t;  
  variable stage_64  :    stage_64_t; 
  variable stage_32  :    stage_32_t;
  variable stage_16  :    stage_16_t; 
  variable stage_8   :    stage_8_t;
  variable stage_4   :    stage_4_t;
  variable stage_2   :    stage_2_t;
  variable stage_1   :    unsigned(18 downto 0); 
  variable stage_0   : unsigned(18 downto 0) := (others => '0'); 
begin
	if (reset = '0') then   -- reset to idle state 
		valid_out <= '0'; -- no valid output
	elsif rising_edge(clk) then
		if valid_in = '1' then
		------------------------------------------------------------------------------------------------
		for i in 0 to TEMPLATE_SIZE-1 loop -- rows
				for j in 0 to TEMPLATE_SIZE-1 loop -- column	
					comp_W(i)(j) := ('0' & (not window_info.window(i)(j))) + ('0' & template(i)(j));
					comp_T(i)(j) := ('0' & (window_info.window(i)(j))) + ('0' & (not template(i)(j)));				
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
		------------------------------------------------------------------------------------------------
		-- stage 1
			for a in 0 to TEMPLATE_SIZE/2-1 loop -- rows
				for b in 0 to TEMPLATE_SIZE-1 loop -- column	
					stage_512(a*TEMPLATE_SIZE+b) := ('0' & (comp_WT(a*2)(b))) + ('0' & (comp_WT(a*2+1)(b)));
				end loop;  -- end columns
			end loop;  -- end rows
			
			for c in 0 to 256-1 loop -- column	
				stage_256(c) := ('0' & (stage_512(c*2))) + ('0' & (stage_512(c*2+1))); 
			end loop;  -- end columns
		
			for d in 0 to 128-1 loop -- column	
				stage_128(d) := ('0' & (stage_256(d*2))) + ('0' & (stage_256(d*2+1)));
			end loop;  -- end columns
		
			for e in 0 to 64-1 loop -- column	
				stage_64(e) := ('0' & (stage_128(e*2))) + ('0' & (stage_128(e*2+1)));
			end loop;  -- end columns
			
			for f in 0 to 32-1 loop -- column	
				stage_32(f) := ('0' & (stage_64(f*2))) + ('0' & (stage_64(f*2+1)));
			end loop;  -- end columns
		
			for g in 0 to 16-1 loop -- column	
				stage_16(g) := ('0' & (stage_32(g*2))) + ('0' & (stage_32(g*2+1)));
			end loop;  -- end columns
		
			for i in 0 to 8-1 loop -- column	
				stage_8(i) := ('0' & (stage_16(i*2))) + ('0' & (stage_16(i*2+1)));
			end loop;  -- end columns
		
			for j in 0 to 4-1 loop -- column	
				stage_4(j) := ('0' & (stage_8(j*2))) + ('0' & (stage_8(j*2+1)));
			end loop;  -- end columns
		
		    for k in 0 to 2-1 loop -- column	
				stage_2(k) := ('0' & (stage_4(k*2))) + ('0' & (stage_4(k*2+1)));
			end loop;  -- end columns
		    	
			stage_1 := ('0' & (stage_2(0))) + ('0' & (stage_2(1)));
			
			
			stage_0 := (stage_1 + correction_sum); 
			
			score_out <= stage_0(17 downto 0); --adds correction_sum
			
			X_out <= window_info.x;
			Y_out <= window_info.y;
			
			valid_out <= '1';
		else 
			valid_out <= '0';
			score_out <= (others => '0');
		end if; 
	end if;		
end process;
end architecture;
 

