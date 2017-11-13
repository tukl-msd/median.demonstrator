--Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
--Date        : Mon Nov 13 21:46:44 2017
--Host        : CentOSVivado running 64-bit unknown
--Command     : generate_target ZynqberryMedianDesign_wrapper.bd
--Design      : ZynqberryMedianDesign_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ZynqberryMedianDesign_wrapper is
  port (
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_cas_n : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_dm : inout STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 15 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    LED : out STD_LOGIC_VECTOR ( 7 downto 0 );
    csi_c_clk_n : in STD_LOGIC;
    csi_c_clk_p : in STD_LOGIC;
    csi_d_lp_n : in STD_LOGIC_VECTOR ( 0 to 0 );
    csi_d_lp_p : in STD_LOGIC_VECTOR ( 0 to 0 );
    csi_d_n : in STD_LOGIC_VECTOR ( 1 downto 0 );
    csi_d_p : in STD_LOGIC_VECTOR ( 1 downto 0 );
    hdmi_clk_n : out STD_LOGIC;
    hdmi_clk_p : out STD_LOGIC;
    hdmi_data_n : out STD_LOGIC_VECTOR ( 2 downto 0 );
    hdmi_data_p : out STD_LOGIC_VECTOR ( 2 downto 0 )
  );
end ZynqberryMedianDesign_wrapper;

architecture STRUCTURE of ZynqberryMedianDesign_wrapper is
  component ZynqberryMedianDesign is
  port (
    DDR_cas_n : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_dm : inout STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 15 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 1 downto 0 );
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    hdmi_data_p : out STD_LOGIC_VECTOR ( 2 downto 0 );
    hdmi_clk_p : out STD_LOGIC;
    hdmi_clk_n : out STD_LOGIC;
    hdmi_data_n : out STD_LOGIC_VECTOR ( 2 downto 0 );
    LED : out STD_LOGIC_VECTOR ( 7 downto 0 );
    csi_c_clk_n : in STD_LOGIC;
    csi_d_lp_p : in STD_LOGIC_VECTOR ( 0 to 0 );
    csi_d_n : in STD_LOGIC_VECTOR ( 1 downto 0 );
    csi_d_lp_n : in STD_LOGIC_VECTOR ( 0 to 0 );
    csi_c_clk_p : in STD_LOGIC;
    csi_d_p : in STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  end component ZynqberryMedianDesign;
begin
ZynqberryMedianDesign_i: component ZynqberryMedianDesign
     port map (
      DDR_addr(14 downto 0) => DDR_addr(14 downto 0),
      DDR_ba(2 downto 0) => DDR_ba(2 downto 0),
      DDR_cas_n => DDR_cas_n,
      DDR_ck_n => DDR_ck_n,
      DDR_ck_p => DDR_ck_p,
      DDR_cke => DDR_cke,
      DDR_cs_n => DDR_cs_n,
      DDR_dm(1 downto 0) => DDR_dm(1 downto 0),
      DDR_dq(15 downto 0) => DDR_dq(15 downto 0),
      DDR_dqs_n(1 downto 0) => DDR_dqs_n(1 downto 0),
      DDR_dqs_p(1 downto 0) => DDR_dqs_p(1 downto 0),
      DDR_odt => DDR_odt,
      DDR_ras_n => DDR_ras_n,
      DDR_reset_n => DDR_reset_n,
      DDR_we_n => DDR_we_n,
      FIXED_IO_ddr_vrn => FIXED_IO_ddr_vrn,
      FIXED_IO_ddr_vrp => FIXED_IO_ddr_vrp,
      FIXED_IO_mio(31 downto 0) => FIXED_IO_mio(31 downto 0),
      FIXED_IO_ps_clk => FIXED_IO_ps_clk,
      FIXED_IO_ps_porb => FIXED_IO_ps_porb,
      FIXED_IO_ps_srstb => FIXED_IO_ps_srstb,
      LED(7 downto 0) => LED(7 downto 0),
      csi_c_clk_n => csi_c_clk_n,
      csi_c_clk_p => csi_c_clk_p,
      csi_d_lp_n(0) => csi_d_lp_n(0),
      csi_d_lp_p(0) => csi_d_lp_p(0),
      csi_d_n(1 downto 0) => csi_d_n(1 downto 0),
      csi_d_p(1 downto 0) => csi_d_p(1 downto 0),
      hdmi_clk_n => hdmi_clk_n,
      hdmi_clk_p => hdmi_clk_p,
      hdmi_data_n(2 downto 0) => hdmi_data_n(2 downto 0),
      hdmi_data_p(2 downto 0) => hdmi_data_p(2 downto 0)
    );
end STRUCTURE;
