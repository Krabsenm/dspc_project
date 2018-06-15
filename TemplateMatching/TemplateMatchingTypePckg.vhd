library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
--library unisim;
--use unisim.vcomponents.all;

package TemplateMatchingTypePckg is
  -- Place declarations for types, constants, components, functions...
  constant IMAGE_WIDTH    : natural := 320;
  constant IMAGE_HEIGHT   : natural := 240;
  constant PIXEL_SIZE     : natural := 8;
  constant TEMPLATE_SIZE  : natural := 32;
  constant SCORE_MAX      : natural := TEMPLATE_SIZE*TEMPLATE_SIZE*(2**(PIXEL_SIZE));
  
  subtype Pixel_t  is std_logic_vector(PIXEL_SIZE-1 downto 0);
  type ImageRow_t  is array(0 to IMAGE_WIDTH-1) of Pixel_t;
  
  type WindowRow_t is array(0 to TEMPLATE_SIZE-1) of Pixel_t;
  type Window_t    is array(0 to TEMPLATE_SIZE-1) of WindowRow_t;
  
  subtype Score_t  is integer range 0 to SCORE_MAX;
  subtype X_t      is integer range 0 to IMAGE_WIDTH-1;
  subtype Y_t      is integer range 0 to IMAGE_HEIGHT-1;
  
end package;
