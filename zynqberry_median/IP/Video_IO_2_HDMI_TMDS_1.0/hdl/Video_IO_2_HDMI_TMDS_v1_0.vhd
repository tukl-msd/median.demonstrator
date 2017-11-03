----------------------------------------------------------------------------------
-- Company: Trenz Electronic GmbH
-- Engineer: Oleksandr Kiyenko
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library UNISIM;
use UNISIM.VComponents.all;
----------------------------------------------------------------------------------
entity Video_IO_2_HDMI_TMDS_v1_0 is
generic (
	-- Pin swap options
	C_CLK_SWAP			: boolean	:= FALSE;
	C_D0_SWAP			: boolean	:= FALSE;
	C_D1_SWAP			: boolean	:= FALSE;
	C_D2_SWAP			: boolean	:= FALSE;
	
	-- Clocking options
	C_INT_CLOCKING		: BOOLEAN	:= TRUE;
	C_VIDEO_MODE		: integer range 0 to 8	:= 2
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
	-- Clocks
	video_clk_in		: in STD_LOGIC;		-- Main clock Input
	video_clk5x_in		: in STD_LOGIC;		-- SERDES clock Input
	lock_in				: in STD_LOGIC;		-- External PLL locking
	-- Video IO Interface
	vid_data			: in  STD_LOGIC_VECTOR(23 downto 0);
	vid_active_video	: in  STD_LOGIC;
	vid_hblank			: in  STD_LOGIC;
	vid_vblank			: in  STD_LOGIC;
	vid_hsync			: in  STD_LOGIC;
	vid_vsync			: in  STD_LOGIC;
	-- HDMI Interface
	hdmi_data_p 		: out STD_LOGIC_VECTOR(2 downto 0);
	hdmi_data_n 		: out STD_LOGIC_VECTOR(2 downto 0);
	hdmi_clk_p 			: out STD_LOGIC;
	hdmi_clk_n 			: out STD_LOGIC
);
end Video_IO_2_HDMI_TMDS_v1_0;
----------------------------------------------------------------------------------
architecture arch_imp of Video_IO_2_HDMI_TMDS_v1_0 is
----------------------------------------------------------------------------------
component clock_system is
generic(
	C_VIDEO_MODE	: integer range 0 to 9	:= 2
);
port (
	clk_in			: in  STD_LOGIC;
	pclk1x			: out STD_LOGIC;
	pclk5x			: out STD_LOGIC;
	lock			: out STD_LOGIC
);
end component;

component serdes_ddr is
port (
	clk_in			: in  STD_LOGIC;
	clk_dv_in		: in  STD_LOGIC;
	reset_in		: in  STD_LOGIC;
	data_in			: in  STD_LOGIC_VECTOR(9 downto 0);
	data_out		: out STD_LOGIC
);
end component;

component dvi_encoder is
port (
	clkin			: in  STD_LOGIC;
	rstin			: in  STD_LOGIC;
	blue_din		: in  STD_LOGIC_VECTOR(7 downto 0);
	green_din		: in  STD_LOGIC_VECTOR(7 downto 0);
	red_din			: in  STD_LOGIC_VECTOR(7 downto 0);
	hsync			: in  STD_LOGIC;
	vsync			: in  STD_LOGIC;
	de				: in  STD_LOGIC;
	blue_dout		: out STD_LOGIC_VECTOR(9 downto 0);
	green_dout		: out STD_LOGIC_VECTOR(9 downto 0);
	red_dout		: out STD_LOGIC_VECTOR(9 downto 0)
);
end component;
----------------------------------------------------------------------------------
-- Constants
constant net_gnd		: STD_LOGIC := '0';
constant net_vcc		: STD_LOGIC := '1';
-- Clock system
signal pclk5x			: STD_LOGIC;
signal pclk1x			: STD_LOGIC;
signal lock				: STD_LOGIC;
signal reset			: STD_LOGIC;
signal serdes_rst		: STD_LOGIC;
-- Video system
signal red_data			: STD_LOGIC_VECTOR(7 downto 0);
signal green_data		: STD_LOGIC_VECTOR(7 downto 0);
signal blue_data		: STD_LOGIC_VECTOR(7 downto 0);
type s_data_type is array (5 downto 0) of STD_LOGIC_VECTOR(9 downto 0);
signal s_data_r			: s_data_type;
signal s_data_o			: s_data_type;
signal tmds_out			: STD_LOGIC_VECTOR(3 downto 0);
----------------------------------------------------------------------------------
begin
----------------------------------------------------------------------------------
int_clock_sys: if C_INT_CLOCKING = TRUE generate
begin
	-- Clock system
	clock_system_inst: clock_system
	generic map(
		C_VIDEO_MODE		=> C_VIDEO_MODE
	)
	port map(
		clk_in				=> video_clk_in,
		pclk1x				=> pclk1x,
		pclk5x				=> pclk5x,
		lock				=> lock
	);
end generate;
ext_clock_sys: if C_INT_CLOCKING = FALSE generate
begin
	lock				<= lock_in;
	pclk1x				<= video_clk_in;
	pclk5x				<= video_clk5x_in;
end generate;
----------------------------------------------------------------------------------
serdes_rst				<= not lock;
reset					<= net_gnd;
----------------------------------------------------------------------------------
-- Video system
red_data				<= vid_data(23 downto 16);
green_data				<= vid_data( 7 downto  0); 
blue_data				<= vid_data(15 downto  8);
-- Encoder
enc_inst: dvi_encoder
port map(
	clkin	 			=> pclk1x,
	rstin				=> reset,
	blue_din			=> blue_data,
	green_din			=> green_data,
	red_din				=> red_data,
	hsync				=> vid_hsync,
	vsync				=> vid_vsync,
	de					=> vid_active_video,
	blue_dout			=> s_data_r(0),
	green_dout			=> s_data_r(1),
	red_dout			=> s_data_r(2)
);
-- HDMI Clock generation
s_data_r(3)				<= b"11111_00000";
----------------------------------------------------------------------------------
-- Bitswap 
----------------------------------------------------------------------------------
d0_direct: if C_D0_SWAP = FALSE generate
	s_data_o(0)			<= s_data_r(0);
end generate;
d0_inv: if C_D0_SWAP = TRUE generate
	s_data_o(0)			<= not s_data_r(0);
end generate;

d1_direct: if C_D1_SWAP = FALSE generate
	s_data_o(1)			<= s_data_r(1);
end generate;
d1_inv: if C_D1_SWAP = TRUE generate
	s_data_o(1)			<= not s_data_r(1);
end generate;

d2_direct: if C_D2_SWAP = FALSE generate
	s_data_o(2)			<= s_data_r(2);
end generate;
d2_inv: if C_D2_SWAP = TRUE generate
	s_data_o(2)			<= not s_data_r(2);
end generate;

clk_direct: if C_CLK_SWAP = FALSE generate
	s_data_o(3)			<= s_data_r(3);
end generate;
clk_inv: if C_CLK_SWAP = TRUE generate
	s_data_o(3)			<= not s_data_r(3);
end generate;
----------------------------------------------------------------------------------
-- Serdes
----------------------------------------------------------------------------------
HDMI_ddr_lines_gen: for i in 0 to 3 generate
begin
	serdes_ddr_inst: serdes_ddr
	port map(
		clk_in			=> pclk5x,
		clk_dv_in		=> pclk1x,
		reset_in		=> serdes_rst,
		data_in			=> s_data_o(i),
		data_out		=> tmds_out(i)
	);
end generate;
----------------------------------------------------------------------------------
-- Output buffers
----------------------------------------------------------------------------------
obufds_d0_inst: OBUFDS
port map(
	I					=> tmds_out(0),
	O					=> hdmi_data_p(0),
	OB					=> hdmi_data_n(0)
);
obufds_d1_inst: OBUFDS
port map(
	I					=> tmds_out(1),
	O					=> hdmi_data_p(1),
	OB					=> hdmi_data_n(1)
);
obufds_d2_inst: OBUFDS
port map(
	I					=> tmds_out(2),
	O					=> hdmi_data_p(2),
	OB					=> hdmi_data_n(2)
);
obufds_clk_inst: OBUFDS
port map(
	I					=> tmds_out(3),
	O					=> hdmi_clk_p,
	OB					=> hdmi_clk_n
);
----------------------------------------------------------------------------------
end arch_imp;
