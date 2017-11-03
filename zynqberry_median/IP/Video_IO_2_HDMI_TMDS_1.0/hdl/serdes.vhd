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
entity serdes is
port (
	clk_in			: in  STD_LOGIC;
	clk_dv_in		: in  STD_LOGIC;
	reset_in		: in  STD_LOGIC;
	data_in			: in  STD_LOGIC_VECTOR(4 downto 0);
	data_out		: out STD_LOGIC
);
end serdes;
-------------------------------------------------------------------------------
architecture Behavioral of serdes is
-------------------------------------------------------------------------------
-- Constants
constant net_gnd			: STD_LOGIC := '0';
constant net_vcc			: STD_LOGIC := '1';
-------------------------------------------------------------------------------
begin
-------------------------------------------------------------------------------
OSERDESE2_inst : OSERDESE2
generic map (
	DATA_RATE_OQ	=> "SDR", -- "SDR" or "DDR"
	DATA_RATE_TQ	=> "SDR", -- "BUF", "SDR" or "DDR"
	-- DATA_RATE_OQ	=> "DDR", -- "SDR" or "DDR"
	-- DATA_RATE_TQ	=> "DDR", -- "BUF", "SDR" or "DDR"
	DATA_WIDTH 		=> 5, -- Parallel data width (2-8,10)
	INIT_OQ 		=> '0', -- Initial value of OQ output (0/1)
	INIT_TQ 		=> '0', -- Initial value of TQ output (0/1)
	SERDES_MODE		=> "MASTER", -- "MASTER" or "SLAVE"
	SRVAL_OQ		=> '0', -- OQ output value when SR is used (0/1)
	SRVAL_TQ		=> '0', -- TQ output value when SR is used (0/1)
	TBYTE_CTL		=> "FALSE", -- Enable tristate byte operation ("TRUE" or "FALSE")
	TBYTE_SRC		=> "FALSE", -- Tristate byte source ("TRUE" or "FALSE")
	TRISTATE_WIDTH	=> 1 -- 3-state converter width (1 or 4)
)
port map (
	OFB				=> open, -- 1-bit output: Feedback path for data output
	OQ				=> data_out, -- 1-bit output: Data path output
	-- SHIFTOUT1/SHIFTOUT2: 1-bit (each) output: Data output expansion (1-bit each)
	SHIFTOUT1		=> open,
	SHIFTOUT2		=> open,
	TBYTEOUT		=> open, -- 1-bit output: Byte group tristate output
	TFB				=> open, -- 1-bit output: 3-state control output
	TQ				=> open, -- 1-bit output: 3-state control output
	CLK				=> clk_in, -- 1-bit input: High speed clock input
	CLKDIV			=> clk_dv_in, -- 1-bit input: Divided clock input
	-- D1 - D8: 1-bit (each) input: Parallel data inputs (1-bit each)
	D1				=> data_in(0),
	D2 				=> data_in(1),
	D3 				=> data_in(2),
	D4 				=> data_in(3),
	D5 				=> data_in(4),
	D6 				=> net_gnd,
	D7 				=> net_gnd,
	D8 				=> net_gnd,
	OCE				=> net_vcc, -- 1-bit input: Output data clock enable input
	RST 			=> reset_in, -- 1-bit input: Reset input
	-- SHIFTIN1/SHIFTIN2: 1-bit (each) input: Data input expansion (1-bit each)
	SHIFTIN1		=> net_gnd,
	SHIFTIN2 		=> net_gnd,
	-- T1 - T4: 1-bit (each) input: Parallel 3-state inputs
	T1 				=> net_gnd,
	T2 				=> net_gnd,
	T3 				=> net_gnd,
	T4 				=> net_gnd,
	TBYTEIN 		=> net_gnd, -- 1-bit input: Byte group tristate input
	TCE 			=> net_gnd -- 1-bit input: 3-state clock enable input
);
--------------------------------------------------------------------------------
end Behavioral;
