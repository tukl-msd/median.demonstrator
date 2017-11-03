----------------------------------------------------------------------------------
-- Company: Trenz Electronic GmbH
-- Engineer: Oleksandr Kiyenko
----------------------------------------------------------------------------------
library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
Library UNISIM;
use UNISIM.vcomponents.all;
Library UNIMACRO;
use UNIMACRO.vcomponents.all;
----------------------------------------------------------------------------------
entity axis_raw_unpack_v1_0 is
generic (
	C_IMP_TYPE				: integer range 0 to 1	:= 0;
	C_OUT_TYPE				: integer range 1 to 4	:= 4
);
port (
	axis_aclk				: in  STD_LOGIC;
	axis_aresetn			: in  STD_LOGIC;
	-- Ports of Axi Slave Bus Interface S_AXIS
	s_axis_tready			: out STD_LOGIC;
	s_axis_tdata			: in  STD_LOGIC_VECTOR(15 downto 0);
	s_axis_tuser			: in  STD_LOGIC;
	s_axis_tlast			: in  STD_LOGIC;
	s_axis_tvalid			: in  STD_LOGIC;
	-- Ports of Axi Master Bus Interface M_AXIS
	m_axis_tvalid			: out STD_LOGIC;
	m_axis_tdata			: out STD_LOGIC_VECTOR(C_OUT_TYPE*16-1 downto 0);
	m_axis_tuser			: out STD_LOGIC;
	m_axis_tlast			: out STD_LOGIC;
	m_axis_tready			: in  STD_LOGIC
);
end axis_raw_unpack_v1_0;
----------------------------------------------------------------------------------
architecture arch_imp of axis_raw_unpack_v1_0 is
----------------------------------------------------------------------------------
constant C_DEVICE			: STRING		:= "7SERIES";
constant C_FIFO_SIZE		: STRING		:= "18Kb";
type sm_rx_state_type is (ST_IDLE, ST_PA, ST_PB, ST_PC, ST_PD);
signal sm_rx_state			: sm_rx_state_type	:= ST_IDLE;
type sm_tx_state_type is (ST_WAIT, ST_TXA, ST_TXB, ST_TXC, ST_TXD);
signal sm_tx_state			: sm_tx_state_type	:= ST_WAIT;
type sm_rxp_state_type is (ST_PIDLE, ST_PPA, ST_PPB, ST_PPC, ST_PPD, ST_PPW);
signal sm_rxp_state			: sm_rxp_state_type	:= ST_PIDLE;

signal pixels_data			: STD_LOGIC_VECTOR(39 downto 0);
signal last					: STD_LOGIC;
signal user					: STD_LOGIC;
signal pixel_a				: STD_LOGIC_VECTOR(9 downto 0);
signal pixel_b				: STD_LOGIC_VECTOR(9 downto 0);
signal pixel_c				: STD_LOGIC_VECTOR(9 downto 0);
signal pixel_d				: STD_LOGIC_VECTOR(9 downto 0);
signal pixels_valid			: STD_LOGIC;
signal buffer_we			: STD_LOGIC;
signal buffer_re			: STD_LOGIC;
signal buffer_full			: STD_LOGIC;
signal buffer_empty			: STD_LOGIC;
signal buffer_in_data		: STD_LOGIC_VECTOR(41 downto 0);
signal buffer_out_data		: STD_LOGIC_VECTOR(41 downto 0);

component srl_fifo is
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
end component;
----------------------------------------------------------------------------------
begin
----------------------------------------------------------------------------------
-- 16 bit input implementation
process(axis_aclk)
begin
	if(axis_aclk = '1' and axis_aclk'event)then
		case sm_rx_state is
			when ST_IDLE =>
				buffer_we						<= '0';
				if(s_axis_tvalid = '1')then
					pixels_data( 9 downto  2)	<= s_axis_tdata( 7 downto 0);	-- P0
					pixels_data(19 downto 12)	<= s_axis_tdata(15 downto 8);	-- P1
					user						<= s_axis_tuser;
					if(s_axis_tlast /= '1')then
						sm_rx_state				<= ST_PA;
					end if;
				end if;
				
			when ST_PA	=>
				buffer_we						<= '0';
				if(s_axis_tvalid = '1')then
					pixels_data(29 downto 22)	<= s_axis_tdata( 7 downto 0);	-- P2
					pixels_data(39 downto 32)	<= s_axis_tdata(15 downto 8);	-- P3
					if(s_axis_tuser = '1')then	-- Problem
						sm_rx_state				<= ST_PA;
					elsif(s_axis_tlast /= '1')then
						sm_rx_state				<= ST_PB;
					else
						sm_rx_state				<= ST_IDLE;
					end if;
				end if;
				
			when ST_PB =>
				if((s_axis_tvalid = '1') and (buffer_full = '0'))then
					pixel_a( 9 downto  2)		<= pixels_data( 9 downto  2);
					pixel_a( 1 downto  0)		<= s_axis_tdata( 1 downto 0);
					pixel_b( 9 downto  2)		<= pixels_data(19 downto 12);
					pixel_b( 1 downto  0)		<= s_axis_tdata( 3 downto 2);
					pixel_c( 9 downto  2)		<= pixels_data(29 downto 22);
					pixel_c( 1 downto  0)		<= s_axis_tdata( 5 downto 4);
					pixel_d( 9 downto  2)		<= pixels_data(39 downto 32);
					pixel_d( 1 downto  0)		<= s_axis_tdata( 7 downto 6);
					last						<= s_axis_tlast;
					buffer_we					<= '1';
					pixels_data( 9 downto  2)	<= s_axis_tdata(15 downto 8);
					if(s_axis_tuser = '1')then	-- Problem
						sm_rx_state				<= ST_PA;
					elsif(s_axis_tlast /= '1')then
						sm_rx_state				<= ST_PC;
					else
						sm_rx_state				<= ST_IDLE;
					end if;
				end if;
				
			when ST_PC =>
				buffer_we						<= '0';
				if(s_axis_tvalid = '1')then
					pixels_data(19 downto 12)	<= s_axis_tdata( 7 downto 0);	-- P1
					pixels_data(29 downto 22)	<= s_axis_tdata(15 downto 8);	-- P2
					if(s_axis_tuser = '1')then	-- Problem
						sm_rx_state				<= ST_PA;
					elsif(s_axis_tlast /= '1')then
						sm_rx_state				<= ST_PD;
					else
						sm_rx_state				<= ST_IDLE;
					end if;
				end if;
				
			when ST_PD =>
				if((s_axis_tvalid = '1') and (buffer_full = '0'))then
					pixel_a( 9 downto  2)		<= pixels_data( 9 downto  2);
					pixel_a( 1 downto  0)		<= s_axis_tdata( 9 downto  8);
					pixel_b( 9 downto  2)		<= pixels_data(19 downto 12);
					pixel_b( 1 downto  0)		<= s_axis_tdata(11 downto 10);
					pixel_c( 9 downto  2)		<= pixels_data(29 downto 22);
					pixel_c( 1 downto  0)		<= s_axis_tdata(13 downto 12);
					pixel_d( 9 downto  2)		<= s_axis_tdata( 7 downto  0);
					pixel_d( 1 downto  0)		<= s_axis_tdata(15 downto 14);
					buffer_we					<= '1';
					user						<= '0';
					last						<= s_axis_tlast;
					if(s_axis_tuser = '1')then	-- Problem
						sm_rx_state				<= ST_PA;
					else
						sm_rx_state				<= ST_IDLE;
					end if;
				end if;
		end case;
	end if;
end process;

process(sm_rx_state, pixels_valid)
begin
	case sm_rx_state is
		when ST_IDLE	=> s_axis_tready <= '1';
		when ST_PA		=> s_axis_tready <= '1';
		when ST_PB		=> s_axis_tready <= not buffer_full;
		when ST_PC		=> s_axis_tready <= '1';
		when ST_PD		=> s_axis_tready <= not buffer_full;
	end case;
end process;
----------------------------------------------------------------------------------
reg_buf_gen: if C_IMP_TYPE = 0 generate
begin
	process(axis_aclk)
	begin
		if(axis_aclk = '1' and axis_aclk'event)then
			if(pixels_valid = '0')then
				if(((sm_rx_state = ST_PB) or (sm_rx_state = ST_PD)) and (s_axis_tvalid = '1'))then
					pixels_valid	<= '1';
				end if;
			else
				if(buffer_re = '1')then
					pixels_valid	<= '0';
				end if;
			end if;
		end if;
	end process;

	buffer_full			<= pixels_valid;
	buffer_empty		<= not pixels_valid;
	buffer_out_data		<= last & user & pixel_d & pixel_c & pixel_b & pixel_a;

end generate;
----------------------------------------------------------------------------------
fifo_buf_gen: if C_IMP_TYPE = 1 generate
begin
	buffer_in_data		<= last & user & pixel_d & pixel_c & pixel_b & pixel_a;
	
	FIFO_inst: srl_fifo
	generic map(
		C_DEPTH			=> 32,
		C_WIDTH			=> 42
	)
	port map(
		clk_in			=> axis_aclk,
		we_in			=> buffer_we,
		re_in			=> buffer_re,
		full_out		=> buffer_full,
		empty_out		=> buffer_empty,
		data_in			=> buffer_in_data,
		data_out		=> buffer_out_data
	);
end generate;
----------------------------------------------------------------------------------
serial_out_gen: if C_OUT_TYPE = 1 generate
begin
	process(axis_aclk)
	begin
		if(axis_aclk = '1' and axis_aclk'event)then
			case sm_tx_state is
				when ST_WAIT =>
					if(buffer_empty = '0')then
						m_axis_tdata(15 downto 0)		<= "000000" & buffer_out_data( 9 downto  0);
						m_axis_tuser		<= buffer_out_data(40);
						m_axis_tlast		<= '0';
						sm_tx_state			<= ST_TXA;
					end if;
				when ST_TXA =>
					if(m_axis_tready = '1')then
						m_axis_tdata(15 downto 0)		<= "000000" & buffer_out_data(19 downto 10);
						m_axis_tuser		<= '0';
						m_axis_tlast		<= '0';
						sm_tx_state			<= ST_TXB;
					end if;
				when ST_TXB =>
					if(m_axis_tready = '1')then
						m_axis_tdata(15 downto 0)		<= "000000" & buffer_out_data(29 downto 20);
						m_axis_tuser		<= '0';
						m_axis_tlast		<= '0';
						sm_tx_state			<= ST_TXC;
					end if;
				when ST_TXC =>
					if(m_axis_tready = '1')then
						m_axis_tdata(15 downto 0)		<= "000000" & buffer_out_data(39 downto 30);
						m_axis_tuser		<= '0';
						m_axis_tlast		<= buffer_out_data(41);
						sm_tx_state			<= ST_TXD;
					end if;
				when ST_TXD =>
					if(m_axis_tready = '1')then
						if(buffer_empty = '0')then
							m_axis_tdata(15 downto 0)	<= "000000" & buffer_out_data( 9 downto  0);
							m_axis_tuser	<= buffer_out_data(40);
							m_axis_tlast	<= '0';
							sm_tx_state		<= ST_TXA;
						else
							sm_tx_state		<= ST_WAIT;
							m_axis_tlast	<= '0';
						end if;
					end if;
			end case;
		end if;
	end process;
	buffer_re			<= '1' when ((sm_tx_state = ST_TXC) and (m_axis_tready = '1')) else '0';
	m_axis_tvalid		<= '1' when (sm_tx_state /= ST_WAIT) else '0';
end generate;	-- serial_out_gen

parallel4_out_gen: if C_OUT_TYPE = 4 generate
begin
	m_axis_tdata(15 downto  0)	<= "000000" & buffer_out_data( 9 downto  0);
	m_axis_tdata(31 downto 16)	<= "000000" & buffer_out_data(19 downto 10);
	m_axis_tdata(47 downto 32)	<= "000000" & buffer_out_data(29 downto 20);
	m_axis_tdata(63 downto 48)	<= "000000" & buffer_out_data(39 downto 30);
	m_axis_tuser				<= buffer_out_data(40);
	m_axis_tlast				<= buffer_out_data(41);
	m_axis_tvalid				<= not buffer_empty;
	buffer_re					<= m_axis_tready;
end generate;	-- parallel4_out_gen
----------------------------------------------------------------------------------
end arch_imp;
