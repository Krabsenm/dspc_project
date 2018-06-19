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
  constant NUM_SAD        : natural := 2;
  constant LAST_X         : natural := IMAGE_WIDTH-TEMPLATE_SIZE; 
  constant LAST_Y         : natural := IMAGE_HEIGHT-TEMPLATE_SIZE;
  constant SHIFTS         : natural := 130; 
  
  subtype Pixel_t  is unsigned(PIXEL_SIZE-1 downto 0);
  type ImageRow_t  is array(0 to IMAGE_WIDTH-1) of Pixel_t;
  
  type WindowRow_t is array(0 to TEMPLATE_SIZE-1) of Pixel_t;
  type Window_t    is array(0 to TEMPLATE_SIZE-1) of WindowRow_t;
  
  type Window16_t    is array(0 to TEMPLATE_SIZE/2-1) of WindowRow_t;
  
  
  subtype Score_t  is unsigned(17 downto 0); -- integer range 0 to SCORE_MAX;
  subtype X_t      is integer range 0 to IMAGE_WIDTH;
  subtype Y_t      is integer range 0 to IMAGE_HEIGHT;
  
  type WindowInfo_t is record
    window : Window_t;
    x      : X_t;
    y      : Y_t;
  end record;

   type WindowInfo16_t is record
    window : Window16_t;
    x      : X_t;
    y      : Y_t;
  end record;
  
  subtype PixelC_t  is unsigned(PIXEL_SIZE downto 0);
  type WindowRowC_t is array(0 to TEMPLATE_SIZE-1) of PixelC_t;
  type WindowC_t    is array(0 to TEMPLATE_SIZE-1) of WindowRowC_t;

  type WindowC16_t    is array(0 to TEMPLATE_SIZE/2-1) of WindowRowC_t;

  
  type WindowInfoC_t is record
    window : WindowC_t;
    x      : X_t;
    y      : Y_t;
  end record;

    type WindowInfoC16_t is record
    window : WindowC16_t;
    x      : X_t;
    y      : Y_t;
  end record;
  
  
  type ScoreInfo_t is record
    score : Score_t;
    x     : X_t;
    y     : Y_t;
  end record;
  
  type window_buffer_data_output_t is array(0 to NUM_SAD-1) of WindowInfo_t;
  type threshold_data_inputs_t     is array(0 to NUM_SAD-1) of ScoreInfo_t;
  
  -- Reset types to all '0' constanst
  constant Pixel_t_init      : Pixel_t      := (others => '0');
  constant ImageRow_t_init   : ImageRow_t   := (others => Pixel_t_init);
  constant WindowRow_t_init  : WindowRow_t  := (others => Pixel_t_init);
  constant Window_t_init     : Window_t     := (others => WindowRow_t_init);
  constant WindowInfo_t_init : WindowInfo_t := (window => Window_t_init, x => 0, y => 0);



  
   -- Reset types to all '0' constanst
  constant PixelC_t_init      : PixelC_t      := (others => '0');
  constant WindowRowC_t_init  : WindowRowC_t  := (others => PixelC_t_init);
  constant WindowC_t_init     : WindowC_t     := (others => WindowRowC_t_init);
  constant WindowInfoC_t_init : WindowInfoC_t := (window => WindowC_t_init, x => 0, y => 0);
  
end package;
