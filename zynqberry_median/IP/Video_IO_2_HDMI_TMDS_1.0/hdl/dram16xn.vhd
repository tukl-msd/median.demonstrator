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
entity dram16xn is
generic(
	DATA_WIDTH		: integer	:= 20
);
port (
	clk				: in  STD_LOGIC;
	write_en		: in  STD_LOGIC;
	address			: in  STD_LOGIC_VECTOR(3 downto 0);
	address_dp		: in  STD_LOGIC_VECTOR(3 downto 0);
	data_in			: in  STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0);
	o_data_out		: out STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0);
	o_data_out_dp	: out STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0)
);		
end dram16xn;
-------------------------------------------------------------------------------
architecture Behavioral of dram16xn is
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
begin
-------------------------------------------------------------------------------
bit_gen: for i in 0 to DATA_WIDTH-1 generate
begin
	ram_inst: RAM16X1D
	port map(	
		D		=> data_in(i),		--insert input signal
		WE		=> write_en,		--insert Write Enable signal
		WCLK	=> clk,				--insert Write Clock signal
		A0		=> address(0),		 --insert Address 0 signal port SPO
		A1		=> address(1),		 --insert Address 1 signal port SPO
		A2		=> address(2),		 --insert Address 2 signal port SPO
		A3		=> address(3),		 --insert Address 3 signal port SPO
		DPRA0	=> address_dp(0), --insert Address 0 signal dual port DPO
		DPRA1	=> address_dp(1), --insert Address 1 signal dual port DPO
		DPRA2	=> address_dp(2), --insert Address 2 signal dual port DPO
		DPRA3	=> address_dp(3), --insert Address 3 signal dual port DPO
		SPO		=> o_data_out(i),	 --insert output signal SPO
		DPO		=> o_data_out_dp(i) --insert output signal DPO
	);
end generate;
--------------------------------------------------------------------------------
end Behavioral;
