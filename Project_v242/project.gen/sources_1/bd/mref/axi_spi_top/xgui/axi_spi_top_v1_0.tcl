# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "CMD_FIFO_DEPTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S00_AXI_ADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S00_AXI_DATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "NUM_REGS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "N_DEV" -parent ${Page_0}
  ipgui::add_param $IPINST -name "STD_W" -parent ${Page_0}


}

proc update_PARAM_VALUE.CMD_FIFO_DEPTH { PARAM_VALUE.CMD_FIFO_DEPTH } {
	# Procedure called to update CMD_FIFO_DEPTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CMD_FIFO_DEPTH { PARAM_VALUE.CMD_FIFO_DEPTH } {
	# Procedure called to validate CMD_FIFO_DEPTH
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_ADDR_WIDTH { PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to update C_S00_AXI_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_ADDR_WIDTH { PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to validate C_S00_AXI_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_DATA_WIDTH { PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to update C_S00_AXI_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_DATA_WIDTH { PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to validate C_S00_AXI_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.NUM_REGS { PARAM_VALUE.NUM_REGS } {
	# Procedure called to update NUM_REGS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.NUM_REGS { PARAM_VALUE.NUM_REGS } {
	# Procedure called to validate NUM_REGS
	return true
}

proc update_PARAM_VALUE.N_DEV { PARAM_VALUE.N_DEV } {
	# Procedure called to update N_DEV when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.N_DEV { PARAM_VALUE.N_DEV } {
	# Procedure called to validate N_DEV
	return true
}

proc update_PARAM_VALUE.STD_W { PARAM_VALUE.STD_W } {
	# Procedure called to update STD_W when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.STD_W { PARAM_VALUE.STD_W } {
	# Procedure called to validate STD_W
	return true
}


proc update_MODELPARAM_VALUE.NUM_REGS { MODELPARAM_VALUE.NUM_REGS PARAM_VALUE.NUM_REGS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.NUM_REGS}] ${MODELPARAM_VALUE.NUM_REGS}
}

proc update_MODELPARAM_VALUE.STD_W { MODELPARAM_VALUE.STD_W PARAM_VALUE.STD_W } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.STD_W}] ${MODELPARAM_VALUE.STD_W}
}

proc update_MODELPARAM_VALUE.N_DEV { MODELPARAM_VALUE.N_DEV PARAM_VALUE.N_DEV } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.N_DEV}] ${MODELPARAM_VALUE.N_DEV}
}

proc update_MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.CMD_FIFO_DEPTH { MODELPARAM_VALUE.CMD_FIFO_DEPTH PARAM_VALUE.CMD_FIFO_DEPTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CMD_FIFO_DEPTH}] ${MODELPARAM_VALUE.CMD_FIFO_DEPTH}
}

