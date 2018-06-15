library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use.work.TemplateMatchingTypePck.all
--library unisim;
--use unisim.vcomponents.all;

entity square_drawer is
  generic (bitperiod : time := 20 ns);  -- Default value
  port (
  
    -- Inputs --
    clk                 : in  std_logic;   -- 50 MHz
    reset               : in  std_logic;
	
    in_data             : in std_logic_vector(7 downto 0);
    in_startofpacket    : in std_logic;
    in_endofpacket      : in std_logic;
    in_valid            : in std_logic;
    
    out_ready           : in std_logic;
    
    -- outputs --
    in_ready            : BUFFER std_logic;
    
    out_data            : BUFFER std_logic_vector( 7 downto 0);
    out_startofpacket   : BUFFER std_logic;
    out_endofpakcet     : BUFFER std_logic;
    out_valid           : BUFFER std_logic;
    
    );
end entity iis2st;
