# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "C_S00_AXI_ADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S00_AXI_DATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "NOTE_LENGTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TEXT_0" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TEXT_1" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TEXT_10" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TEXT_11" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TEXT_12" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TEXT_13" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TEXT_14" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TEXT_15" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TEXT_16" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TEXT_17" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TEXT_18" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TEXT_19" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TEXT_2" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TEXT_20" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TEXT_21" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TEXT_22" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TEXT_23" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TEXT_24" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TEXT_25" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TEXT_26" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TEXT_27" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TEXT_3" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TEXT_4" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TEXT_5" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TEXT_6" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TEXT_7" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TEXT_8" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TEXT_9" -parent ${Page_0}
  ipgui::add_param $IPINST -name "VERSION_BOARD" -parent ${Page_0}
  ipgui::add_param $IPINST -name "VERSION_COMPANY" -parent ${Page_0}
  ipgui::add_param $IPINST -name "VERSION_DD" -parent ${Page_0}
  ipgui::add_param $IPINST -name "VERSION_HW" -parent ${Page_0}
  ipgui::add_param $IPINST -name "VERSION_MAJ" -parent ${Page_0}
  ipgui::add_param $IPINST -name "VERSION_MIN" -parent ${Page_0}
  ipgui::add_param $IPINST -name "VERSION_MM" -parent ${Page_0}
  ipgui::add_param $IPINST -name "VERSION_MODE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "VERSION_REV" -parent ${Page_0}
  ipgui::add_param $IPINST -name "VERSION_YYYY" -parent ${Page_0}


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

proc update_PARAM_VALUE.NOTE_LENGTH { PARAM_VALUE.NOTE_LENGTH } {
	# Procedure called to update NOTE_LENGTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.NOTE_LENGTH { PARAM_VALUE.NOTE_LENGTH } {
	# Procedure called to validate NOTE_LENGTH
	return true
}

proc update_PARAM_VALUE.TEXT_0 { PARAM_VALUE.TEXT_0 } {
	# Procedure called to update TEXT_0 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TEXT_0 { PARAM_VALUE.TEXT_0 } {
	# Procedure called to validate TEXT_0
	return true
}

proc update_PARAM_VALUE.TEXT_1 { PARAM_VALUE.TEXT_1 } {
	# Procedure called to update TEXT_1 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TEXT_1 { PARAM_VALUE.TEXT_1 } {
	# Procedure called to validate TEXT_1
	return true
}

proc update_PARAM_VALUE.TEXT_10 { PARAM_VALUE.TEXT_10 } {
	# Procedure called to update TEXT_10 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TEXT_10 { PARAM_VALUE.TEXT_10 } {
	# Procedure called to validate TEXT_10
	return true
}

proc update_PARAM_VALUE.TEXT_11 { PARAM_VALUE.TEXT_11 } {
	# Procedure called to update TEXT_11 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TEXT_11 { PARAM_VALUE.TEXT_11 } {
	# Procedure called to validate TEXT_11
	return true
}

proc update_PARAM_VALUE.TEXT_12 { PARAM_VALUE.TEXT_12 } {
	# Procedure called to update TEXT_12 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TEXT_12 { PARAM_VALUE.TEXT_12 } {
	# Procedure called to validate TEXT_12
	return true
}

proc update_PARAM_VALUE.TEXT_13 { PARAM_VALUE.TEXT_13 } {
	# Procedure called to update TEXT_13 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TEXT_13 { PARAM_VALUE.TEXT_13 } {
	# Procedure called to validate TEXT_13
	return true
}

proc update_PARAM_VALUE.TEXT_14 { PARAM_VALUE.TEXT_14 } {
	# Procedure called to update TEXT_14 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TEXT_14 { PARAM_VALUE.TEXT_14 } {
	# Procedure called to validate TEXT_14
	return true
}

proc update_PARAM_VALUE.TEXT_15 { PARAM_VALUE.TEXT_15 } {
	# Procedure called to update TEXT_15 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TEXT_15 { PARAM_VALUE.TEXT_15 } {
	# Procedure called to validate TEXT_15
	return true
}

proc update_PARAM_VALUE.TEXT_16 { PARAM_VALUE.TEXT_16 } {
	# Procedure called to update TEXT_16 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TEXT_16 { PARAM_VALUE.TEXT_16 } {
	# Procedure called to validate TEXT_16
	return true
}

proc update_PARAM_VALUE.TEXT_17 { PARAM_VALUE.TEXT_17 } {
	# Procedure called to update TEXT_17 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TEXT_17 { PARAM_VALUE.TEXT_17 } {
	# Procedure called to validate TEXT_17
	return true
}

proc update_PARAM_VALUE.TEXT_18 { PARAM_VALUE.TEXT_18 } {
	# Procedure called to update TEXT_18 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TEXT_18 { PARAM_VALUE.TEXT_18 } {
	# Procedure called to validate TEXT_18
	return true
}

proc update_PARAM_VALUE.TEXT_19 { PARAM_VALUE.TEXT_19 } {
	# Procedure called to update TEXT_19 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TEXT_19 { PARAM_VALUE.TEXT_19 } {
	# Procedure called to validate TEXT_19
	return true
}

proc update_PARAM_VALUE.TEXT_2 { PARAM_VALUE.TEXT_2 } {
	# Procedure called to update TEXT_2 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TEXT_2 { PARAM_VALUE.TEXT_2 } {
	# Procedure called to validate TEXT_2
	return true
}

proc update_PARAM_VALUE.TEXT_20 { PARAM_VALUE.TEXT_20 } {
	# Procedure called to update TEXT_20 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TEXT_20 { PARAM_VALUE.TEXT_20 } {
	# Procedure called to validate TEXT_20
	return true
}

proc update_PARAM_VALUE.TEXT_21 { PARAM_VALUE.TEXT_21 } {
	# Procedure called to update TEXT_21 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TEXT_21 { PARAM_VALUE.TEXT_21 } {
	# Procedure called to validate TEXT_21
	return true
}

proc update_PARAM_VALUE.TEXT_22 { PARAM_VALUE.TEXT_22 } {
	# Procedure called to update TEXT_22 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TEXT_22 { PARAM_VALUE.TEXT_22 } {
	# Procedure called to validate TEXT_22
	return true
}

proc update_PARAM_VALUE.TEXT_23 { PARAM_VALUE.TEXT_23 } {
	# Procedure called to update TEXT_23 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TEXT_23 { PARAM_VALUE.TEXT_23 } {
	# Procedure called to validate TEXT_23
	return true
}

proc update_PARAM_VALUE.TEXT_24 { PARAM_VALUE.TEXT_24 } {
	# Procedure called to update TEXT_24 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TEXT_24 { PARAM_VALUE.TEXT_24 } {
	# Procedure called to validate TEXT_24
	return true
}

proc update_PARAM_VALUE.TEXT_25 { PARAM_VALUE.TEXT_25 } {
	# Procedure called to update TEXT_25 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TEXT_25 { PARAM_VALUE.TEXT_25 } {
	# Procedure called to validate TEXT_25
	return true
}

proc update_PARAM_VALUE.TEXT_26 { PARAM_VALUE.TEXT_26 } {
	# Procedure called to update TEXT_26 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TEXT_26 { PARAM_VALUE.TEXT_26 } {
	# Procedure called to validate TEXT_26
	return true
}

proc update_PARAM_VALUE.TEXT_27 { PARAM_VALUE.TEXT_27 } {
	# Procedure called to update TEXT_27 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TEXT_27 { PARAM_VALUE.TEXT_27 } {
	# Procedure called to validate TEXT_27
	return true
}

proc update_PARAM_VALUE.TEXT_3 { PARAM_VALUE.TEXT_3 } {
	# Procedure called to update TEXT_3 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TEXT_3 { PARAM_VALUE.TEXT_3 } {
	# Procedure called to validate TEXT_3
	return true
}

proc update_PARAM_VALUE.TEXT_4 { PARAM_VALUE.TEXT_4 } {
	# Procedure called to update TEXT_4 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TEXT_4 { PARAM_VALUE.TEXT_4 } {
	# Procedure called to validate TEXT_4
	return true
}

proc update_PARAM_VALUE.TEXT_5 { PARAM_VALUE.TEXT_5 } {
	# Procedure called to update TEXT_5 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TEXT_5 { PARAM_VALUE.TEXT_5 } {
	# Procedure called to validate TEXT_5
	return true
}

proc update_PARAM_VALUE.TEXT_6 { PARAM_VALUE.TEXT_6 } {
	# Procedure called to update TEXT_6 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TEXT_6 { PARAM_VALUE.TEXT_6 } {
	# Procedure called to validate TEXT_6
	return true
}

proc update_PARAM_VALUE.TEXT_7 { PARAM_VALUE.TEXT_7 } {
	# Procedure called to update TEXT_7 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TEXT_7 { PARAM_VALUE.TEXT_7 } {
	# Procedure called to validate TEXT_7
	return true
}

proc update_PARAM_VALUE.TEXT_8 { PARAM_VALUE.TEXT_8 } {
	# Procedure called to update TEXT_8 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TEXT_8 { PARAM_VALUE.TEXT_8 } {
	# Procedure called to validate TEXT_8
	return true
}

proc update_PARAM_VALUE.TEXT_9 { PARAM_VALUE.TEXT_9 } {
	# Procedure called to update TEXT_9 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TEXT_9 { PARAM_VALUE.TEXT_9 } {
	# Procedure called to validate TEXT_9
	return true
}

proc update_PARAM_VALUE.VERSION_BOARD { PARAM_VALUE.VERSION_BOARD } {
	# Procedure called to update VERSION_BOARD when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.VERSION_BOARD { PARAM_VALUE.VERSION_BOARD } {
	# Procedure called to validate VERSION_BOARD
	return true
}

proc update_PARAM_VALUE.VERSION_COMPANY { PARAM_VALUE.VERSION_COMPANY } {
	# Procedure called to update VERSION_COMPANY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.VERSION_COMPANY { PARAM_VALUE.VERSION_COMPANY } {
	# Procedure called to validate VERSION_COMPANY
	return true
}

proc update_PARAM_VALUE.VERSION_DD { PARAM_VALUE.VERSION_DD } {
	# Procedure called to update VERSION_DD when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.VERSION_DD { PARAM_VALUE.VERSION_DD } {
	# Procedure called to validate VERSION_DD
	return true
}

proc update_PARAM_VALUE.VERSION_HW { PARAM_VALUE.VERSION_HW } {
	# Procedure called to update VERSION_HW when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.VERSION_HW { PARAM_VALUE.VERSION_HW } {
	# Procedure called to validate VERSION_HW
	return true
}

proc update_PARAM_VALUE.VERSION_MAJ { PARAM_VALUE.VERSION_MAJ } {
	# Procedure called to update VERSION_MAJ when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.VERSION_MAJ { PARAM_VALUE.VERSION_MAJ } {
	# Procedure called to validate VERSION_MAJ
	return true
}

proc update_PARAM_VALUE.VERSION_MIN { PARAM_VALUE.VERSION_MIN } {
	# Procedure called to update VERSION_MIN when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.VERSION_MIN { PARAM_VALUE.VERSION_MIN } {
	# Procedure called to validate VERSION_MIN
	return true
}

proc update_PARAM_VALUE.VERSION_MM { PARAM_VALUE.VERSION_MM } {
	# Procedure called to update VERSION_MM when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.VERSION_MM { PARAM_VALUE.VERSION_MM } {
	# Procedure called to validate VERSION_MM
	return true
}

proc update_PARAM_VALUE.VERSION_MODE { PARAM_VALUE.VERSION_MODE } {
	# Procedure called to update VERSION_MODE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.VERSION_MODE { PARAM_VALUE.VERSION_MODE } {
	# Procedure called to validate VERSION_MODE
	return true
}

proc update_PARAM_VALUE.VERSION_REV { PARAM_VALUE.VERSION_REV } {
	# Procedure called to update VERSION_REV when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.VERSION_REV { PARAM_VALUE.VERSION_REV } {
	# Procedure called to validate VERSION_REV
	return true
}

proc update_PARAM_VALUE.VERSION_YYYY { PARAM_VALUE.VERSION_YYYY } {
	# Procedure called to update VERSION_YYYY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.VERSION_YYYY { PARAM_VALUE.VERSION_YYYY } {
	# Procedure called to validate VERSION_YYYY
	return true
}


proc update_MODELPARAM_VALUE.VERSION_YYYY { MODELPARAM_VALUE.VERSION_YYYY PARAM_VALUE.VERSION_YYYY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.VERSION_YYYY}] ${MODELPARAM_VALUE.VERSION_YYYY}
}

proc update_MODELPARAM_VALUE.VERSION_MM { MODELPARAM_VALUE.VERSION_MM PARAM_VALUE.VERSION_MM } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.VERSION_MM}] ${MODELPARAM_VALUE.VERSION_MM}
}

proc update_MODELPARAM_VALUE.VERSION_DD { MODELPARAM_VALUE.VERSION_DD PARAM_VALUE.VERSION_DD } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.VERSION_DD}] ${MODELPARAM_VALUE.VERSION_DD}
}

proc update_MODELPARAM_VALUE.VERSION_MAJ { MODELPARAM_VALUE.VERSION_MAJ PARAM_VALUE.VERSION_MAJ } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.VERSION_MAJ}] ${MODELPARAM_VALUE.VERSION_MAJ}
}

proc update_MODELPARAM_VALUE.VERSION_MIN { MODELPARAM_VALUE.VERSION_MIN PARAM_VALUE.VERSION_MIN } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.VERSION_MIN}] ${MODELPARAM_VALUE.VERSION_MIN}
}

proc update_MODELPARAM_VALUE.VERSION_REV { MODELPARAM_VALUE.VERSION_REV PARAM_VALUE.VERSION_REV } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.VERSION_REV}] ${MODELPARAM_VALUE.VERSION_REV}
}

proc update_MODELPARAM_VALUE.VERSION_COMPANY { MODELPARAM_VALUE.VERSION_COMPANY PARAM_VALUE.VERSION_COMPANY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.VERSION_COMPANY}] ${MODELPARAM_VALUE.VERSION_COMPANY}
}

proc update_MODELPARAM_VALUE.VERSION_MODE { MODELPARAM_VALUE.VERSION_MODE PARAM_VALUE.VERSION_MODE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.VERSION_MODE}] ${MODELPARAM_VALUE.VERSION_MODE}
}

proc update_MODELPARAM_VALUE.VERSION_BOARD { MODELPARAM_VALUE.VERSION_BOARD PARAM_VALUE.VERSION_BOARD } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.VERSION_BOARD}] ${MODELPARAM_VALUE.VERSION_BOARD}
}

proc update_MODELPARAM_VALUE.VERSION_HW { MODELPARAM_VALUE.VERSION_HW PARAM_VALUE.VERSION_HW } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.VERSION_HW}] ${MODELPARAM_VALUE.VERSION_HW}
}

proc update_MODELPARAM_VALUE.NOTE_LENGTH { MODELPARAM_VALUE.NOTE_LENGTH PARAM_VALUE.NOTE_LENGTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.NOTE_LENGTH}] ${MODELPARAM_VALUE.NOTE_LENGTH}
}

proc update_MODELPARAM_VALUE.TEXT_0 { MODELPARAM_VALUE.TEXT_0 PARAM_VALUE.TEXT_0 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TEXT_0}] ${MODELPARAM_VALUE.TEXT_0}
}

proc update_MODELPARAM_VALUE.TEXT_1 { MODELPARAM_VALUE.TEXT_1 PARAM_VALUE.TEXT_1 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TEXT_1}] ${MODELPARAM_VALUE.TEXT_1}
}

proc update_MODELPARAM_VALUE.TEXT_2 { MODELPARAM_VALUE.TEXT_2 PARAM_VALUE.TEXT_2 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TEXT_2}] ${MODELPARAM_VALUE.TEXT_2}
}

proc update_MODELPARAM_VALUE.TEXT_3 { MODELPARAM_VALUE.TEXT_3 PARAM_VALUE.TEXT_3 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TEXT_3}] ${MODELPARAM_VALUE.TEXT_3}
}

proc update_MODELPARAM_VALUE.TEXT_4 { MODELPARAM_VALUE.TEXT_4 PARAM_VALUE.TEXT_4 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TEXT_4}] ${MODELPARAM_VALUE.TEXT_4}
}

proc update_MODELPARAM_VALUE.TEXT_5 { MODELPARAM_VALUE.TEXT_5 PARAM_VALUE.TEXT_5 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TEXT_5}] ${MODELPARAM_VALUE.TEXT_5}
}

proc update_MODELPARAM_VALUE.TEXT_6 { MODELPARAM_VALUE.TEXT_6 PARAM_VALUE.TEXT_6 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TEXT_6}] ${MODELPARAM_VALUE.TEXT_6}
}

proc update_MODELPARAM_VALUE.TEXT_7 { MODELPARAM_VALUE.TEXT_7 PARAM_VALUE.TEXT_7 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TEXT_7}] ${MODELPARAM_VALUE.TEXT_7}
}

proc update_MODELPARAM_VALUE.TEXT_8 { MODELPARAM_VALUE.TEXT_8 PARAM_VALUE.TEXT_8 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TEXT_8}] ${MODELPARAM_VALUE.TEXT_8}
}

proc update_MODELPARAM_VALUE.TEXT_9 { MODELPARAM_VALUE.TEXT_9 PARAM_VALUE.TEXT_9 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TEXT_9}] ${MODELPARAM_VALUE.TEXT_9}
}

proc update_MODELPARAM_VALUE.TEXT_10 { MODELPARAM_VALUE.TEXT_10 PARAM_VALUE.TEXT_10 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TEXT_10}] ${MODELPARAM_VALUE.TEXT_10}
}

proc update_MODELPARAM_VALUE.TEXT_11 { MODELPARAM_VALUE.TEXT_11 PARAM_VALUE.TEXT_11 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TEXT_11}] ${MODELPARAM_VALUE.TEXT_11}
}

proc update_MODELPARAM_VALUE.TEXT_12 { MODELPARAM_VALUE.TEXT_12 PARAM_VALUE.TEXT_12 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TEXT_12}] ${MODELPARAM_VALUE.TEXT_12}
}

proc update_MODELPARAM_VALUE.TEXT_13 { MODELPARAM_VALUE.TEXT_13 PARAM_VALUE.TEXT_13 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TEXT_13}] ${MODELPARAM_VALUE.TEXT_13}
}

proc update_MODELPARAM_VALUE.TEXT_14 { MODELPARAM_VALUE.TEXT_14 PARAM_VALUE.TEXT_14 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TEXT_14}] ${MODELPARAM_VALUE.TEXT_14}
}

proc update_MODELPARAM_VALUE.TEXT_15 { MODELPARAM_VALUE.TEXT_15 PARAM_VALUE.TEXT_15 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TEXT_15}] ${MODELPARAM_VALUE.TEXT_15}
}

proc update_MODELPARAM_VALUE.TEXT_16 { MODELPARAM_VALUE.TEXT_16 PARAM_VALUE.TEXT_16 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TEXT_16}] ${MODELPARAM_VALUE.TEXT_16}
}

proc update_MODELPARAM_VALUE.TEXT_17 { MODELPARAM_VALUE.TEXT_17 PARAM_VALUE.TEXT_17 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TEXT_17}] ${MODELPARAM_VALUE.TEXT_17}
}

proc update_MODELPARAM_VALUE.TEXT_18 { MODELPARAM_VALUE.TEXT_18 PARAM_VALUE.TEXT_18 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TEXT_18}] ${MODELPARAM_VALUE.TEXT_18}
}

proc update_MODELPARAM_VALUE.TEXT_19 { MODELPARAM_VALUE.TEXT_19 PARAM_VALUE.TEXT_19 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TEXT_19}] ${MODELPARAM_VALUE.TEXT_19}
}

proc update_MODELPARAM_VALUE.TEXT_20 { MODELPARAM_VALUE.TEXT_20 PARAM_VALUE.TEXT_20 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TEXT_20}] ${MODELPARAM_VALUE.TEXT_20}
}

proc update_MODELPARAM_VALUE.TEXT_21 { MODELPARAM_VALUE.TEXT_21 PARAM_VALUE.TEXT_21 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TEXT_21}] ${MODELPARAM_VALUE.TEXT_21}
}

proc update_MODELPARAM_VALUE.TEXT_22 { MODELPARAM_VALUE.TEXT_22 PARAM_VALUE.TEXT_22 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TEXT_22}] ${MODELPARAM_VALUE.TEXT_22}
}

proc update_MODELPARAM_VALUE.TEXT_23 { MODELPARAM_VALUE.TEXT_23 PARAM_VALUE.TEXT_23 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TEXT_23}] ${MODELPARAM_VALUE.TEXT_23}
}

proc update_MODELPARAM_VALUE.TEXT_24 { MODELPARAM_VALUE.TEXT_24 PARAM_VALUE.TEXT_24 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TEXT_24}] ${MODELPARAM_VALUE.TEXT_24}
}

proc update_MODELPARAM_VALUE.TEXT_25 { MODELPARAM_VALUE.TEXT_25 PARAM_VALUE.TEXT_25 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TEXT_25}] ${MODELPARAM_VALUE.TEXT_25}
}

proc update_MODELPARAM_VALUE.TEXT_26 { MODELPARAM_VALUE.TEXT_26 PARAM_VALUE.TEXT_26 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TEXT_26}] ${MODELPARAM_VALUE.TEXT_26}
}

proc update_MODELPARAM_VALUE.TEXT_27 { MODELPARAM_VALUE.TEXT_27 PARAM_VALUE.TEXT_27 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TEXT_27}] ${MODELPARAM_VALUE.TEXT_27}
}

proc update_MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH}
}

