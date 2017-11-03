# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "C_IMP_TYPE" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "C_OUT_TYPE" -parent ${Page_0} -widget comboBox


}

proc update_PARAM_VALUE.C_IMP_TYPE { PARAM_VALUE.C_IMP_TYPE } {
	# Procedure called to update C_IMP_TYPE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_IMP_TYPE { PARAM_VALUE.C_IMP_TYPE } {
	# Procedure called to validate C_IMP_TYPE
	return true
}

proc update_PARAM_VALUE.C_OUT_TYPE { PARAM_VALUE.C_OUT_TYPE } {
	# Procedure called to update C_OUT_TYPE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_OUT_TYPE { PARAM_VALUE.C_OUT_TYPE } {
	# Procedure called to validate C_OUT_TYPE
	return true
}


proc update_MODELPARAM_VALUE.C_IMP_TYPE { MODELPARAM_VALUE.C_IMP_TYPE PARAM_VALUE.C_IMP_TYPE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_IMP_TYPE}] ${MODELPARAM_VALUE.C_IMP_TYPE}
}

proc update_MODELPARAM_VALUE.C_OUT_TYPE { MODELPARAM_VALUE.C_OUT_TYPE PARAM_VALUE.C_OUT_TYPE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_OUT_TYPE}] ${MODELPARAM_VALUE.C_OUT_TYPE}
}

