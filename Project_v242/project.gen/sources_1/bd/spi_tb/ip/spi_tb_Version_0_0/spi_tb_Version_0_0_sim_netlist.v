// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (win64) Build 5239630 Fri Nov 08 22:35:27 MST 2024
// Date        : Thu Sep 11 15:58:53 2025
// Host        : FPGA_LAX running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/tmy/0_elta/SPI/Project_v242/project.gen/sources_1/bd/spi_tb/ip/spi_tb_Version_0_0/spi_tb_Version_0_0_sim_netlist.v
// Design      : spi_tb_Version_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xck26-sfvc784-2LV-c
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "spi_tb_Version_0_0,Version,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "Version,Vivado 2024.2" *) 
(* NotValidForBitStream *)
module spi_tb_Version_0_0
   (s_axi_aclk,
    s_axi_aresetn,
    s_axi_awaddr,
    s_axi_awprot,
    s_axi_awvalid,
    s_axi_awready,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_wvalid,
    s_axi_wready,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_bready,
    s_axi_araddr,
    s_axi_arprot,
    s_axi_arvalid,
    s_axi_arready,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rvalid,
    s_axi_rready);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 s_axi_aclk CLK" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi_aclk, ASSOCIATED_BUSIF s_axi, ASSOCIATED_RESET s_axi_aresetn, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN spi_tb_aclk, INSERT_VIP 0" *) input s_axi_aclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 s_axi_aresetn RST" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input s_axi_aresetn;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWADDR" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 100000000, ID_WIDTH 0, ADDR_WIDTH 7, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN spi_tb_aclk, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) input [6:0]s_axi_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWPROT" *) input [2:0]s_axi_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWVALID" *) input s_axi_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWREADY" *) output s_axi_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WDATA" *) input [31:0]s_axi_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WSTRB" *) input [3:0]s_axi_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WVALID" *) input s_axi_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WREADY" *) output s_axi_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BRESP" *) output [1:0]s_axi_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BVALID" *) output s_axi_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BREADY" *) input s_axi_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARADDR" *) input [6:0]s_axi_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARPROT" *) input [2:0]s_axi_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARVALID" *) input s_axi_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARREADY" *) output s_axi_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) output [31:0]s_axi_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RRESP" *) output [1:0]s_axi_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RVALID" *) output s_axi_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RREADY" *) input s_axi_rready;

  wire \<const0> ;
  wire s_axi_aclk;
  wire [6:0]s_axi_araddr;
  wire s_axi_aresetn;
  wire s_axi_arready;
  wire s_axi_arvalid;
  wire s_axi_awready;
  wire s_axi_awvalid;
  wire s_axi_bready;
  wire s_axi_bvalid;
  wire [31:0]s_axi_rdata;
  wire s_axi_rready;
  wire s_axi_rvalid;
  wire s_axi_wready;
  wire s_axi_wvalid;

  assign s_axi_bresp[1] = \<const0> ;
  assign s_axi_bresp[0] = \<const0> ;
  assign s_axi_rresp[1] = \<const0> ;
  assign s_axi_rresp[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  spi_tb_Version_0_0_Version inst
       (.axi_arready_reg(s_axi_arready),
        .axi_awready_reg(s_axi_awready),
        .axi_rvalid_reg(s_axi_rvalid),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_araddr(s_axi_araddr[6:2]),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_bready(s_axi_bready),
        .s_axi_bvalid(s_axi_bvalid),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rready(s_axi_rready),
        .s_axi_wready(s_axi_wready),
        .s_axi_wvalid(s_axi_wvalid));
endmodule

(* ORIG_REF_NAME = "Version" *) 
module spi_tb_Version_0_0_Version
   (s_axi_rdata,
    axi_awready_reg,
    axi_arready_reg,
    axi_rvalid_reg,
    s_axi_bvalid,
    s_axi_wready,
    s_axi_aclk,
    s_axi_araddr,
    s_axi_awvalid,
    s_axi_wvalid,
    s_axi_arvalid,
    s_axi_rready,
    s_axi_aresetn,
    s_axi_bready);
  output [31:0]s_axi_rdata;
  output axi_awready_reg;
  output axi_arready_reg;
  output axi_rvalid_reg;
  output s_axi_bvalid;
  output s_axi_wready;
  input s_axi_aclk;
  input [4:0]s_axi_araddr;
  input s_axi_awvalid;
  input s_axi_wvalid;
  input s_axi_arvalid;
  input s_axi_rready;
  input s_axi_aresetn;
  input s_axi_bready;

  wire axi_arready_reg;
  wire axi_awready_reg;
  wire axi_rvalid_reg;
  wire s_axi_aclk;
  wire [4:0]s_axi_araddr;
  wire s_axi_aresetn;
  wire s_axi_arvalid;
  wire s_axi_awvalid;
  wire s_axi_bready;
  wire s_axi_bvalid;
  wire [31:0]s_axi_rdata;
  wire s_axi_rready;
  wire s_axi_wready;
  wire s_axi_wvalid;

  spi_tb_Version_0_0_Version_AXI Version_AXI_inst
       (.axi_arready_reg_0(axi_arready_reg),
        .axi_awready_reg_0(axi_awready_reg),
        .axi_rvalid_reg_0(axi_rvalid_reg),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_araddr(s_axi_araddr),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_bready(s_axi_bready),
        .s_axi_bvalid(s_axi_bvalid),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rready(s_axi_rready),
        .s_axi_wready(s_axi_wready),
        .s_axi_wvalid(s_axi_wvalid));
endmodule

(* ORIG_REF_NAME = "Version_AXI" *) 
module spi_tb_Version_0_0_Version_AXI
   (s_axi_rdata,
    axi_awready_reg_0,
    axi_arready_reg_0,
    axi_rvalid_reg_0,
    s_axi_bvalid,
    s_axi_wready,
    s_axi_aclk,
    s_axi_araddr,
    s_axi_awvalid,
    s_axi_wvalid,
    s_axi_arvalid,
    s_axi_rready,
    s_axi_aresetn,
    s_axi_bready);
  output [31:0]s_axi_rdata;
  output axi_awready_reg_0;
  output axi_arready_reg_0;
  output axi_rvalid_reg_0;
  output s_axi_bvalid;
  output s_axi_wready;
  input s_axi_aclk;
  input [4:0]s_axi_araddr;
  input s_axi_awvalid;
  input s_axi_wvalid;
  input s_axi_arvalid;
  input s_axi_rready;
  input s_axi_aresetn;
  input s_axi_bready;

  wire \FSM_sequential_state_read[1]_i_1_n_0 ;
  wire \FSM_sequential_state_write[1]_i_1_n_0 ;
  (* RTL_KEEP = "true" *) wire [31:0]USR_ACCESSE2_reg;
  (* RTL_KEEP = "true" *) wire [31:0]USR_ACCESSE2_wire;
  wire \axi_araddr[6]_i_1_n_0 ;
  wire axi_arready_i_1_n_0;
  wire axi_arready_reg_0;
  wire axi_awready0__0;
  wire axi_awready_i_1_n_0;
  wire axi_awready_i_2_n_0;
  wire axi_awready_reg_0;
  wire axi_bvalid_i_1_n_0;
  wire axi_rvalid_i_1_n_0;
  wire axi_rvalid_reg_0;
  wire axi_wready_i_1_n_0;
  wire s_axi_aclk;
  wire [4:0]s_axi_araddr;
  wire s_axi_aresetn;
  wire s_axi_arvalid;
  wire s_axi_awvalid;
  wire s_axi_bready;
  wire s_axi_bvalid;
  wire [31:0]s_axi_rdata;
  wire s_axi_rready;
  wire s_axi_wready;
  wire s_axi_wvalid;
  wire [4:0]sel0;
  wire [1:0]state_read;
  wire [1:0]state_read__0;
  wire [1:0]state_write;
  wire [1:0]state_write__0;
  wire NLW_USR_ACCESSE2_inst_CFGCLK_UNCONNECTED;
  wire NLW_USR_ACCESSE2_inst_DATAVALID_UNCONNECTED;

  LUT6 #(
    .INIT(64'h07070707FF0F0F0F)) 
    \FSM_sequential_state_read[0]_i_1 
       (.I0(s_axi_arvalid),
        .I1(axi_arready_reg_0),
        .I2(state_read[1]),
        .I3(s_axi_rready),
        .I4(axi_rvalid_reg_0),
        .I5(state_read[0]),
        .O(state_read__0[0]));
  LUT2 #(
    .INIT(4'h7)) 
    \FSM_sequential_state_read[1]_i_1 
       (.I0(state_read[0]),
        .I1(state_read[1]),
        .O(\FSM_sequential_state_read[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00800F800F800F80)) 
    \FSM_sequential_state_read[1]_i_2 
       (.I0(axi_arready_reg_0),
        .I1(s_axi_arvalid),
        .I2(state_read[0]),
        .I3(state_read[1]),
        .I4(s_axi_rready),
        .I5(axi_rvalid_reg_0),
        .O(state_read__0[1]));
  (* FSM_ENCODED_STATES = "Idle:00,Rdata:10,Raddr:01" *) 
  FDRE \FSM_sequential_state_read_reg[0] 
       (.C(s_axi_aclk),
        .CE(\FSM_sequential_state_read[1]_i_1_n_0 ),
        .D(state_read__0[0]),
        .Q(state_read[0]),
        .R(axi_awready_i_1_n_0));
  (* FSM_ENCODED_STATES = "Idle:00,Rdata:10,Raddr:01" *) 
  FDRE \FSM_sequential_state_read_reg[1] 
       (.C(s_axi_aclk),
        .CE(\FSM_sequential_state_read[1]_i_1_n_0 ),
        .D(state_read__0[1]),
        .Q(state_read[1]),
        .R(axi_awready_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h0F07FF0F)) 
    \FSM_sequential_state_write[0]_i_1 
       (.I0(axi_awready_reg_0),
        .I1(s_axi_awvalid),
        .I2(state_write[1]),
        .I3(s_axi_wvalid),
        .I4(state_write[0]),
        .O(state_write__0[0]));
  LUT2 #(
    .INIT(4'h7)) 
    \FSM_sequential_state_write[1]_i_1 
       (.I0(state_write[0]),
        .I1(state_write[1]),
        .O(\FSM_sequential_state_write[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h00000F80)) 
    \FSM_sequential_state_write[1]_i_2 
       (.I0(s_axi_awvalid),
        .I1(axi_awready_reg_0),
        .I2(state_write[0]),
        .I3(state_write[1]),
        .I4(s_axi_wvalid),
        .O(state_write__0[1]));
  (* FSM_ENCODED_STATES = "Idle:00,Wdata:10,Waddr:01" *) 
  FDRE \FSM_sequential_state_write_reg[0] 
       (.C(s_axi_aclk),
        .CE(\FSM_sequential_state_write[1]_i_1_n_0 ),
        .D(state_write__0[0]),
        .Q(state_write[0]),
        .R(axi_awready_i_1_n_0));
  (* FSM_ENCODED_STATES = "Idle:00,Wdata:10,Waddr:01" *) 
  FDRE \FSM_sequential_state_write_reg[1] 
       (.C(s_axi_aclk),
        .CE(\FSM_sequential_state_write[1]_i_1_n_0 ),
        .D(state_write__0[1]),
        .Q(state_write[1]),
        .R(axi_awready_i_1_n_0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* DONT_TOUCH *) 
  USR_ACCESSE2 USR_ACCESSE2_inst
       (.CFGCLK(NLW_USR_ACCESSE2_inst_CFGCLK_UNCONNECTED),
        .DATA(USR_ACCESSE2_wire),
        .DATAVALID(NLW_USR_ACCESSE2_inst_DATAVALID_UNCONNECTED));
  LUT1 #(
    .INIT(2'h2)) 
    Version_AXI_insti_0
       (.I0(1'b0),
        .O(USR_ACCESSE2_reg[31]));
  LUT1 #(
    .INIT(2'h2)) 
    Version_AXI_insti_1
       (.I0(1'b0),
        .O(USR_ACCESSE2_reg[30]));
  LUT1 #(
    .INIT(2'h2)) 
    Version_AXI_insti_10
       (.I0(1'b0),
        .O(USR_ACCESSE2_reg[21]));
  LUT1 #(
    .INIT(2'h2)) 
    Version_AXI_insti_11
       (.I0(1'b0),
        .O(USR_ACCESSE2_reg[20]));
  LUT1 #(
    .INIT(2'h2)) 
    Version_AXI_insti_12
       (.I0(1'b0),
        .O(USR_ACCESSE2_reg[19]));
  LUT1 #(
    .INIT(2'h2)) 
    Version_AXI_insti_13
       (.I0(1'b0),
        .O(USR_ACCESSE2_reg[18]));
  LUT1 #(
    .INIT(2'h2)) 
    Version_AXI_insti_14
       (.I0(1'b0),
        .O(USR_ACCESSE2_reg[17]));
  LUT1 #(
    .INIT(2'h2)) 
    Version_AXI_insti_15
       (.I0(1'b0),
        .O(USR_ACCESSE2_reg[16]));
  LUT1 #(
    .INIT(2'h2)) 
    Version_AXI_insti_16
       (.I0(1'b0),
        .O(USR_ACCESSE2_reg[15]));
  LUT1 #(
    .INIT(2'h2)) 
    Version_AXI_insti_17
       (.I0(1'b0),
        .O(USR_ACCESSE2_reg[14]));
  LUT1 #(
    .INIT(2'h2)) 
    Version_AXI_insti_18
       (.I0(1'b0),
        .O(USR_ACCESSE2_reg[13]));
  LUT1 #(
    .INIT(2'h2)) 
    Version_AXI_insti_19
       (.I0(1'b0),
        .O(USR_ACCESSE2_reg[12]));
  LUT1 #(
    .INIT(2'h2)) 
    Version_AXI_insti_2
       (.I0(1'b0),
        .O(USR_ACCESSE2_reg[29]));
  LUT1 #(
    .INIT(2'h2)) 
    Version_AXI_insti_20
       (.I0(1'b0),
        .O(USR_ACCESSE2_reg[11]));
  LUT1 #(
    .INIT(2'h2)) 
    Version_AXI_insti_21
       (.I0(1'b0),
        .O(USR_ACCESSE2_reg[10]));
  LUT1 #(
    .INIT(2'h2)) 
    Version_AXI_insti_22
       (.I0(1'b0),
        .O(USR_ACCESSE2_reg[9]));
  LUT1 #(
    .INIT(2'h2)) 
    Version_AXI_insti_23
       (.I0(1'b0),
        .O(USR_ACCESSE2_reg[8]));
  LUT1 #(
    .INIT(2'h2)) 
    Version_AXI_insti_24
       (.I0(1'b0),
        .O(USR_ACCESSE2_reg[7]));
  LUT1 #(
    .INIT(2'h2)) 
    Version_AXI_insti_25
       (.I0(1'b0),
        .O(USR_ACCESSE2_reg[6]));
  LUT1 #(
    .INIT(2'h2)) 
    Version_AXI_insti_26
       (.I0(1'b0),
        .O(USR_ACCESSE2_reg[5]));
  LUT1 #(
    .INIT(2'h2)) 
    Version_AXI_insti_27
       (.I0(1'b0),
        .O(USR_ACCESSE2_reg[4]));
  LUT1 #(
    .INIT(2'h2)) 
    Version_AXI_insti_28
       (.I0(1'b0),
        .O(USR_ACCESSE2_reg[3]));
  LUT1 #(
    .INIT(2'h2)) 
    Version_AXI_insti_29
       (.I0(1'b0),
        .O(USR_ACCESSE2_reg[2]));
  LUT1 #(
    .INIT(2'h2)) 
    Version_AXI_insti_3
       (.I0(1'b0),
        .O(USR_ACCESSE2_reg[28]));
  LUT1 #(
    .INIT(2'h2)) 
    Version_AXI_insti_30
       (.I0(1'b0),
        .O(USR_ACCESSE2_reg[1]));
  LUT1 #(
    .INIT(2'h2)) 
    Version_AXI_insti_31
       (.I0(1'b0),
        .O(USR_ACCESSE2_reg[0]));
  LUT1 #(
    .INIT(2'h2)) 
    Version_AXI_insti_4
       (.I0(1'b0),
        .O(USR_ACCESSE2_reg[27]));
  LUT1 #(
    .INIT(2'h2)) 
    Version_AXI_insti_5
       (.I0(1'b0),
        .O(USR_ACCESSE2_reg[26]));
  LUT1 #(
    .INIT(2'h2)) 
    Version_AXI_insti_6
       (.I0(1'b0),
        .O(USR_ACCESSE2_reg[25]));
  LUT1 #(
    .INIT(2'h2)) 
    Version_AXI_insti_7
       (.I0(1'b0),
        .O(USR_ACCESSE2_reg[24]));
  LUT1 #(
    .INIT(2'h2)) 
    Version_AXI_insti_8
       (.I0(1'b0),
        .O(USR_ACCESSE2_reg[23]));
  LUT1 #(
    .INIT(2'h2)) 
    Version_AXI_insti_9
       (.I0(1'b0),
        .O(USR_ACCESSE2_reg[22]));
  LUT5 #(
    .INIT(32'h00008000)) 
    \axi_araddr[6]_i_1 
       (.I0(s_axi_aresetn),
        .I1(axi_arready_reg_0),
        .I2(s_axi_arvalid),
        .I3(state_read[0]),
        .I4(state_read[1]),
        .O(\axi_araddr[6]_i_1_n_0 ));
  FDRE \axi_araddr_reg[2] 
       (.C(s_axi_aclk),
        .CE(\axi_araddr[6]_i_1_n_0 ),
        .D(s_axi_araddr[0]),
        .Q(sel0[0]),
        .R(1'b0));
  FDRE \axi_araddr_reg[3] 
       (.C(s_axi_aclk),
        .CE(\axi_araddr[6]_i_1_n_0 ),
        .D(s_axi_araddr[1]),
        .Q(sel0[1]),
        .R(1'b0));
  FDRE \axi_araddr_reg[4] 
       (.C(s_axi_aclk),
        .CE(\axi_araddr[6]_i_1_n_0 ),
        .D(s_axi_araddr[2]),
        .Q(sel0[2]),
        .R(1'b0));
  FDRE \axi_araddr_reg[5] 
       (.C(s_axi_aclk),
        .CE(\axi_araddr[6]_i_1_n_0 ),
        .D(s_axi_araddr[3]),
        .Q(sel0[3]),
        .R(1'b0));
  FDRE \axi_araddr_reg[6] 
       (.C(s_axi_aclk),
        .CE(\axi_araddr[6]_i_1_n_0 ),
        .D(s_axi_araddr[4]),
        .Q(sel0[4]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hC4C4C4C4FFCFCFCF)) 
    axi_arready_i_1
       (.I0(s_axi_arvalid),
        .I1(axi_arready_reg_0),
        .I2(state_read[1]),
        .I3(s_axi_rready),
        .I4(axi_rvalid_reg_0),
        .I5(state_read[0]),
        .O(axi_arready_i_1_n_0));
  FDRE axi_arready_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(axi_arready_i_1_n_0),
        .Q(axi_arready_reg_0),
        .R(axi_awready_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    axi_awready_i_1
       (.I0(s_axi_aresetn),
        .O(axi_awready_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'hCCC4FFCF)) 
    axi_awready_i_2
       (.I0(s_axi_awvalid),
        .I1(axi_awready_reg_0),
        .I2(state_write[1]),
        .I3(s_axi_wvalid),
        .I4(state_write[0]),
        .O(axi_awready_i_2_n_0));
  FDRE axi_awready_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(axi_awready_i_2_n_0),
        .Q(axi_awready_reg_0),
        .R(axi_awready_i_1_n_0));
  LUT6 #(
    .INIT(64'hFBFF3838C3FF0000)) 
    axi_bvalid_i_1
       (.I0(axi_awready0__0),
        .I1(state_write[0]),
        .I2(state_write[1]),
        .I3(s_axi_bready),
        .I4(s_axi_bvalid),
        .I5(s_axi_wvalid),
        .O(axi_bvalid_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h8)) 
    axi_bvalid_i_2
       (.I0(s_axi_awvalid),
        .I1(axi_awready_reg_0),
        .O(axi_awready0__0));
  FDRE axi_bvalid_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(axi_bvalid_i_1_n_0),
        .Q(s_axi_bvalid),
        .R(axi_awready_i_1_n_0));
  LUT6 #(
    .INIT(64'hF0FFFFFF00800080)) 
    axi_rvalid_i_1
       (.I0(axi_arready_reg_0),
        .I1(s_axi_arvalid),
        .I2(state_read[0]),
        .I3(state_read[1]),
        .I4(s_axi_rready),
        .I5(axi_rvalid_reg_0),
        .O(axi_rvalid_i_1_n_0));
  FDRE axi_rvalid_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(axi_rvalid_i_1_n_0),
        .Q(axi_rvalid_reg_0),
        .R(axi_awready_i_1_n_0));
  LUT3 #(
    .INIT(8'hF1)) 
    axi_wready_i_1
       (.I0(state_write[1]),
        .I1(state_write[0]),
        .I2(s_axi_wready),
        .O(axi_wready_i_1_n_0));
  FDRE axi_wready_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(axi_wready_i_1_n_0),
        .Q(s_axi_wready),
        .R(axi_awready_i_1_n_0));
  LUT6 #(
    .INIT(64'h0001011100010110)) 
    \s_axi_rdata[0]_INST_0 
       (.I0(sel0[3]),
        .I1(sel0[4]),
        .I2(sel0[1]),
        .I3(sel0[0]),
        .I4(sel0[2]),
        .I5(USR_ACCESSE2_reg[0]),
        .O(s_axi_rdata[0]));
  LUT6 #(
    .INIT(64'h1111001100000010)) 
    \s_axi_rdata[10]_INST_0 
       (.I0(sel0[3]),
        .I1(sel0[4]),
        .I2(USR_ACCESSE2_reg[10]),
        .I3(sel0[0]),
        .I4(sel0[1]),
        .I5(sel0[2]),
        .O(s_axi_rdata[10]));
  LUT6 #(
    .INIT(64'h1100000000000010)) 
    \s_axi_rdata[11]_INST_0 
       (.I0(sel0[3]),
        .I1(sel0[4]),
        .I2(USR_ACCESSE2_reg[11]),
        .I3(sel0[2]),
        .I4(sel0[1]),
        .I5(sel0[0]),
        .O(s_axi_rdata[11]));
  LUT6 #(
    .INIT(64'h0000000010111010)) 
    \s_axi_rdata[12]_INST_0 
       (.I0(sel0[4]),
        .I1(sel0[3]),
        .I2(sel0[2]),
        .I3(sel0[1]),
        .I4(USR_ACCESSE2_reg[12]),
        .I5(sel0[0]),
        .O(s_axi_rdata[12]));
  LUT6 #(
    .INIT(64'hFFFFFFFFEEEEEEFE)) 
    \s_axi_rdata[13]_INST_0 
       (.I0(sel0[3]),
        .I1(sel0[4]),
        .I2(USR_ACCESSE2_reg[13]),
        .I3(sel0[1]),
        .I4(sel0[0]),
        .I5(sel0[2]),
        .O(s_axi_rdata[13]));
  LUT6 #(
    .INIT(64'h000000000000000E)) 
    \s_axi_rdata[14]_INST_0 
       (.I0(USR_ACCESSE2_reg[14]),
        .I1(sel0[2]),
        .I2(sel0[0]),
        .I3(sel0[1]),
        .I4(sel0[3]),
        .I5(sel0[4]),
        .O(s_axi_rdata[14]));
  LUT6 #(
    .INIT(64'h0000000000000100)) 
    \s_axi_rdata[15]_INST_0 
       (.I0(sel0[0]),
        .I1(sel0[4]),
        .I2(sel0[1]),
        .I3(USR_ACCESSE2_reg[15]),
        .I4(sel0[3]),
        .I5(sel0[2]),
        .O(s_axi_rdata[15]));
  LUT6 #(
    .INIT(64'h000000000000330E)) 
    \s_axi_rdata[16]_INST_0 
       (.I0(USR_ACCESSE2_reg[16]),
        .I1(sel0[1]),
        .I2(sel0[0]),
        .I3(sel0[2]),
        .I4(sel0[4]),
        .I5(sel0[3]),
        .O(s_axi_rdata[16]));
  LUT6 #(
    .INIT(64'h0000111110100100)) 
    \s_axi_rdata[17]_INST_0 
       (.I0(sel0[3]),
        .I1(sel0[4]),
        .I2(sel0[2]),
        .I3(USR_ACCESSE2_reg[17]),
        .I4(sel0[1]),
        .I5(sel0[0]),
        .O(s_axi_rdata[17]));
  LUT6 #(
    .INIT(64'h0100010000010000)) 
    \s_axi_rdata[18]_INST_0 
       (.I0(sel0[4]),
        .I1(sel0[1]),
        .I2(sel0[3]),
        .I3(sel0[2]),
        .I4(USR_ACCESSE2_reg[18]),
        .I5(sel0[0]),
        .O(s_axi_rdata[18]));
  LUT6 #(
    .INIT(64'h0000000010111010)) 
    \s_axi_rdata[19]_INST_0 
       (.I0(sel0[4]),
        .I1(sel0[3]),
        .I2(sel0[2]),
        .I3(sel0[0]),
        .I4(USR_ACCESSE2_reg[19]),
        .I5(sel0[1]),
        .O(s_axi_rdata[19]));
  LUT6 #(
    .INIT(64'h0000000000000AA4)) 
    \s_axi_rdata[1]_INST_0 
       (.I0(sel0[2]),
        .I1(USR_ACCESSE2_reg[1]),
        .I2(sel0[1]),
        .I3(sel0[0]),
        .I4(sel0[4]),
        .I5(sel0[3]),
        .O(s_axi_rdata[1]));
  LUT6 #(
    .INIT(64'h0100010000010000)) 
    \s_axi_rdata[20]_INST_0 
       (.I0(sel0[4]),
        .I1(sel0[0]),
        .I2(sel0[3]),
        .I3(sel0[2]),
        .I4(USR_ACCESSE2_reg[20]),
        .I5(sel0[1]),
        .O(s_axi_rdata[20]));
  LUT6 #(
    .INIT(64'hFFFFFFFFEEEEEEFE)) 
    \s_axi_rdata[21]_INST_0 
       (.I0(sel0[3]),
        .I1(sel0[4]),
        .I2(USR_ACCESSE2_reg[21]),
        .I3(sel0[1]),
        .I4(sel0[0]),
        .I5(sel0[2]),
        .O(s_axi_rdata[21]));
  LUT6 #(
    .INIT(64'h0000000010111010)) 
    \s_axi_rdata[22]_INST_0 
       (.I0(sel0[4]),
        .I1(sel0[3]),
        .I2(sel0[2]),
        .I3(sel0[0]),
        .I4(USR_ACCESSE2_reg[22]),
        .I5(sel0[1]),
        .O(s_axi_rdata[22]));
  LUT6 #(
    .INIT(64'h0000000000000100)) 
    \s_axi_rdata[23]_INST_0 
       (.I0(sel0[0]),
        .I1(sel0[4]),
        .I2(sel0[1]),
        .I3(USR_ACCESSE2_reg[23]),
        .I4(sel0[3]),
        .I5(sel0[2]),
        .O(s_axi_rdata[23]));
  LUT6 #(
    .INIT(64'h000000000000000E)) 
    \s_axi_rdata[24]_INST_0 
       (.I0(USR_ACCESSE2_reg[24]),
        .I1(sel0[1]),
        .I2(sel0[2]),
        .I3(sel0[0]),
        .I4(sel0[3]),
        .I5(sel0[4]),
        .O(s_axi_rdata[24]));
  LUT6 #(
    .INIT(64'h0300000300000002)) 
    \s_axi_rdata[25]_INST_0 
       (.I0(USR_ACCESSE2_reg[25]),
        .I1(sel0[3]),
        .I2(sel0[4]),
        .I3(sel0[1]),
        .I4(sel0[0]),
        .I5(sel0[2]),
        .O(s_axi_rdata[25]));
  LUT6 #(
    .INIT(64'h0000000010111010)) 
    \s_axi_rdata[26]_INST_0 
       (.I0(sel0[4]),
        .I1(sel0[3]),
        .I2(sel0[2]),
        .I3(sel0[0]),
        .I4(USR_ACCESSE2_reg[26]),
        .I5(sel0[1]),
        .O(s_axi_rdata[26]));
  LUT6 #(
    .INIT(64'h0000000000000100)) 
    \s_axi_rdata[27]_INST_0 
       (.I0(sel0[0]),
        .I1(sel0[4]),
        .I2(sel0[1]),
        .I3(USR_ACCESSE2_reg[27]),
        .I4(sel0[3]),
        .I5(sel0[2]),
        .O(s_axi_rdata[27]));
  LUT6 #(
    .INIT(64'h1111001100000010)) 
    \s_axi_rdata[28]_INST_0 
       (.I0(sel0[3]),
        .I1(sel0[4]),
        .I2(USR_ACCESSE2_reg[28]),
        .I3(sel0[0]),
        .I4(sel0[1]),
        .I5(sel0[2]),
        .O(s_axi_rdata[28]));
  LUT6 #(
    .INIT(64'hFEFEFEFEFEFEEFEE)) 
    \s_axi_rdata[29]_INST_0 
       (.I0(sel0[4]),
        .I1(sel0[3]),
        .I2(sel0[2]),
        .I3(USR_ACCESSE2_reg[29]),
        .I4(sel0[1]),
        .I5(sel0[0]),
        .O(s_axi_rdata[29]));
  LUT6 #(
    .INIT(64'h0100010000010000)) 
    \s_axi_rdata[2]_INST_0 
       (.I0(sel0[4]),
        .I1(sel0[0]),
        .I2(sel0[3]),
        .I3(sel0[2]),
        .I4(USR_ACCESSE2_reg[2]),
        .I5(sel0[1]),
        .O(s_axi_rdata[2]));
  LUT6 #(
    .INIT(64'h0000000010111010)) 
    \s_axi_rdata[30]_INST_0 
       (.I0(sel0[4]),
        .I1(sel0[3]),
        .I2(sel0[2]),
        .I3(sel0[0]),
        .I4(USR_ACCESSE2_reg[30]),
        .I5(sel0[1]),
        .O(s_axi_rdata[30]));
  LUT6 #(
    .INIT(64'h0000000000000100)) 
    \s_axi_rdata[31]_INST_0 
       (.I0(sel0[0]),
        .I1(sel0[4]),
        .I2(sel0[1]),
        .I3(USR_ACCESSE2_reg[31]),
        .I4(sel0[3]),
        .I5(sel0[2]),
        .O(s_axi_rdata[31]));
  LUT6 #(
    .INIT(64'h0100010000010000)) 
    \s_axi_rdata[3]_INST_0 
       (.I0(sel0[4]),
        .I1(sel0[0]),
        .I2(sel0[3]),
        .I3(sel0[2]),
        .I4(USR_ACCESSE2_reg[3]),
        .I5(sel0[1]),
        .O(s_axi_rdata[3]));
  LUT6 #(
    .INIT(64'h0000000000006610)) 
    \s_axi_rdata[4]_INST_0 
       (.I0(sel0[2]),
        .I1(sel0[1]),
        .I2(USR_ACCESSE2_reg[4]),
        .I3(sel0[0]),
        .I4(sel0[4]),
        .I5(sel0[3]),
        .O(s_axi_rdata[4]));
  LUT6 #(
    .INIT(64'hFFFEFFFEFEFFFEFE)) 
    \s_axi_rdata[5]_INST_0 
       (.I0(sel0[4]),
        .I1(sel0[2]),
        .I2(sel0[3]),
        .I3(sel0[1]),
        .I4(USR_ACCESSE2_reg[5]),
        .I5(sel0[0]),
        .O(s_axi_rdata[5]));
  LUT6 #(
    .INIT(64'h000000000000500E)) 
    \s_axi_rdata[6]_INST_0 
       (.I0(sel0[2]),
        .I1(USR_ACCESSE2_reg[6]),
        .I2(sel0[1]),
        .I3(sel0[0]),
        .I4(sel0[4]),
        .I5(sel0[3]),
        .O(s_axi_rdata[6]));
  LUT6 #(
    .INIT(64'h0000000000000100)) 
    \s_axi_rdata[7]_INST_0 
       (.I0(sel0[0]),
        .I1(sel0[4]),
        .I2(sel0[1]),
        .I3(USR_ACCESSE2_reg[7]),
        .I4(sel0[3]),
        .I5(sel0[2]),
        .O(s_axi_rdata[7]));
  LUT6 #(
    .INIT(64'h000000000000A00E)) 
    \s_axi_rdata[8]_INST_0 
       (.I0(sel0[1]),
        .I1(USR_ACCESSE2_reg[8]),
        .I2(sel0[2]),
        .I3(sel0[0]),
        .I4(sel0[4]),
        .I5(sel0[3]),
        .O(s_axi_rdata[8]));
  LUT6 #(
    .INIT(64'h000000000000000E)) 
    \s_axi_rdata[9]_INST_0 
       (.I0(USR_ACCESSE2_reg[9]),
        .I1(sel0[2]),
        .I2(sel0[0]),
        .I3(sel0[1]),
        .I4(sel0[3]),
        .I5(sel0[4]),
        .O(s_axi_rdata[9]));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
