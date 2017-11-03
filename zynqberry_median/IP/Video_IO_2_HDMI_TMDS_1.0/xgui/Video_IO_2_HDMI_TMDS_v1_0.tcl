
# Loading additional proc with user specified bodies to compute parameter values.
source [file join [file dirname [file dirname [info script]]] gui/Video_IO_2_HDMI_TMDS_v1_0.gtcl]

# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  #Adding Group
  set Clocking [ipgui::add_group $IPINST -name "Clocking" -parent ${Page_0} -display_name {Clocking Options}]
  ipgui::add_param $IPINST -name "C_INT_CLOCKING" -parent ${Clocking}
  ipgui::add_param $IPINST -name "C_VIDEO_MODE" -parent ${Clocking} -widget comboBox

  #Adding Group
  set Pins_swap [ipgui::add_group $IPINST -name "Pins swap" -parent ${Page_0}]
  ipgui::add_param $IPINST -name "C_CLK_SWAP" -parent ${Pins_swap}
  ipgui::add_param $IPINST -name "C_D0_SWAP" -parent ${Pins_swap}
  ipgui::add_param $IPINST -name "C_D1_SWAP" -parent ${Pins_swap}
  ipgui::add_param $IPINST -name "C_D2_SWAP" -parent ${Pins_swap}



}

proc update_PARAM_VALUE.C_VIDEO_MODE { PARAM_VALUE.C_VIDEO_MODE PARAM_VALUE.C_INT_CLOCKING } {
	# Procedure called to update C_VIDEO_MODE when any of the dependent parameters in the arguments change
	
	set C_VIDEO_MODE ${PARAM_VALUE.C_VIDEO_MODE}
	set C_INT_CLOCKING ${PARAM_VALUE.C_INT_CLOCKING}
	set values(C_INT_CLOCKING) [get_property value $C_INT_CLOCKING]
	if { [gen_USERPARAMETER_C_VIDEO_MODE_ENABLEMENT $values(C_INT_CLOCKING)] } {
		set_property enabled true $C_VIDEO_MODE
	} else {
		set_property enabled false $C_VIDEO_MODE
	}
}

proc validate_PARAM_VALUE.C_VIDEO_MODE { PARAM_VALUE.C_VIDEO_MODE } {
	# Procedure called to validate C_VIDEO_MODE
	return true
}

proc update_PARAM_VALUE.C_CLK_SWAP { PARAM_VALUE.C_CLK_SWAP } {
	# Procedure called to update C_CLK_SWAP when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_CLK_SWAP { PARAM_VALUE.C_CLK_SWAP } {
	# Procedure called to validate C_CLK_SWAP
	return true
}

proc update_PARAM_VALUE.C_D0_SWAP { PARAM_VALUE.C_D0_SWAP } {
	# Procedure called to update C_D0_SWAP when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_D0_SWAP { PARAM_VALUE.C_D0_SWAP } {
	# Procedure called to validate C_D0_SWAP
	return true
}

proc update_PARAM_VALUE.C_D1_SWAP { PARAM_VALUE.C_D1_SWAP } {
	# Procedure called to update C_D1_SWAP when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_D1_SWAP { PARAM_VALUE.C_D1_SWAP } {
	# Procedure called to validate C_D1_SWAP
	return true
}

proc update_PARAM_VALUE.C_D2_SWAP { PARAM_VALUE.C_D2_SWAP } {
	# Procedure called to update C_D2_SWAP when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_D2_SWAP { PARAM_VALUE.C_D2_SWAP } {
	# Procedure called to validate C_D2_SWAP
	return true
}

proc update_PARAM_VALUE.C_INT_CLOCKING { PARAM_VALUE.C_INT_CLOCKING } {
	# Procedure called to update C_INT_CLOCKING when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_INT_CLOCKING { PARAM_VALUE.C_INT_CLOCKING } {
	# Procedure called to validate C_INT_CLOCKING
	return true
}


proc update_MODELPARAM_VALUE.C_CLK_SWAP { MODELPARAM_VALUE.C_CLK_SWAP PARAM_VALUE.C_CLK_SWAP } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_CLK_SWAP}] ${MODELPARAM_VALUE.C_CLK_SWAP}
}

proc update_MODELPARAM_VALUE.C_D0_SWAP { MODELPARAM_VALUE.C_D0_SWAP PARAM_VALUE.C_D0_SWAP } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_D0_SWAP}] ${MODELPARAM_VALUE.C_D0_SWAP}
}

proc update_MODELPARAM_VALUE.C_D1_SWAP { MODELPARAM_VALUE.C_D1_SWAP PARAM_VALUE.C_D1_SWAP } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_D1_SWAP}] ${MODELPARAM_VALUE.C_D1_SWAP}
}

proc update_MODELPARAM_VALUE.C_D2_SWAP { MODELPARAM_VALUE.C_D2_SWAP PARAM_VALUE.C_D2_SWAP } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_D2_SWAP}] ${MODELPARAM_VALUE.C_D2_SWAP}
}

proc update_MODELPARAM_VALUE.C_INT_CLOCKING { MODELPARAM_VALUE.C_INT_CLOCKING PARAM_VALUE.C_INT_CLOCKING } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_INT_CLOCKING}] ${MODELPARAM_VALUE.C_INT_CLOCKING}
}

proc update_MODELPARAM_VALUE.C_VIDEO_MODE { MODELPARAM_VALUE.C_VIDEO_MODE PARAM_VALUE.C_VIDEO_MODE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_VIDEO_MODE}] ${MODELPARAM_VALUE.C_VIDEO_MODE}
}

