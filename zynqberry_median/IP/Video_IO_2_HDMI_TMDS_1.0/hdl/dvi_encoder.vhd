----------------------------------------------------------------------------------
-- Company: Trenz Electronic GmbH
-- Engineer: Oleksandr Kiyenko
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;
----------------------------------------------------------------------------------
entity dvi_encoder is
port (
	clkin			: in  STD_LOGIC;					-- pixel clock
	rstin			: in  STD_LOGIC;          			-- reset
	blue_din		: in  STD_LOGIC_VECTOR(7 downto 0); -- Blue data in
	green_din		: in  STD_LOGIC_VECTOR(7 downto 0); -- Green data in
	red_din			: in  STD_LOGIC_VECTOR(7 downto 0); -- Red data in
	hsync			: in  STD_LOGIC;          			-- hsync data
	vsync			: in  STD_LOGIC;          			-- vsync data
	de				: in  STD_LOGIC;            		-- data enable
	blue_dout		: out STD_LOGIC_VECTOR(9 downto 0);
	green_dout		: out STD_LOGIC_VECTOR(9 downto 0);
	red_dout		: out STD_LOGIC_VECTOR(9 downto 0)
);		
end dvi_encoder;
-------------------------------------------------------------------------------
architecture Behavioral of dvi_encoder is
-------------------------------------------------------------------------------
constant net_gnd	: STD_LOGIC := '0';
component tmds_encoder is
port (
	clk_in			: in  STD_LOGIC;
	rst_in			: in  STD_LOGIC;
	data_in			: in  STD_LOGIC_VECTOR(7 downto 0);
	c0_in			: in  STD_LOGIC;
	c1_in			: in  STD_LOGIC;
	de_in			: in  STD_LOGIC;
	data_out		: out STD_LOGIC_VECTOR(9 downto 0)
);
end component;
-------------------------------------------------------------------------------
begin
-------------------------------------------------------------------------------
encb_inst: tmds_encoder
port map(
	clk_in		=> clkin,
	rst_in		=> rstin,
	data_in		=> blue_din,
	c0_in		=> hsync,
	c1_in		=> vsync,
	de_in		=> de,
	data_out	=> blue_dout
);

encg_inst: tmds_encoder
port map(
	clk_in		=> clkin,
	rst_in		=> rstin,
	data_in		=> green_din,
	c0_in		=> net_gnd,
	c1_in		=> net_gnd,
	de_in		=> de,
	data_out	=> green_dout
);
	
encr_inst: tmds_encoder 
port map(
	clk_in		=> clkin,
	rst_in		=> rstin,
	data_in		=> red_din,
	c0_in		=> net_gnd,
	c1_in		=> net_gnd,
	de_in		=> de,
	data_out	=> red_dout
);
--------------------------------------------------------------------------------
end Behavioral;
