library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

use work.TemplateMatchingTypePckg.all; 

entity adder_tree is
port(
	-- inputs
	clk  : in std_logic; 
	reset      : in std_logic; 

	comp_sum  : in WindowInfoC_t;  
	valid_in   : in std_logic; 
	-- outputs
	SAD_out : out unsigned(17 downto 0) := B"111111110000000000";  -- max score: 32*32*255 = 261.120 = 0b‭111111110000000000;
	X_out   : out X_t; 
	Y_out   : out Y_t; 
	valid_out  : out std_logic);
end entity; 


architecture behavioral of adder_tree is
  constant correction_sum : unsigned(10 downto 0) := (10 => '1', others => '0'); -- 1024 ~ 0b1000000000  
  signal pipe_delay_in : integer range 0 to 11 := 0; -- delay introduced by pipeline
  signal pipe_delay_out : integer range 0 to 11 := 0; -- delay introduced by pipeline 
  
  type X_out_array_t is array(0 to 9) of X_t; -- delayline for x coordinate   
  type Y_out_array_t is array(0 to 9) of Y_t; -- delayline for y coordinate
  signal X_delay_line : X_out_array_t := (others => 0);
  signal Y_delay_line : Y_out_array_t := (others => 0);
  
	
  -- stages in the addertree	
  type stage_512_t is array(0 to 511) of unsigned(9 downto 0);
  type stage_256_t is array(0 to 255) of unsigned(10 downto 0);
  type stage_128_t is array(0 to 127) of unsigned(11 downto 0);  
  type stage_64_t is array(0 to 63)  of unsigned(12 downto 0);
  type stage_32_t is array(0 to 31)  of unsigned(13 downto 0);
  type stage_16_t is array(0 to 15)  of unsigned(14 downto 0);
  type stage_8_t is array(0 to 7)   of unsigned(15 downto 0);
  type stage_4_t is array(0 to 3)   of unsigned(16 downto 0);
  type stage_2_t is array(0 to 1)   of unsigned(17 downto 0);
 
  signal stage_512 :    stage_512_t;
  signal stage_256 :    stage_256_t;
  signal stage_128 :    stage_128_t;  
  signal stage_64  :    stage_64_t; 
  signal stage_32  :    stage_32_t;
  signal stage_16  :    stage_16_t; 
  signal stage_8   :    stage_8_t;
  signal stage_4   :    stage_4_t;
  signal stage_2   :    stage_2_t;
  signal stage_1   :    unsigned(18 downto 0);

begin
  -- architecture body...
 
adder_treeProcess : process(clk, reset)
variable stage_0 : unsigned(18 downto 0) := (others => '0'); -- extra stage used for correction_sum summation 
 
begin
	if (reset = '1') then   -- reset to idle state 
		valid_out <= '0'; -- no valid output
    SAD_out <= B"111111110000000000";  -- max score: 32*32*255 = 261.120 = 0b‭111111110000000000
	elsif rising_edge(clk) then
		if valid_in = '1' OR pipe_delay_in < 10 then
      if valid_in = '1' AND pipe_delay_in = 10 then
        pipe_delay_in <= 0;
      end if;
    
		-- stage 1
			for a in 0 to TEMPLATE_SIZE/2-1 loop -- rows
				for b in 0 to TEMPLATE_SIZE-1 loop -- column	
					stage_512(a*TEMPLATE_SIZE+b) <= ('0' & (comp_sum.window(a*2)(b))) + ('0' & (comp_sum.window(a*2+1)(b)));
				end loop;  -- end columns
			end loop;  -- end rows
			
			for c in 0 to 256-1 loop -- column	
				stage_256(c) <= ('0' & (stage_512(c*2))) + ('0' & (stage_512(c*2+1))); 
			end loop;  -- end columns
		
			for d in 0 to 128-1 loop -- column	
				stage_128(d) <= ('0' & (stage_256(d*2))) + ('0' & (stage_256(d*2+1)));
			end loop;  -- end columns
		
			for e in 0 to 64-1 loop -- column	
				stage_64(e) <= ('0' & (stage_128(e*2))) + ('0' & (stage_128(e*2+1)));
			end loop;  -- end columns
			
			for f in 0 to 32-1 loop -- column	
				stage_32(f) <= ('0' & (stage_64(f*2))) + ('0' & (stage_64(f*2+1)));
			end loop;  -- end columns
		
			for g in 0 to 16-1 loop -- column	
				stage_16(g) <= ('0' & (stage_32(g*2))) + ('0' & (stage_32(g*2+1)));
			end loop;  -- end columns
		
			for i in 0 to 8-1 loop -- column	
				stage_8(i) <= ('0' & (stage_16(i*2))) + ('0' & (stage_16(i*2+1)));
			end loop;  -- end columns
		
			for j in 0 to 4-1 loop -- column	
				stage_4(j) <= ('0' & (stage_8(j*2))) + ('0' & (stage_8(j*2+1)));
			end loop;  -- end columns
		
		    for k in 0 to 2-1 loop -- column	
				stage_2(k) <= ('0' & (stage_4(k*2))) + ('0' & (stage_4(k*2+1)));
			end loop;  -- end columns
		    	
			stage_1 <= ('0' & (stage_2(0))) + ('0' & (stage_2(1)));
			
			
			stage_0 := (stage_1 + correction_sum); 
			
			SAD_out <= stage_0(17 downto 0); --adds correction_sum
			
			X_out <= X_delay_line(9);
			Y_out <= Y_delay_line(9);
			
			
			for l in 0 to 8 loop
				X_delay_line(9-l) <= X_delay_line(9-(l+1));
	            Y_delay_line(9-l) <= Y_delay_line(9-(l+1));				
			end loop;
				X_delay_line(0) <= comp_sum.x;
        Y_delay_line(0) <= comp_sum.y;				
			
				
			if valid_in = '0' then
				pipe_delay_in <= pipe_delay_in + 1; 
			end if; 
			
			-- set valid_out high when input have propagated through the pipeline
			if pipe_delay_out = 11	 then  
				valid_out <= '1';
			else
				pipe_delay_out <= pipe_delay_out + 1; 
			end if; 
		else -- Can we remove? for space?
			valid_out <= '0';
			pipe_delay_out <= 0;			
			stage_512 <= (others => (others => '0'));
			stage_256 <= (others => (others => '0'));
			stage_128 <= (others => (others => '0'));
			stage_64 <= (others => (others => '0'));
			stage_32 <= (others => (others => '0'));
			stage_16 <= (others => (others => '0'));
			stage_8 <= (others => (others => '0'));
			stage_4 <= (others => (others => '0'));
			stage_2 <= (others => (others => '0'));
			stage_1 <= (others => '0');
		end if; 
	end if;		
end process;
end architecture;
