library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TemplateLoader is
  
  port (
    -- Avalon Interface
    csi_clockreset_clk     : in  std_logic;                     -- Avalon Clk
    csi_clockreset_reset_n : in  std_logic;                     -- Avalon Reset
    avs_s1_write           : in  std_logic;                     -- Avalon wr
    avs_s1_read            : in  std_logic;                     -- Avalon rd
    avs_s1_chipselect      : in  std_logic;                     -- Avalon cs
    avs_s1_byteenable      : in  std_logic_vector(1 downto 0);  -- Avalon byteenable
    avs_s1_address         : in  std_logic_vector(7 downto 0);  -- Avalon address
    avs_s1_writedata       : in  std_logic_vector(15 downto 0); -- Avalon wr data
    avs_s1_readdata        : out std_logic_vector(15 downto 0); -- Avalon rd data

    -- Template for SAD module    
	temp_pixel_out               : out unsigned(15 downto 0); 
	valid_out                    : out std_logic);
	
end TemplateLoader;


architecture arch of TemplateLoader is
  -- Signal Declarations
  signal writedata : std_logic_vector(15 downto 0) := (others => '0');
  signal ready : std_logic := '0'; 
begin

  -- No read data
  avs_s1_readdata <= (others => 'Z');
  
  -- Store write data
  store_writedata : process (csi_clockreset_clk, csi_clockreset_reset_n)
  begin
    if csi_clockreset_reset_n = '0' then
      writedata <= (others => '0');
      
    elsif rising_edge(csi_clockreset_clk) then
      if avs_s1_chipselect = '1' then
        if avs_s1_write = '1' then
          if avs_s1_address = "00000000" then
            case avs_s1_byteenable is
              when "01" => writedata <= writedata(15 downto 8) & avs_s1_writedata(7 downto 0);
              when "10" => writedata <= avs_s1_writedata(15 downto 8) & writedata(7 downto 0);
              when "11" => 
			    writedata <= avs_s1_writedata;
			    ready <= '1'; 
              when others => writedata <= writedata;
            end case;
			temp_pixel_out <= unsigned(writedata);
			valid_out <= ready;
          else
			valid_out <= '0';
			ready <= '0';
		  end if;
        end if;
      end if;
	end if;  
  end process;
end architecture;
