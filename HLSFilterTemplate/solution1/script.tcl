############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 1986-2017 Xilinx, Inc. All Rights Reserved.
############################################################
open_project HLSFilterTemplate
set_top HLSFilterTemplate
add_files main.cpp
open_solution "solution1"
set_part {xc7z010clg225-1} -tool vivado
create_clock -period 6.66 -name default
set_clock_uncertainty 0
#source "./HLSFilterTemplate/solution1/directives.tcl"
#csim_design -compiler gcc
csynth_design
#cosim_design
export_design -flow syn -rtl vhdl -format ip_catalog -vendor "MicroelectronicSystemsDesignResearchGroup" -display_name "HLSBlackWhiteFilter"
