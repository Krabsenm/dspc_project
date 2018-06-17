library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.TemplateMatchingTypePckg.all;
--library unisim;
--use unisim.vcomponents.all;

entity pixel_buffer is
  --generic (
    -- Generics go here...
  --);
  port (
    -- inputs
    clk               :in    std_logic;
    reset             :in    std_logic;

    in_data           :in    std_logic_vector( 7 DOWNTO  0);  
    in_startofpacket  :in    std_logic;
    in_endofpacket    :in    std_logic;
    in_valid          :in    std_logic;

    -- Bidirectional

    -- Outputs
    in_ready          :buffer  std_logic;

    out_valid         :buffer  std_logic;
    out_data          :buffer  Pixel_t
  );
end entity;

architecture arch of pixel_buffer is
  -- declare signals, components here...
begin
  in_ready <= '1'; -- always accept input
  
  buffer_l: process (clk)
  begin
    if rising_edge(clk) then
      if reset = '1' then
        out_valid <= '0';
        out_data <= (others => '0');

      else
        if (in_ready = '1') then
          out_data <= in_data;
          out_valid <= in_valid;
        end if;
      end if;
    end if;
  end process;
  
  -- architecture body...
end architecture;
