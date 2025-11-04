# aclk {FREQ_HZ 100000000 CLK_DOMAIN spi_tb_aclk PHASE 0.0}
# Clock Domain: spi_tb_aclk
create_clock -name aclk -period 10.000 [get_ports aclk]
# Generated clocks
