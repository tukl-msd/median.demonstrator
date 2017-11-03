# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "C_MODE" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "C_IN_TYPE" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "C_RAW_WIDTH" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "C_COLOR_POS" -parent ${Page_0} -widget comboBox


}

proc update_PARAM_VALUE.C_COLOR_POS { PARAM_VALUE.C_COLOR_POS } {
	# Procedure called to update C_COLOR_POS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_COLOR_POS { PARAM_VALUE.C_COLOR_POS } {
	# Procedure called to validate C_COLOR_POS
	return true
}

proc update_PARAM_VALUE.C_IN_TYPE { PARAM_VALUE.C_IN_TYPE } {
	# Procedure called to update C_IN_TYPE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_IN_TYPE { PARAM_VALUE.C_IN_TYPE } {
	# Procedure called to validate C_IN_TYPE
	return true
}

proc update_PARAM_VALUE.C_MODE { PARAM_VALUE.C_MODE } {
	# Procedure called to update C_MODE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_MODE { PARAM_VALUE.C_MODE } {
	# Procedure called to validate C_MODE
	return true
}

proc update_PARAM_VALUE.C_RAW_WIDTH { PARAM_VALUE.C_RAW_WIDTH } {
	# Procedure called to update C_RAW_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_RAW_WIDTH { PARAM_VALUE.C_RAW_WIDTH } {
	# Procedure called to validate C_RAW_WIDTH
	return true
}


proc update_MODELPARAM_VALUE.C_RAW_WIDTH { MODELPARAM_VALUE.C_RAW_WIDTH PARAM_VALUE.C_RAW_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_RAW_WIDTH}] ${MODELPARAM_VALUE.C_RAW_WIDTH}
}

proc update_MODELPARAM_VALUE.C_MODE { MODELPARAM_VALUE.C_MODE PARAM_VALUE.C_MODE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_MODE}] ${MODELPARAM_VALUE.C_MODE}
}

proc update_MODELPARAM_VALUE.C_IN_TYPE { MODELPARAM_VALUE.C_IN_TYPE PARAM_VALUE.C_IN_TYPE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_IN_TYPE}] ${MODELPARAM_VALUE.C_IN_TYPE}
}

proc update_MODELPARAM_VALUE.C_COLOR_POS { MODELPARAM_VALUE.C_COLOR_POS PARAM_VALUE.C_COLOR_POS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_COLOR_POS}] ${MODELPARAM_VALUE.C_COLOR_POS}
}

