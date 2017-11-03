-------------------------------------------------------------------------------
-- Company: 		Trenz Electronic
-- Engineer: 		Oleksandr Kiyenko
--
-- SRL based FWPT FIFO
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;
library UNISIM;
use UNISIM.VComponents.all;
-------------------------------------------------------------------------------
entity srl_fifo is
generic(
	C_DEPTH					: integer := 32;
	C_WIDTH					: integer := 8
);
port (
	clk_in					: in  STD_LOGIC;
	we_in					: in  STD_LOGIC;
	re_in					: in  STD_LOGIC;
	full_out				: out STD_LOGIC;
	empty_out				: out STD_LOGIC;
	data_in					: in  STD_LOGIC_VECTOR(C_WIDTH - 1 downto 0);
	data_out				: out STD_LOGIC_VECTOR(C_WIDTH - 1 downto 0)
);
end srl_fifo;
-------------------------------------------------------------------------------
architecture Behavioral of srl_fifo is
-------------------------------------------------------------------------------
type arr_type is array(C_DEPTH/32 downto 0) of STD_LOGIC_VECTOR(C_WIDTH - 1 downto 0);
signal ddata		: arr_type;
type arrp_type is array(C_DEPTH/32+1 downto 0) of STD_LOGIC_VECTOR(C_WIDTH - 1 downto 0);
signal cdata		: arrp_type;
signal word_cnt		: UNSIGNED(5 downto 0);
signal addr_cnt		: UNSIGNED(4 downto 0);
signal srl_addr		: STD_LOGIC_VECTOR(4 downto 0);
signal srl_ce		: STD_LOGIC;
type fifo_state_type is (ST_EMPTY, ST_NOT_EMPTY, ST_FULL);
signal fifo_state	: fifo_state_type := ST_EMPTY;
-------------------------------------------------------------------------------
begin
-------------------------------------------------------------------------------
cdata(0)	<= data_in;
width_gen: for i in C_WIDTH - 1 downto 0 generate
begin
	depth_gen: for j in C_DEPTH/32 downto 0 generate
	begin
		SRLC32E_1 : SRLC32E
		port map (
			D   => cdata(j)(i),
			Q   => ddata(j)(i),
			Q31 => cdata(j+1)(i),
			A   => srl_addr(4 downto 0),
			CE  => srl_ce,
			CLK => clk_in
		);
	end generate;
end generate;
srl_addr	<= STD_LOGIC_VECTOR(addr_cnt);

full_out	<= '1' when (fifo_state = ST_FULL ) else '0';
empty_out	<= '1' when (fifo_state = ST_EMPTY) else '0';
srl_ce		<= '1' when ((we_in = '1') and ((fifo_state /= ST_FULL) or (re_in = '1'))) else '0';

single_stage_gen: if C_DEPTH = 32 generate
begin
	data_out	<= ddata(0);
end generate;
-- multi_stage_gen: if C_DEPTH > 32 generate
-- begin
	-- data_out	<= ddata(TO_INTEGER(addr_cnt(addr_cnt'high downto 5)));
-- end generate;

process(clk_in)
begin
	if(clk_in = '1' and clk_in'event)then
		case fifo_state is
			when ST_EMPTY		=>
				if(we_in = '1')then
					word_cnt	<= word_cnt + 1;
					fifo_state	<= ST_NOT_EMPTY;
				end if;
			when ST_NOT_EMPTY	=>
				if(we_in = '1')then
					if(re_in = '0')then	-- Write
						if(word_cnt = TO_UNSIGNED((C_DEPTH-1), word_cnt'width))then
							fifo_state	<= ST_FULL;
						end if;
						word_cnt	<= word_cnt + 1;
						addr_cnt	<= addr_cnt + 1;
					end if;
				elsif(re_in = '1')then
					if(word_cnt = TO_UNSIGNED(1, word_cnt'width))then
						fifo_state	<= ST_EMPTY;
						word_cnt	<= word_cnt - 1;
					else
						word_cnt	<= word_cnt - 1;
						addr_cnt	<= addr_cnt - 1;
					end if;
				end if;
			when ST_FULL =>
				if((re_in = '1') and (we_in = '0'))then
					word_cnt		<= word_cnt - 1;
					addr_cnt		<= addr_cnt - 1;
				end if;
		end case;
	end if;
end process;
-------------------------------------------------------------------------------
end Behavioral;
