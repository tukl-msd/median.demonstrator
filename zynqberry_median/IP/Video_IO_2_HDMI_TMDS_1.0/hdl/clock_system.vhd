----------------------------------------------------------------------------------
-- Company: Trenz Electronic GmbH
-- Engineer: Oleksandr Kiyenko
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;
library UNISIM; 
use UNISIM.VCOMPONENTS.ALL; 
----------------------------------------------------------------------------------
entity clock_system is
generic(
	C_VIDEO_MODE	: integer range 0 to 8	:= 2
-- 0 = VGA        (640x480 @ 60 Hz)  25   250 24b
-- 1 = 480p       (720x480 @ 60 Hz)  27   270 24b
-- 2 = SVGA       (800x600 @ 60 Hz)  40   400 24b
-- 3 = XGA        (1024x768 @ 60 Hz) 65   650 24b
-- 4 = HD         (1366x768 @ 60 Hz) 85.5 855 24b
-- 5 = WXGA       (1280x800 @ 60 Hz) 71   710 24b	
-- 6 = HDTV 720p  (1280x720 @ 60 Hz) 74.25 742.5 24b
-- 7 = HDTV 1080i (1920x1080 @ 60 Hz interlaced) 74.25 742.5 24b
-- 8 = SXGA       (1280x1024 @ 60 Hz) 108 1080 24b
);
port (
	clk_in			: in  STD_LOGIC;
	pclk1x			: out STD_LOGIC;
	pclk5x			: out STD_LOGIC;
	lock			: out STD_LOGIC
);
end clock_system;
-------------------------------------------------------------------------------
architecture Behavioral of clock_system is
-------------------------------------------------------------------------------
-- Constants
constant net_gnd			: STD_LOGIC := '0';
constant net_vcc			: STD_LOGIC := '1';
-- Clock system
signal clkfbout				: STD_LOGIC;
signal pllclk5x_pll			: STD_LOGIC;
signal pllclk5x_pll_g		: STD_LOGIC;
signal pllclk1x_pll			: STD_LOGIC;
-------------------------------------------------------------------------------
begin
-------------------------------------------------------------------------------
VGA_gen: if C_VIDEO_MODE = 0 generate
begin
pll_inst: PLL_BASE
generic map(
	CLKIN_PERIOD		=> 40.0,
	CLKFBOUT_MULT		=> 20,	-- x10 clock
	CLKOUT0_DIVIDE		=> 4,	-- x5 clock
	CLKOUT1_DIVIDE		=> 20,	-- x1 clock
	COMPENSATION		=> "INTERNAL"
) 
port map (
	CLKFBOUT			=> clkfbout,
	CLKOUT0				=> pllclk5x_pll,
	CLKOUT1				=> pllclk1x_pll,
	CLKOUT2				=> open,
	CLKOUT3				=> open,
	CLKOUT4				=> open,
	CLKOUT5				=> open,
	LOCKED				=> lock,
	CLKFBIN				=> clkfbout,
	CLKIN				=> clk_in,
	RST					=> net_gnd
);	
end generate;
-------------------------------------------------------------------------------
m480p_gen: if C_VIDEO_MODE = 1 generate
begin
pll_inst: PLL_BASE
generic map(
	CLKIN_PERIOD		=> 37.037,
	CLKFBOUT_MULT		=> 20,	-- x10 clock
	CLKOUT0_DIVIDE		=> 4,	-- x5 clock
	CLKOUT1_DIVIDE		=> 20,	-- x1 clock
	COMPENSATION		=> "INTERNAL"
) 
port map (
	CLKFBOUT			=> clkfbout,
	CLKOUT0				=> pllclk5x_pll,
	CLKOUT1				=> pllclk1x_pll,
	CLKOUT2				=> open,
	CLKOUT3				=> open,
	CLKOUT4				=> open,
	CLKOUT5				=> open,
	LOCKED				=> lock,
	CLKFBIN				=> clkfbout,
	CLKIN				=> clk_in,
	RST					=> net_gnd
);	
end generate;
-------------------------------------------------------------------------------
SVGA_gen: if C_VIDEO_MODE = 2 generate
begin
pll_inst: PLL_BASE
generic map(
	CLKIN_PERIOD		=> 25.0,
	CLKFBOUT_MULT		=> 20,	-- x10 clock
	CLKOUT0_DIVIDE		=> 4,	-- x5 clock
	CLKOUT1_DIVIDE		=> 20,	-- x1 clock
	COMPENSATION		=> "INTERNAL"
) 
port map (
	CLKFBOUT			=> clkfbout,
	CLKOUT0				=> pllclk5x_pll,
	CLKOUT1				=> pllclk1x_pll,
	CLKOUT2				=> open,
	CLKOUT3				=> open,
	CLKOUT4				=> open,
	CLKOUT5				=> open,
	LOCKED				=> lock,
	CLKFBIN				=> clkfbout,
	CLKIN				=> clk_in,
	RST					=> net_gnd
);	
end generate;
-------------------------------------------------------------------------------
XGA_gen: if C_VIDEO_MODE = 3 generate
begin
pll_inst: PLL_BASE
generic map(
	CLKIN_PERIOD		=> 15.3846,
	CLKFBOUT_MULT		=> 10,	-- x10 clock
	CLKOUT0_DIVIDE		=> 2,	-- x5 clock
	CLKOUT1_DIVIDE		=> 10,	-- x1 clock
	COMPENSATION		=> "INTERNAL"
) 
port map (
	CLKFBOUT			=> clkfbout,
	CLKOUT0				=> pllclk5x_pll,
	CLKOUT1				=> pllclk1x_pll,
	CLKOUT2				=> open,
	CLKOUT3				=> open,
	CLKOUT4				=> open,
	CLKOUT5				=> open,
	LOCKED				=> lock,
	CLKFBIN				=> clkfbout,
	CLKIN				=> clk_in,
	RST					=> net_gnd
);	
end generate;
-------------------------------------------------------------------------------
HD_gen: if C_VIDEO_MODE = 4 generate
begin
pll_inst: PLL_BASE
generic map(
	CLKIN_PERIOD		=> 11.6959,
	CLKFBOUT_MULT		=> 10,	-- x10 clock
	CLKOUT0_DIVIDE		=> 2,	-- x5 clock
	CLKOUT1_DIVIDE		=> 10,	-- x1 clock
	COMPENSATION		=> "INTERNAL"
) 
port map (
	CLKFBOUT			=> clkfbout,
	CLKOUT0				=> pllclk5x_pll,
	CLKOUT1				=> pllclk1x_pll,
	CLKOUT2				=> open,
	CLKOUT3				=> open,
	CLKOUT4				=> open,
	CLKOUT5				=> open,
	LOCKED				=> lock,
	CLKFBIN				=> clkfbout,
	CLKIN				=> clk_in,
	RST					=> net_gnd
);	
end generate;
-------------------------------------------------------------------------------
WXGA_gen: if C_VIDEO_MODE = 5 generate
begin
pll_inst: PLL_BASE
generic map(
	CLKIN_PERIOD		=> 14.0845,
	CLKFBOUT_MULT		=> 10,	-- x10 clock
	CLKOUT0_DIVIDE		=> 2,	-- x5 clock
	CLKOUT1_DIVIDE		=> 10,	-- x1 clock
	COMPENSATION		=> "INTERNAL"
) 
port map (
	CLKFBOUT			=> clkfbout,
	CLKOUT0				=> pllclk5x_pll,
	CLKOUT1				=> pllclk1x_pll,
	CLKOUT2				=> open,
	CLKOUT3				=> open,
	CLKOUT4				=> open,
	CLKOUT5				=> open,
	LOCKED				=> lock,
	CLKFBIN				=> clkfbout,
	CLKIN				=> clk_in,
	RST					=> net_gnd
);	
end generate;
-------------------------------------------------------------------------------
HDTV_720p_gen: if C_VIDEO_MODE = 6 generate
begin
pll_inst: PLL_BASE
generic map(
	CLKIN_PERIOD		=> 13.468,
	CLKFBOUT_MULT		=> 10,	-- x10 clock
	CLKOUT0_DIVIDE		=> 2,	-- x5 clock
	CLKOUT1_DIVIDE		=> 10,	-- x1 clock
	COMPENSATION		=> "INTERNAL"
) 
port map (
	CLKFBOUT			=> clkfbout,
	CLKOUT0				=> pllclk5x_pll,
	CLKOUT1				=> pllclk1x_pll,
	CLKOUT2				=> open,
	CLKOUT3				=> open,
	CLKOUT4				=> open,
	CLKOUT5				=> open,
	LOCKED				=> lock,
	CLKFBIN				=> clkfbout,
	CLKIN				=> clk_in,
	RST					=> net_gnd
);	
end generate;
-------------------------------------------------------------------------------
HDTV_1080p_gen: if C_VIDEO_MODE = 7 generate
begin
pll_inst: PLL_BASE
generic map(
	CLKIN_PERIOD		=> 13.468,
	CLKFBOUT_MULT		=> 10,	-- x10 clock
	CLKOUT0_DIVIDE		=> 2,	-- x5 clock
	CLKOUT1_DIVIDE		=> 10,	-- x1 clock
	COMPENSATION		=> "INTERNAL"
) 
port map (
	CLKFBOUT			=> clkfbout,
	CLKOUT0				=> pllclk5x_pll,
	CLKOUT1				=> pllclk1x_pll,
	CLKOUT2				=> open,
	CLKOUT3				=> open,
	CLKOUT4				=> open,
	CLKOUT5				=> open,
	LOCKED				=> lock,
	CLKFBIN				=> clkfbout,
	CLKIN				=> clk_in,
	RST					=> net_gnd
);	
end generate;
-------------------------------------------------------------------------------
SXGA_gen: if C_VIDEO_MODE = 8 generate
begin
pll_inst: PLL_BASE
generic map(
	CLKIN_PERIOD		=> 9.2592,
	CLKFBOUT_MULT		=> 10,	-- x10 clock
	CLKOUT0_DIVIDE		=> 2,	-- x5 clock
	CLKOUT1_DIVIDE		=> 10,	-- x1 clock
	COMPENSATION		=> "INTERNAL"
) 
port map (
	CLKFBOUT			=> clkfbout,
	CLKOUT0				=> pllclk5x_pll,
	CLKOUT1				=> pllclk1x_pll,
	CLKOUT2				=> open,
	CLKOUT3				=> open,
	CLKOUT4				=> open,
	CLKOUT5				=> open,
	LOCKED				=> lock,
	CLKFBIN				=> clkfbout,
	CLKIN				=> clk_in,
	RST					=> net_gnd
);	
end generate;
-------------------------------------------------------------------------------
dclk_BUFIO_inst : BUFIO
port map  (
	I 					=> pllclk5x_pll, 
	O 					=> pclk5x
);

out_clk_BUFG_inst : BUFG 	
port map  (
	I 					=> pllclk1x_pll, 
	O 					=> pclk1x
);
--------------------------------------------------------------------------------
end Behavioral;
