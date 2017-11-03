set_property BITSTREAM.GENERAL.XADCPOWERDOWN ENABLE [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]
set_property BITSTREAM.CONFIG.UNUSEDPIN PULLUP [current_design]

# Leds
set_property IOSTANDARD LVCMOS33 [get_ports {LED[*]}]
# GPIO18
set_property PACKAGE_PIN H11 [get_ports {LED[0]}]
# GPIO17
set_property PACKAGE_PIN G11 [get_ports {LED[1]}]
# GPIO27
set_property PACKAGE_PIN G12 [get_ports {LED[2]}]
# GPIO22
set_property PACKAGE_PIN H13 [get_ports {LED[3]}]
# GPIO23
set_property PACKAGE_PIN J11 [get_ports {LED[4]}]
# GPIO24
set_property PACKAGE_PIN K11 [get_ports {LED[5]}]
# GPIO10
set_property PACKAGE_PIN H14 [get_ports {LED[6]}]
# GPIO9
set_property PACKAGE_PIN J13 [get_ports {LED[7]}]

# HDMI Pins
set_property IOSTANDARD TMDS_33 [get_ports hdmi_clk_p]
set_property PACKAGE_PIN R7 [get_ports hdmi_clk_p]

set_property IOSTANDARD TMDS_33 [get_ports {hdmi_data_p[*]}]
set_property PACKAGE_PIN P8 [get_ports {hdmi_data_p[0]}]
set_property PACKAGE_PIN P10 [get_ports {hdmi_data_p[1]}]
set_property PACKAGE_PIN P11 [get_ports {hdmi_data_p[2]}]

# CSI Pins
set_property PACKAGE_PIN N11 [get_ports csi_c_clk_p]
set_property IOSTANDARD LVDS_25 [get_ports csi_c_clk_p]

set_property PACKAGE_PIN M9 [get_ports {csi_d_lp_n[0]}]
set_property IOSTANDARD HSUL_12 [get_ports {csi_d_lp_n[0]}]
set_property PACKAGE_PIN N9 [get_ports {csi_d_lp_p[0]}]
set_property IOSTANDARD HSUL_12 [get_ports {csi_d_lp_p[0]}]

set_property PACKAGE_PIN M10 [get_ports {csi_d_p[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {csi_d_p[0]}]

set_property PACKAGE_PIN P13 [get_ports {csi_d_p[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {csi_d_p[1]}]

set_property INTERNAL_VREF 0.6 [get_iobanks 34]

set_property PULLDOWN true [get_ports {csi_d_lp_p[0]}]
set_property PULLDOWN true [get_ports {csi_d_lp_n[0]}]

# RPI Camera 1
create_clock -period 6.250 -name csi_clk -add [get_ports csi_c_clk_p]
# RPI Camera 2.1
# create_clock -period 1.875 -name csi_clk -add [get_ports csi_c_clk_p]



set_property BITSTREAM.CONFIG.OVERTEMPPOWERDOWN ENABLE [current_design]


set_false_path -from [get_pins ZynqberryMedianDesign_i/VideoIn/csi_to_axis_0/U0/lane_align_inst/err_req_reg/C] -to [get_pins ZynqberryMedianDesign_i/VideoIn/csi2_d_phy_rx_0/U0/clock_upd_req_reg/D]
set_false_path -from [get_pins {ZynqberryMedianDesign_i/VideoIn/axi_vdma_0/U0/I_PRMRY_DATAMOVER/GEN_S2MM_FULL.I_S2MM_FULL_WRAPPER/GEN_INCLUDE_REALIGNER.I_S2MM_REALIGNER/GEN_INCLUDE_SCATTER.I_S2MM_SCATTER/sig_btt_cntr_dup_reg[*]/C}] -to [get_pins ZynqberryMedianDesign_i/VideoIn/axi_vdma_0/U0/I_PRMRY_DATAMOVER/GEN_S2MM_FULL.I_S2MM_FULL_WRAPPER/GEN_INCLUDE_REALIGNER.I_S2MM_REALIGNER/GEN_INCLUDE_SCATTER.I_S2MM_SCATTER/sig_btt_eq_0_reg/D]
set_false_path -from [get_pins {ZynqberryMedianDesign_i/VideoIn/axi_vdma_0/U0/I_PRMRY_DATAMOVER/GEN_S2MM_FULL.I_S2MM_FULL_WRAPPER/GEN_INCLUDE_REALIGNER.I_S2MM_REALIGNER/GEN_INCLUDE_SCATTER.I_S2MM_SCATTER/sig_max_first_increment_reg[1]/C}] -to [get_pins ZynqberryMedianDesign_i/VideoIn/axi_vdma_0/U0/I_PRMRY_DATAMOVER/GEN_S2MM_FULL.I_S2MM_FULL_WRAPPER/GEN_INCLUDE_REALIGNER.I_S2MM_REALIGNER/GEN_INCLUDE_SCATTER.I_S2MM_SCATTER/sig_btt_eq_0_reg/D]
