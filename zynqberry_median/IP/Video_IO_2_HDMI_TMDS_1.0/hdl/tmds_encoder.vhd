----------------------------------------------------------------------------------
-- Company: Trenz Electronic GmbH
-- Engineer: Oleksandr Kiyenko
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;
----------------------------------------------------------------------------------
entity tmds_encoder is
port (
	clk_in			: in  STD_LOGIC;
	rst_in			: in  STD_LOGIC;
	data_in			: in  STD_LOGIC_VECTOR(7 downto 0);
	c0_in			: in  STD_LOGIC;
	c1_in			: in  STD_LOGIC;
	de_in			: in  STD_LOGIC;
	data_out		: out STD_LOGIC_VECTOR(9 downto 0)
);
end tmds_encoder;
-------------------------------------------------------------------------------
architecture Behavioral of tmds_encoder is
-------------------------------------------------------------------------------
signal n1d			: UNSIGNED(3 downto 0); -- number of 1s in din
signal din_q		: STD_LOGIC_VECTOR(7 downto 0);
signal decision_a	: STD_LOGIC;
signal decision_b	: STD_LOGIC;
signal decision_c	: STD_LOGIC;
signal q_m			: STD_LOGIC_VECTOR(8 downto 0);
signal n1q_m		: UNSIGNED(3 downto 0); -- number of 1s and 0s for q_m
signal n0q_m		: UNSIGNED(3 downto 0);
signal cnt			: UNSIGNED(4 downto 0); -- disparity counter, MSB is the sign bit

constant CTRLTOKEN0	: STD_LOGIC_VECTOR(9 downto 0) := b"1101010100";
constant CTRLTOKEN1 : STD_LOGIC_VECTOR(9 downto 0) := b"0010101011";
constant CTRLTOKEN2 : STD_LOGIC_VECTOR(9 downto 0) := b"0101010100";
constant CTRLTOKEN3 : STD_LOGIC_VECTOR(9 downto 0) := b"1010101011";

signal de_q			: STD_LOGIC;
signal de_reg		: STD_LOGIC;
signal c0_q			: STD_LOGIC;
signal c1_q			: STD_LOGIC;
signal c_reg		: STD_LOGIC_VECTOR(1 downto 0);
signal q_m_reg		: STD_LOGIC_VECTOR(8 downto 0);
-------------------------------------------------------------------------------
begin
-------------------------------------------------------------------------------
process(clk_in)
begin
	if(clk_in = '1' and clk_in'event)then
		n1d		<= 
			resize(UNSIGNED(data_in(0 downto 0)),4) + 
			resize(UNSIGNED(data_in(1 downto 1)),4) + 
			resize(UNSIGNED(data_in(2 downto 2)),4) + 
			resize(UNSIGNED(data_in(3 downto 3)),4) + 
			resize(UNSIGNED(data_in(4 downto 4)),4) + 
			resize(UNSIGNED(data_in(5 downto 5)),4) + 
			resize(UNSIGNED(data_in(6 downto 6)),4) + 
			resize(UNSIGNED(data_in(7 downto 7)),4);
		din_q	<= data_in;
	end if;
end process;

--assign decision1 = (n1d > 4'h4) | ((n1d == 4'h4) & (din_q(0] == 1'b0));
decision_a	<= '1' when ((n1d > to_unsigned(4,4)) or ((n1d = to_unsigned(4,4)) and (din_q(0) = '0'))) else '0';

q_m(0) <= din_q(0);
q_m(1) <= (q_m(0) xnor din_q(1)) when (decision_a = '1') else (q_m(0) xor din_q(1));
q_m(2) <= (q_m(1) xnor din_q(2)) when (decision_a = '1') else (q_m(1) xor din_q(2));
q_m(3) <= (q_m(2) xnor din_q(3)) when (decision_a = '1') else (q_m(2) xor din_q(3));
q_m(4) <= (q_m(3) xnor din_q(4)) when (decision_a = '1') else (q_m(3) xor din_q(4));
q_m(5) <= (q_m(4) xnor din_q(5)) when (decision_a = '1') else (q_m(4) xor din_q(5));
q_m(6) <= (q_m(5) xnor din_q(6)) when (decision_a = '1') else (q_m(5) xor din_q(6));
q_m(7) <= (q_m(6) xnor din_q(7)) when (decision_a = '1') else (q_m(6) xor din_q(7));
q_m(8) <= '0' when (decision_a = '1') else '1';
-------------------------------------------------------------------------------
-- Stage 2: 9 bit -> 10 bit
-- Refer to DVI 1.0 Specification, page 29, Figure 3-5
-------------------------------------------------------------------------------
process(clk_in)
begin
	if(clk_in = '1' and clk_in'event)then
		n1q_m  <=
			resize(UNSIGNED(q_m(0 downto 0)),4) + 
			resize(UNSIGNED(q_m(1 downto 1)),4) + 
			resize(UNSIGNED(q_m(2 downto 2)),4) + 
			resize(UNSIGNED(q_m(3 downto 3)),4) + 
			resize(UNSIGNED(q_m(4 downto 4)),4) + 
			resize(UNSIGNED(q_m(5 downto 5)),4) + 
			resize(UNSIGNED(q_m(6 downto 6)),4) + 
			resize(UNSIGNED(q_m(7 downto 7)),4);
		n0q_m  <=
			to_unsigned(8,4) - (
			resize(UNSIGNED(q_m(0 downto 0)),4) + 
			resize(UNSIGNED(q_m(1 downto 1)),4) + 
			resize(UNSIGNED(q_m(2 downto 2)),4) + 
			resize(UNSIGNED(q_m(3 downto 3)),4) + 
			resize(UNSIGNED(q_m(4 downto 4)),4) + 
			resize(UNSIGNED(q_m(5 downto 5)),4) + 
			resize(UNSIGNED(q_m(6 downto 6)),4) + 
			resize(UNSIGNED(q_m(7 downto 7)),4));
	end if;
end process;

decision_b <= '1' when ((cnt = to_unsigned(0,5)) or (n1q_m = n0q_m)) else '0';
-------------------------------------------------------------------------------
-- [(cnt > 0) and (N1q_m > N0q_m)] or [(cnt < 0) and (N0q_m > N1q_m)]
-------------------------------------------------------------------------------
decision_c <= '1' when ((cnt(4) = '0') and (n1q_m > n0q_m)) or ((cnt(4) = '1') and (n0q_m > n1q_m)) else '0';
-------------------------------------------------------------------------------
-- pipe line alignment
-------------------------------------------------------------------------------
process(clk_in)
begin
	if(clk_in = '1' and clk_in'event)then
		de_q	<= de_in;
		de_reg	<= de_q;
		c0_q	<= c0_in;
		c1_q	<= c1_in;
		q_m_reg	<= q_m;
		c_reg	<= c1_q & c0_q;
	end if;
end process;
-------------------------------------------------------------------------------
-- 10-bit out
-- disparity counter
-------------------------------------------------------------------------------
process(clk_in, rst_in)
begin
	if(rst_in = '1')then
		data_out	<= (others => '0');
		cnt			<= (others => '0');
	elsif(clk_in = '1' and clk_in'event)then
		if(de_reg = '1')then
			if(decision_b = '1')then
				data_out(9)				<= not q_m_reg(8); 
				data_out(8)				<= q_m_reg(8);
				if(q_m_reg(8) = '1')then
					data_out(7 downto 0)	<= q_m_reg(7 downto 0);
				else
					data_out(7 downto 0)	<= not q_m_reg(7 downto 0);
				end if;
				if(q_m_reg(8) = '0')then
					cnt		<= cnt + resize(n0q_m,5) - resize(n1q_m,5);
				else
					cnt		<= cnt + resize(n1q_m,5) - resize(n0q_m,5); 
				end if;
			else
				if(decision_c = '1')then
					data_out(9)				<= '1';
					data_out(8)				<= q_m_reg(8);
					data_out(7 downto 0)	<= not q_m_reg(7 downto 0);
					if(q_m_reg(8) = '1')then
						cnt					<= cnt + to_unsigned(2,5) + (resize(n0q_m,5) - resize(n1q_m,5));
					else
						cnt					<= cnt + (resize(n0q_m,5) - resize(n1q_m,5));
					end if;
				else
					data_out(9)				<= '0';
					data_out(8)				<= q_m_reg(8);
					data_out(7 downto 0)	<= q_m_reg(7 downto 0);
					if(q_m_reg(8) = '0')then
						cnt					<= cnt - to_unsigned(2,5) + (resize(n1q_m,5) - resize(n0q_m,5));
					else
						cnt					<= cnt + (resize(n1q_m,5) - resize(n0q_m,5));
					end if;
				end if;
			end if;
		else
			case(c_reg)is
				when "00"	=> data_out <= CTRLTOKEN0;
				when "01"	=> data_out <= CTRLTOKEN1;
				when "10"	=> data_out <= CTRLTOKEN2;
				when others	=> data_out <= CTRLTOKEN3;
			end case;
			cnt <= (others => '0');
		end if;
	end if;
end process;
--------------------------------------------------------------------------------
end Behavioral;
