set_property SRC_FILE_INFO {cfile:c:/Users/LENOVO/uart_wrapper03/uart_wrapper03.gen/sources_1/ip/ila_0/ila_v6_2/constraints/ila.xdc rfile:../../../uart_wrapper03.gen/sources_1/ip/ila_0/ila_v6_2/constraints/ila.xdc id:1 order:EARLY scoped_inst:ila/inst} [current_design]
set_property SRC_FILE_INFO {cfile:C:/Users/LENOVO/uart_wrapper03/uart_wrapper03.srcs/constrs_1/new/uart_wrapper.xdc rfile:../../../uart_wrapper03.srcs/constrs_1/new/uart_wrapper.xdc id:2} [current_design]
current_instance ila/inst
set_property src_info {type:SCOPED_XDC file:1 line:130 export:INPUT save:INPUT read:READ} [current_design]
create_waiver -internal -quiet -type CDC -id {CDC-10} -user ila -tags "1191969" -description "CDC-10 waiver for DDR Calibration logic" -scope -from [get_pins -quiet -filter {REF_PIN_NAME=~*CLK} -of_objects [get_cells -hierarchical -filter {NAME =~*u_trig/N_DDR_TC.N_DDR_TC_INST[*].U_TC/allx_typeA_match_detection.ltlib_v1_0_2_allx_typeA_inst/DUT/u_srl_drive}]] -to [get_pins -quiet -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~*u_trig/N_DDR_TC.N_DDR_TC_INST[*].U_TC/allx_typeA_match_detection.ltlib_v1_0_2_allx_typeA_inst/DUT/I_IS_TERMINATION_SLICE_W_OUTPUT_REG.DOUT_O_reg}]]
set_property src_info {type:SCOPED_XDC file:1 line:134 export:INPUT save:INPUT read:READ} [current_design]
create_waiver -internal -quiet -type CDC -id {CDC-10} -user system_ila -tags "1196835" -description "CDC-10 waiver for DDR Calibration logic" -scope -from [get_pins -quiet -filter {REF_PIN_NAME=~*CLK} -of_objects [get_cells -hierarchical -filter {NAME =~*u_trig/N_DDR_TC.N_DDR_TC_INST[*].U_TC/allx_typeA_match_detection.ltlib_v1_0_2_allx_typeA_inst/DUT/u_srl_drive}]] -to [get_pins -quiet -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~*u_trig/N_DDR_TC.N_DDR_TC_INST[*].U_TC/allx_typeA_match_detection.ltlib_v1_0_2_allx_typeA_inst/DUT/I_WHOLE_SLICE.G_SLICE_IDX[*].U_ALL_SRL_SLICE/I_IS_TERMINATION_SLICE_W_OUTPUT_REG.DOUT_O_reg}]]
current_instance
set_property src_info {type:XDC file:2 line:3 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { clk }]; #IO_L12P_T1_MRCC_35 Sch=clk100mhz
set_property src_info {type:XDC file:2 line:7 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN C2    IOSTANDARD LVCMOS33 } [get_ports { reset}]; #IO_L16P_T2_35 Sch=sd_dat[0]
set_property src_info {type:XDC file:2 line:9 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN D4    IOSTANDARD LVCMOS33 } [get_ports { rx }];
set_property src_info {type:XDC file:2 line:11 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN C4   IOSTANDARD LVCMOS33 } [get_ports { tx }];
set_property src_info {type:XDC file:2 line:14 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports { reset_led }]; #IO_L18P_T2_A24_15 Sch=led[0]
set_property src_info {type:XDC file:2 line:15 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN J13  IOSTANDARD LVCMOS33 } [get_ports { hb_led }]; #IO_L18P_T2_A24_15 Sch=led[0]
