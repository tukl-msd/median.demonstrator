############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 1986-2017 Xilinx, Inc. All Rights Reserved.
############################################################
open_project SimpleTestPatternGenerator
set_top stpg
add_files SimpleTestPatternGenerator/stpg.cpp
open_solution "Solution1"
set_part {xc7z010clg225-1} -tool vivado
create_clock -period 6.25 -name default
set_clock_uncertainty 0
#source "./SimpleTestPatternGenerator/Solution1/directives.tcl"
#csim_design -compiler gcc
csynth_design
#cosim_design
export_design -format ip_catalog
