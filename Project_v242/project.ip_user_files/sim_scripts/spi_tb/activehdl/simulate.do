transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+spi_tb  -L xil_defaultlib -L xilinx_vip -L xpm -L axi_infrastructure_v1_1_0 -L axi_vip_v1_1_19 -L xlconstant_v1_1_9 -L lib_cdc_v1_0_3 -L proc_sys_reset_v5_0_16 -L smartconnect_v1_0 -L axi_register_slice_v2_1_33 -L xilinx_vip -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.spi_tb xil_defaultlib.glbl

do {spi_tb.udo}

run 1000ns

endsim

quit -force
