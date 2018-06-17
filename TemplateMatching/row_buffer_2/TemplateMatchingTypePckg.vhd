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
  constant NUM_SAD        : natural := 3;
  
  subtype Pixel_t  is unsigned(PIXEL_SIZE-1 downto 0);
  type ImageRow_t  is array(0 to IMAGE_WIDTH-1) of Pixel_t;
  
  type WindowRow_t is array(0 to TEMPLATE_SIZE-1) of Pixel_t;
  type Window_t    is array(0 to TEMPLATE_SIZE-1) of WindowRow_t;
  
  subtype Score_t  is integer range 0 to SCORE_MAX;
  subtype X_t      is integer range 0 to IMAGE_WIDTH-1;
  subtype Y_t      is integer range 0 to IMAGE_HEIGHT-1;
  
  type WindowInfo_t is record
    window : Window_t;
    x      : X_t;
    y      : Y_t;
  end record;
  
  type window_buffer_data_output_t is array(0 to NUM_SAD) of WindowInfo_t;
  
  -- Reset types to all '0' constanst
  constant Pixel_t_init      : Pixel_t      := (others => '0');
  constant ImageRow_t_init   : ImageRow_t   := (others => Pixel_t_init);
  constant WindowRow_t_init  : WindowRow_t  := (others => Pixel_t_init);
  constant Window_t_init     : Window_t     := (others => WindowRow_t_init);
  constant WindowInfo_t_init : WindowInfo_t := (window => Window_t_init, x => 0, y => 0);
end package;
