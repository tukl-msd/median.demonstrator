----------------------------------------------------------------------------------
-- Company: Trenz Electronic GmbH
-- Engineer: Oleksandr Kiyenko
----------------------------------------------------------------------------------
library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
library UNISIM;
use UNISIM.VComponents.all;
----------------------------------------------------------------------------------
entity axis_raw_demosaic_v1_0 is
generic (
	C_MODE					: integer range 0 to 1	:= 1;
	C_COLOR_POS				: integer range 0 to 2	:= 0;
	C_IN_TYPE				: integer range 1 to 4	:= 1;
	C_RAW_WIDTH				: integer	:= 10
);
port (
	axis_aclk				: in  STD_LOGIC;
	axis_aresetn			: in  STD_LOGIC;
	
	colors_mode				: in  STD_LOGIC;
	
	s_axis_tready			: out STD_LOGIC;
	s_axis_tdata			: in  STD_LOGIC_VECTOR(C_IN_TYPE*16-1 downto 0);
	s_axis_tuser			: in  STD_LOGIC;
	s_axis_tlast			: in  STD_LOGIC;
	s_axis_tvalid			: in  STD_LOGIC;

	m_axis_tvalid			: out STD_LOGIC;
	m_axis_tdata			: out STD_LOGIC_VECTOR(C_IN_TYPE*32-1 downto 0);
	m_axis_tuser			: out STD_LOGIC;
	m_axis_tlast			: out STD_LOGIC;
	m_axis_tready			: in  STD_LOGIC
);
end axis_raw_demosaic_v1_0;
----------------------------------------------------------------------------------
architecture arch_imp of axis_raw_demosaic_v1_0 is
----------------------------------------------------------------------------------
component dualport_ram is
port (
	clk						: in  STD_LOGIC;
	wea						: in  STD_LOGIC;
	addra					: in  STD_LOGIC_VECTOR(10 downto 0);
	addrb					: in  STD_LOGIC_VECTOR(10 downto 0);
	dia						: in  STD_LOGIC_VECTOR(9 downto 0);
	dob						: out STD_LOGIC_VECTOR(9 downto 0)
);
end component;

component gamma_rom is
port(
	addra					: in  STD_LOGIC_VECTOR(9 downto 0);
	clka					: in  STD_LOGIC;
	douta					: out STD_LOGIC_VECTOR(7 downto 0)
);
end component;
----------------------------------------------------------------------------------
signal tx_alpha				: STD_LOGIC_VECTOR(7 downto 0);
signal tx_blue				: STD_LOGIC_VECTOR(7 downto 0);
signal tx_green				: STD_LOGIC_VECTOR(7 downto 0);
signal tx_red				: STD_LOGIC_VECTOR(7 downto 0);
signal x_cnt				: UNSIGNED(15 downto 0);
signal y_cnt				: UNSIGNED(15 downto 0);
type sm_state_type is (ST_IDLE, ST_PROCESS, ST_SEND);
signal sm_state				: sm_state_type := ST_IDLE;
signal up_pixel_data		: STD_LOGIC_VECTOR(C_RAW_WIDTH-1 downto 0);
signal pixel_data			: STD_LOGIC_VECTOR(C_RAW_WIDTH-1 downto 0);
signal position				: STD_LOGIC_VECTOR(1 downto 0);
signal tx_valid				: STD_LOGIC;
signal tx_user				: STD_LOGIC;
signal tx_last				: STD_LOGIC;
signal x_wr_addr			: UNSIGNED(15 downto 0);
signal x_rd_addr			: UNSIGNED(15 downto 0);
signal ram_write			: STD_LOGIC;
signal ram_wr_addr			: STD_LOGIC_VECTOR(10 downto 0);
signal ram_rd_addr			: STD_LOGIC_VECTOR(10 downto 0);
signal ram_wr_data			: STD_LOGIC_VECTOR( 9 downto 0);
signal ram_rd_data			: STD_LOGIC_VECTOR( 9 downto 0);
type raw_pixel is array (3 downto 0) of STD_LOGIC_VECTOR(C_RAW_WIDTH-1 downto 0);
signal pixel				: raw_pixel;
type std_pixel is array (3 downto 0) of STD_LOGIC_VECTOR(7 downto 0);
signal pixel_gamma			: std_pixel;
signal colors_mode_i		: STD_LOGIC;
----------------------------------------------------------------------------------
begin
----------------------------------------------------------------------------------
ram_wr_addr		<= STD_LOGIC_VECTOR(x_wr_addr(10 downto 0));
ram_rd_addr		<= STD_LOGIC_VECTOR(x_rd_addr(10 downto 0));
ram_wr_data		<= pixel(0);
up_pixel_data	<= ram_rd_data;
pixel_data		<= s_axis_tdata(C_RAW_WIDTH-1 downto 0);
----------------------------------------------------------------------------------
ram_inst: dualport_ram
port map(
	clk			=> axis_aclk,
	wea			=> ram_write,
	addra		=> ram_wr_addr,
	addrb		=> ram_rd_addr,
	dia			=> ram_wr_data,
	dob			=> ram_rd_data
);
----------------------------------------------------------------------------------
process(axis_aclk)
begin
	if(axis_aclk = '1' and axis_aclk'event)then
		case sm_state is
			when ST_IDLE => 
				if(s_axis_tvalid = '1')then
					sm_state		<= ST_PROCESS;
					pixel(0)		<= pixel_data;
					pixel(1)		<= pixel(0);
					pixel(2)		<= up_pixel_data;
					pixel(3)		<= pixel(2);
					tx_user			<= s_axis_tuser;
					tx_last			<= s_axis_tlast;
					x_wr_addr		<= x_cnt;
					ram_write		<= '1';
					position		<= y_cnt(0) & x_cnt(0);
					if(s_axis_tlast = '1')then
						x_cnt		<= (others => '0');
						x_rd_addr	<= (others => '0');
					else
						x_cnt		<= x_cnt + 1;
						x_rd_addr	<= x_cnt + 1;
					end if;
					if(s_axis_tuser = '1')then
						y_cnt		<= (others => '0');
					elsif(s_axis_tlast = '1')then
						y_cnt		<= y_cnt + 1;
					end if;
				else
					ram_write		<= '0';
				end if;
			when ST_PROCESS =>
				ram_write			<= '0';
				sm_state			<= ST_SEND;
			when ST_SEND =>
				if(m_axis_tready = '1')then
					if(s_axis_tvalid = '0')then
						sm_state		<= ST_IDLE;
						ram_write		<= '0';
					else
						sm_state		<= ST_PROCESS;
						pixel(0)		<= pixel_data;
						pixel(1)		<= pixel(0);
						pixel(2)		<= up_pixel_data;
						pixel(3)		<= pixel(2);
						tx_user			<= s_axis_tuser;
						tx_last			<= s_axis_tlast;
						x_wr_addr		<= x_cnt;
						ram_write		<= '1';
						position		<= y_cnt(0) & x_cnt(0);
						if(s_axis_tlast = '1')then
							x_cnt		<= (others => '0');
							x_rd_addr	<= (others => '0');
						else
							x_cnt		<= x_cnt + 1;
							x_rd_addr	<= x_cnt + 1;
						end if;
						if(s_axis_tuser = '1')then
							y_cnt		<= (others => '0');
						elsif(s_axis_tlast = '1')then
							y_cnt		<= y_cnt + 1;
						end if;
					end if;
				end if;
		end case;
	end if;
end process;
----------------------------------------------------------------------------------
gamma_rom_gen: for i in 0 to 3 generate
begin
	pa_gamma_inst: gamma_rom
	port map(
		addra		=> pixel(i),
		clka		=> axis_aclk,
		douta		=> pixel_gamma(i)
	);
end generate;
----------------------------------------------------------------------------------
process(axis_aclk)
begin
	if(axis_aclk = '1' and axis_aclk'event)then
		if(C_COLOR_POS = 0)then
			colors_mode_i	<= '0';
		elsif(C_COLOR_POS = 1)then
			colors_mode_i	<= '1';
		else	-- C_COLOR_POS = 2
			colors_mode_i	<= colors_mode;
		end if;
	end if;
end process;
----------------------------------------------------------------------------------
tx_alpha			<= (others => '0');
-- Demosaic (Color)
demosaic_gen: if C_MODE = 1 generate
begin

	process(sm_state, m_axis_tready)
	begin
		case sm_state is
			when ST_IDLE 	=> s_axis_tready	<= '1';
			when ST_PROCESS => s_axis_tready	<= '0';
			when ST_SEND 	=> s_axis_tready	<= m_axis_tready;
		end case;
	end process;
	
	m_axis_tvalid		<= '1' when (sm_state = ST_SEND) else '0';
	m_axis_tuser		<= tx_user;
	m_axis_tlast		<= tx_last;
	
	process(position, tx_alpha, pixel_gamma, colors_mode_i)
	begin
		if(colors_mode_i = '0')then
			case position is
				when "01" => m_axis_tdata	<= tx_alpha & pixel_gamma(1) & pixel_gamma(0) & pixel_gamma(2);
				when "00" => m_axis_tdata	<= tx_alpha & pixel_gamma(0) & pixel_gamma(1) & pixel_gamma(3);
				when "11" => m_axis_tdata	<= tx_alpha & pixel_gamma(3) & pixel_gamma(1) & pixel_gamma(0);
				when "10" => m_axis_tdata	<= tx_alpha & pixel_gamma(2) & pixel_gamma(0) & pixel_gamma(1);
				when others => null;
			end case;
		else
			case position is
				when "01" => m_axis_tdata	<= tx_alpha & pixel_gamma(2) & pixel_gamma(0) & pixel_gamma(1);
				when "00" => m_axis_tdata	<= tx_alpha & pixel_gamma(3) & pixel_gamma(1) & pixel_gamma(0);
				when "11" => m_axis_tdata	<= tx_alpha & pixel_gamma(0) & pixel_gamma(1) & pixel_gamma(3);
				when "10" => m_axis_tdata	<= tx_alpha & pixel_gamma(1) & pixel_gamma(0) & pixel_gamma(2);
				when others => null;
			end case;
		end if;
	end process;
		
end generate;
----------------------------------------------------------------------------------
-- Bypass (Raw grayscale)
bypass_gen: if C_MODE = 0 generate
begin
	s_axis_tready		<= m_axis_tready;
	m_axis_tvalid		<= s_axis_tvalid;
	m_axis_tuser		<= s_axis_tuser;
	m_axis_tlast		<= s_axis_tlast;
	data_gen: for i in 0 to C_IN_TYPE-1 generate
	begin
		m_axis_tdata(i*32+31 downto i*32)	<= x"00" & 
			s_axis_tdata(i*16+9 downto i*16+2) & 
			s_axis_tdata(i*16+9 downto i*16+2) & 
			s_axis_tdata(i*16+9 downto i*16+2);
	end generate;
end generate;
----------------------------------------------------------------------------------
end arch_imp;
