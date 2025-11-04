// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// -------------------------------------------------------------------------------

`timescale 1 ps / 1 ps

(* BLOCK_STUB = "true" *)
module spi_tb (
  M_AXI_0_awaddr,
  M_AXI_0_awlen,
  M_AXI_0_awsize,
  M_AXI_0_awburst,
  M_AXI_0_awlock,
  M_AXI_0_awcache,
  M_AXI_0_awprot,
  M_AXI_0_awqos,
  M_AXI_0_awvalid,
  M_AXI_0_awready,
  M_AXI_0_wdata,
  M_AXI_0_wstrb,
  M_AXI_0_wlast,
  M_AXI_0_wvalid,
  M_AXI_0_wready,
  M_AXI_0_bresp,
  M_AXI_0_bvalid,
  M_AXI_0_bready,
  M_AXI_0_araddr,
  M_AXI_0_arlen,
  M_AXI_0_arsize,
  M_AXI_0_arburst,
  M_AXI_0_arlock,
  M_AXI_0_arcache,
  M_AXI_0_arprot,
  M_AXI_0_arqos,
  M_AXI_0_arvalid,
  M_AXI_0_arready,
  M_AXI_0_rdata,
  M_AXI_0_rresp,
  M_AXI_0_rlast,
  M_AXI_0_rvalid,
  M_AXI_0_rready,
  aclk,
  aresetn,
  cs_n,
  miso,
  mosi,
  pdi,
  sclk,
  start
);

  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 AWADDR" *)
  (* X_INTERFACE_MODE = "master M_AXI_0" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M_AXI_0, DATA_WIDTH 32, PROTOCOL AXI4, FREQ_HZ 100000000, ID_WIDTH 0, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 256, PHASE 0.0, CLK_DOMAIN spi_tb_aclk, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *)
  output [31:0]M_AXI_0_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 AWLEN" *)
  output [7:0]M_AXI_0_awlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 AWSIZE" *)
  output [2:0]M_AXI_0_awsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 AWBURST" *)
  output [1:0]M_AXI_0_awburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 AWLOCK" *)
  output [0:0]M_AXI_0_awlock;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 AWCACHE" *)
  output [3:0]M_AXI_0_awcache;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 AWPROT" *)
  output [2:0]M_AXI_0_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 AWQOS" *)
  output [3:0]M_AXI_0_awqos;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 AWVALID" *)
  output M_AXI_0_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 AWREADY" *)
  input M_AXI_0_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 WDATA" *)
  output [31:0]M_AXI_0_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 WSTRB" *)
  output [3:0]M_AXI_0_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 WLAST" *)
  output M_AXI_0_wlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 WVALID" *)
  output M_AXI_0_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 WREADY" *)
  input M_AXI_0_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 BRESP" *)
  input [1:0]M_AXI_0_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 BVALID" *)
  input M_AXI_0_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 BREADY" *)
  output M_AXI_0_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 ARADDR" *)
  output [31:0]M_AXI_0_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 ARLEN" *)
  output [7:0]M_AXI_0_arlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 ARSIZE" *)
  output [2:0]M_AXI_0_arsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 ARBURST" *)
  output [1:0]M_AXI_0_arburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 ARLOCK" *)
  output [0:0]M_AXI_0_arlock;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 ARCACHE" *)
  output [3:0]M_AXI_0_arcache;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 ARPROT" *)
  output [2:0]M_AXI_0_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 ARQOS" *)
  output [3:0]M_AXI_0_arqos;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 ARVALID" *)
  output M_AXI_0_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 ARREADY" *)
  input M_AXI_0_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 RDATA" *)
  input [31:0]M_AXI_0_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 RRESP" *)
  input [1:0]M_AXI_0_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 RLAST" *)
  input M_AXI_0_rlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 RVALID" *)
  input M_AXI_0_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 RREADY" *)
  output M_AXI_0_rready;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.ACLK CLK" *)
  (* X_INTERFACE_MODE = "slave CLK.ACLK" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.ACLK, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN spi_tb_aclk, ASSOCIATED_BUSIF M_AXI_0, ASSOCIATED_RESET aresetn, INSERT_VIP 0" *)
  input aclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.ARESETN RST" *)
  (* X_INTERFACE_MODE = "slave RST.ARESETN" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.ARESETN, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
  input aresetn;
  (* X_INTERFACE_IGNORE = "true" *)
  output cs_n;
  (* X_INTERFACE_IGNORE = "true" *)
  input miso;
  (* X_INTERFACE_IGNORE = "true" *)
  output mosi;
  (* X_INTERFACE_IGNORE = "true" *)
  output pdi;
  (* X_INTERFACE_IGNORE = "true" *)
  output sclk;
  (* X_INTERFACE_IGNORE = "true" *)
  input start;

  // stub module has no contents

endmodule
