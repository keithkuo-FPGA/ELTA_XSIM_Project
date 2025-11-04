//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.2 (win64) Build 5239630 Fri Nov 08 22:35:27 MST 2024
//Date        : Thu Sep 18 10:07:10 2025
//Host        : FPGA_LAX running 64-bit major release  (build 9200)
//Command     : generate_target spi_tb_wrapper.bd
//Design      : spi_tb_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module spi_tb_wrapper
   (M_AXI_0_araddr,
    M_AXI_0_arburst,
    M_AXI_0_arcache,
    M_AXI_0_arlen,
    M_AXI_0_arlock,
    M_AXI_0_arprot,
    M_AXI_0_arqos,
    M_AXI_0_arready,
    M_AXI_0_arsize,
    M_AXI_0_arvalid,
    M_AXI_0_awaddr,
    M_AXI_0_awburst,
    M_AXI_0_awcache,
    M_AXI_0_awlen,
    M_AXI_0_awlock,
    M_AXI_0_awprot,
    M_AXI_0_awqos,
    M_AXI_0_awready,
    M_AXI_0_awsize,
    M_AXI_0_awvalid,
    M_AXI_0_bready,
    M_AXI_0_bresp,
    M_AXI_0_bvalid,
    M_AXI_0_rdata,
    M_AXI_0_rlast,
    M_AXI_0_rready,
    M_AXI_0_rresp,
    M_AXI_0_rvalid,
    M_AXI_0_wdata,
    M_AXI_0_wlast,
    M_AXI_0_wready,
    M_AXI_0_wstrb,
    M_AXI_0_wvalid,
    aclk,
    aresetn,
    cs_n,
    miso,
    mosi,
    pdi,
    sclk,
    start);
  output [31:0]M_AXI_0_araddr;
  output [1:0]M_AXI_0_arburst;
  output [3:0]M_AXI_0_arcache;
  output [7:0]M_AXI_0_arlen;
  output [0:0]M_AXI_0_arlock;
  output [2:0]M_AXI_0_arprot;
  output [3:0]M_AXI_0_arqos;
  input M_AXI_0_arready;
  output [2:0]M_AXI_0_arsize;
  output M_AXI_0_arvalid;
  output [31:0]M_AXI_0_awaddr;
  output [1:0]M_AXI_0_awburst;
  output [3:0]M_AXI_0_awcache;
  output [7:0]M_AXI_0_awlen;
  output [0:0]M_AXI_0_awlock;
  output [2:0]M_AXI_0_awprot;
  output [3:0]M_AXI_0_awqos;
  input M_AXI_0_awready;
  output [2:0]M_AXI_0_awsize;
  output M_AXI_0_awvalid;
  output M_AXI_0_bready;
  input [1:0]M_AXI_0_bresp;
  input M_AXI_0_bvalid;
  input [31:0]M_AXI_0_rdata;
  input M_AXI_0_rlast;
  output M_AXI_0_rready;
  input [1:0]M_AXI_0_rresp;
  input M_AXI_0_rvalid;
  output [31:0]M_AXI_0_wdata;
  output M_AXI_0_wlast;
  input M_AXI_0_wready;
  output [3:0]M_AXI_0_wstrb;
  output M_AXI_0_wvalid;
  input aclk;
  input aresetn;
  output cs_n;
  input miso;
  output mosi;
  output pdi;
  output sclk;
  input start;

  wire [31:0]M_AXI_0_araddr;
  wire [1:0]M_AXI_0_arburst;
  wire [3:0]M_AXI_0_arcache;
  wire [7:0]M_AXI_0_arlen;
  wire [0:0]M_AXI_0_arlock;
  wire [2:0]M_AXI_0_arprot;
  wire [3:0]M_AXI_0_arqos;
  wire M_AXI_0_arready;
  wire [2:0]M_AXI_0_arsize;
  wire M_AXI_0_arvalid;
  wire [31:0]M_AXI_0_awaddr;
  wire [1:0]M_AXI_0_awburst;
  wire [3:0]M_AXI_0_awcache;
  wire [7:0]M_AXI_0_awlen;
  wire [0:0]M_AXI_0_awlock;
  wire [2:0]M_AXI_0_awprot;
  wire [3:0]M_AXI_0_awqos;
  wire M_AXI_0_awready;
  wire [2:0]M_AXI_0_awsize;
  wire M_AXI_0_awvalid;
  wire M_AXI_0_bready;
  wire [1:0]M_AXI_0_bresp;
  wire M_AXI_0_bvalid;
  wire [31:0]M_AXI_0_rdata;
  wire M_AXI_0_rlast;
  wire M_AXI_0_rready;
  wire [1:0]M_AXI_0_rresp;
  wire M_AXI_0_rvalid;
  wire [31:0]M_AXI_0_wdata;
  wire M_AXI_0_wlast;
  wire M_AXI_0_wready;
  wire [3:0]M_AXI_0_wstrb;
  wire M_AXI_0_wvalid;
  wire aclk;
  wire aresetn;
  wire cs_n;
  wire miso;
  wire mosi;
  wire pdi;
  wire sclk;
  wire start;

  spi_tb spi_tb_i
       (.M_AXI_0_araddr(M_AXI_0_araddr),
        .M_AXI_0_arburst(M_AXI_0_arburst),
        .M_AXI_0_arcache(M_AXI_0_arcache),
        .M_AXI_0_arlen(M_AXI_0_arlen),
        .M_AXI_0_arlock(M_AXI_0_arlock),
        .M_AXI_0_arprot(M_AXI_0_arprot),
        .M_AXI_0_arqos(M_AXI_0_arqos),
        .M_AXI_0_arready(M_AXI_0_arready),
        .M_AXI_0_arsize(M_AXI_0_arsize),
        .M_AXI_0_arvalid(M_AXI_0_arvalid),
        .M_AXI_0_awaddr(M_AXI_0_awaddr),
        .M_AXI_0_awburst(M_AXI_0_awburst),
        .M_AXI_0_awcache(M_AXI_0_awcache),
        .M_AXI_0_awlen(M_AXI_0_awlen),
        .M_AXI_0_awlock(M_AXI_0_awlock),
        .M_AXI_0_awprot(M_AXI_0_awprot),
        .M_AXI_0_awqos(M_AXI_0_awqos),
        .M_AXI_0_awready(M_AXI_0_awready),
        .M_AXI_0_awsize(M_AXI_0_awsize),
        .M_AXI_0_awvalid(M_AXI_0_awvalid),
        .M_AXI_0_bready(M_AXI_0_bready),
        .M_AXI_0_bresp(M_AXI_0_bresp),
        .M_AXI_0_bvalid(M_AXI_0_bvalid),
        .M_AXI_0_rdata(M_AXI_0_rdata),
        .M_AXI_0_rlast(M_AXI_0_rlast),
        .M_AXI_0_rready(M_AXI_0_rready),
        .M_AXI_0_rresp(M_AXI_0_rresp),
        .M_AXI_0_rvalid(M_AXI_0_rvalid),
        .M_AXI_0_wdata(M_AXI_0_wdata),
        .M_AXI_0_wlast(M_AXI_0_wlast),
        .M_AXI_0_wready(M_AXI_0_wready),
        .M_AXI_0_wstrb(M_AXI_0_wstrb),
        .M_AXI_0_wvalid(M_AXI_0_wvalid),
        .aclk(aclk),
        .aresetn(aresetn),
        .cs_n(cs_n),
        .miso(miso),
        .mosi(mosi),
        .pdi(pdi),
        .sclk(sclk),
        .start(start));
endmodule
