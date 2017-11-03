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
entity convert_30to15_fifo is
port (
	rst			: in  STD_LOGIC;   -- reset
	clk			: in  STD_LOGIC;   -- clock input
	clkx2		: in  STD_LOGIC; -- 2x clock input
	datain		: in  STD_LOGIC_VECTOR(29 downto 0);   -- input data for 2:1 serialisation
	dataout		: out STD_LOGIC_VECTOR(14 downto 0)
);		
end convert_30to15_fifo;
-------------------------------------------------------------------------------
architecture Behavioral of convert_30to15_fifo is
-------------------------------------------------------------------------------
constant net_vcc	: STD_LOGIC := '1';

component dram16xn is
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
end component;

----------------------------------------------------
-- Here we instantiate a 16x10 Dual Port RAM
-- and fill first it with data aligned to
-- clk domain
----------------------------------------------------
signal wa		: STD_LOGIC_VECTOR( 3 downto 0);  -- RAM read address
signal wa_d		: STD_LOGIC_VECTOR( 3 downto 0);  -- RAM read address
signal ra		: STD_LOGIC_VECTOR( 3 downto 0);  -- RAM read address
signal ra_d		: STD_LOGIC_VECTOR( 3 downto 0);  -- RAM read address
signal dataint	: STD_LOGIC_VECTOR(29 downto 0);  -- RAM output

constant ADDR0 		: STD_LOGIC_VECTOR(3 downto 0) := "0000";
constant ADDR1 		: STD_LOGIC_VECTOR(3 downto 0) := "0001";
constant ADDR2 		: STD_LOGIC_VECTOR(3 downto 0) := "0010";
constant ADDR3 		: STD_LOGIC_VECTOR(3 downto 0) := "0011";
constant ADDR4 		: STD_LOGIC_VECTOR(3 downto 0) := "0100";
constant ADDR5 		: STD_LOGIC_VECTOR(3 downto 0) := "0101";
constant ADDR6 		: STD_LOGIC_VECTOR(3 downto 0) := "0110";
constant ADDR7 		: STD_LOGIC_VECTOR(3 downto 0) := "0111";
constant ADDR8 		: STD_LOGIC_VECTOR(3 downto 0) := "1000";
constant ADDR9 		: STD_LOGIC_VECTOR(3 downto 0) := "1001";
constant ADDR10		: STD_LOGIC_VECTOR(3 downto 0) := "1010";
constant ADDR11		: STD_LOGIC_VECTOR(3 downto 0) := "1011";
constant ADDR12		: STD_LOGIC_VECTOR(3 downto 0) := "1100";
constant ADDR13		: STD_LOGIC_VECTOR(3 downto 0) := "1101";
constant ADDR14		: STD_LOGIC_VECTOR(3 downto 0) := "1110";
constant ADDR15		: STD_LOGIC_VECTOR(3 downto 0) := "1111";

signal rstsync		: STD_LOGIC;
signal rstsync_q	: STD_LOGIC;
signal rstp			: STD_LOGIC;
signal sync			: STD_LOGIC;
signal db			: STD_LOGIC_VECTOR(29 downto 0);
signal mux			: STD_LOGIC_VECTOR(14 downto 0);
-------------------------------------------------------------------------------
attribute ASYNC_REG				: string;
attribute ASYNC_REG of rstsync	: signal is "true";
-------------------------------------------------------------------------------
begin
-------------------------------------------------------------------------------
process(wa)
begin
	case wa is
		when ADDR0   => wa_d <= ADDR1 ;
		when ADDR1   => wa_d <= ADDR2 ;
		when ADDR2   => wa_d <= ADDR3 ;
		when ADDR3   => wa_d <= ADDR4 ;
		when ADDR4   => wa_d <= ADDR5 ;
		when ADDR5   => wa_d <= ADDR6 ;
		when ADDR6   => wa_d <= ADDR7 ;
		when ADDR7   => wa_d <= ADDR8 ;
		when ADDR8   => wa_d <= ADDR9 ;
		when ADDR9   => wa_d <= ADDR10;
		when ADDR10  => wa_d <= ADDR11;
		when ADDR11  => wa_d <= ADDR12;
		when ADDR12  => wa_d <= ADDR13;
		when ADDR13  => wa_d <= ADDR14;
		when ADDR14  => wa_d <= ADDR15;
		when others  => wa_d <= ADDR0;
	end case;
end process;

process(clk, rst)
begin
	if(rst = '1')then
		wa	<= (others => '0');
	elsif(clk = '1' and clk'event)then
		wa	<= wa_d;
	end if;
end process;

-- Dual Port fifo to bridge data from clk to clkx2
fifo_inst: dram16xn
generic map(
	DATA_WIDTH		=> 30
)
port map(
	clk				=> clk,
	write_en		=> net_vcc,
	address			=> wa,
	address_dp		=> ra,
	data_in			=> datain,
	o_data_out		=> open,
	o_data_out_dp	=> dataint
);		

----------------------------------------------------------------/
-- Here starts clk2x domain for fifo read out 
-- FIFO read is set to be once every 2 cycles of clk2x in order
-- to keep up pace with the fifo write speed
-- Also FIFO read reset is delayed a bit in order to avoid
-- underflow.
----------------------------------------------------------------/
process(ra)
begin
	case ra is
		when ADDR0 	=> ra_d <= ADDR1 ;
		when ADDR1 	=> ra_d <= ADDR2 ;
		when ADDR2 	=> ra_d <= ADDR3 ;
		when ADDR3 	=> ra_d <= ADDR4 ;
		when ADDR4 	=> ra_d <= ADDR5 ;
		when ADDR5 	=> ra_d <= ADDR6 ;
		when ADDR6 	=> ra_d <= ADDR7 ;
		when ADDR7 	=> ra_d <= ADDR8 ;
		when ADDR8 	=> ra_d <= ADDR9 ;
		when ADDR9 	=> ra_d <= ADDR10;
		when ADDR10	=> ra_d <= ADDR11;
		when ADDR11	=> ra_d <= ADDR12;
		when ADDR12	=> ra_d <= ADDR13;
		when ADDR13	=> ra_d <= ADDR14;
		when ADDR14	=> ra_d <= ADDR15;
		when others => ra_d <= ADDR0;
	end case;
end process;

fdp_rst: FDP
port map(
	C	=> clkx2, 
	D	=> rst, 
	PRE	=> rst, 
	Q	=> rstsync
);

fd_rstsync: FD  
port map(
	C	=> clkx2,  
	D	=> rstsync, 
	Q	=> rstsync_q
);

fd_rstp: FD     
port map(
	C	=> clkx2,  
	D	=> rstsync_q, 
	Q	=> rstp
);

mux <= db(14 downto 0) when (sync = '0') else db(29 downto 15);

process(clkx2, rstp)
begin
	if(rstp = '1')then
		sync	<= '0';
		ra		<= (others => '0');
	elsif(clkx2 = '1' and clkx2'event)then
		sync		<= not sync;
		if(sync = '1')then
			ra		<= ra_d;
			db		<= dataint;
		end if;
		dataout		<= mux;
	end if;
end process;
--------------------------------------------------------------------------------
end Behavioral;
