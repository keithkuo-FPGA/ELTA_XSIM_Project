//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.2 (win64) Build 5239630 Fri Nov 08 22:35:27 MST 2024
//Date        : Thu Sep 18 10:07:10 2025
//Host        : FPGA_LAX running 64-bit major release  (build 9200)
//Command     : generate_target spi_tb.bd
//Design      : spi_tb
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "spi_tb,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=spi_tb,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=4,numReposBlks=4,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=2,numPkgbdBlks=0,bdsource=USER,synth_mode=Hierarchical}" *) (* HW_HANDOFF = "spi_tb.hwdef" *) 
module spi_tb
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
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 ARADDR" *) (* X_INTERFACE_MODE = "Master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M_AXI_0, ADDR_WIDTH 32, ARUSER_WIDTH 0, AWUSER_WIDTH 0, BUSER_WIDTH 0, CLK_DOMAIN spi_tb_aclk, DATA_WIDTH 32, FREQ_HZ 100000000, HAS_BRESP 1, HAS_BURST 1, HAS_CACHE 1, HAS_LOCK 1, HAS_PROT 1, HAS_QOS 1, HAS_REGION 0, HAS_RRESP 1, HAS_WSTRB 1, ID_WIDTH 0, INSERT_VIP 0, MAX_BURST_LENGTH 256, NUM_READ_OUTSTANDING 2, NUM_READ_THREADS 1, NUM_WRITE_OUTSTANDING 2, NUM_WRITE_THREADS 1, PHASE 0.0, PROTOCOL AXI4, READ_WRITE_MODE READ_WRITE, RUSER_BITS_PER_BYTE 0, RUSER_WIDTH 0, SUPPORTS_NARROW_BURST 0, WUSER_BITS_PER_BYTE 0, WUSER_WIDTH 0" *) output [31:0]M_AXI_0_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 ARBURST" *) output [1:0]M_AXI_0_arburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 ARCACHE" *) output [3:0]M_AXI_0_arcache;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 ARLEN" *) output [7:0]M_AXI_0_arlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 ARLOCK" *) output [0:0]M_AXI_0_arlock;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 ARPROT" *) output [2:0]M_AXI_0_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 ARQOS" *) output [3:0]M_AXI_0_arqos;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 ARREADY" *) input M_AXI_0_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 ARSIZE" *) output [2:0]M_AXI_0_arsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 ARVALID" *) output M_AXI_0_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 AWADDR" *) output [31:0]M_AXI_0_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 AWBURST" *) output [1:0]M_AXI_0_awburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 AWCACHE" *) output [3:0]M_AXI_0_awcache;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 AWLEN" *) output [7:0]M_AXI_0_awlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 AWLOCK" *) output [0:0]M_AXI_0_awlock;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 AWPROT" *) output [2:0]M_AXI_0_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 AWQOS" *) output [3:0]M_AXI_0_awqos;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 AWREADY" *) input M_AXI_0_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 AWSIZE" *) output [2:0]M_AXI_0_awsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 AWVALID" *) output M_AXI_0_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 BREADY" *) output M_AXI_0_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 BRESP" *) input [1:0]M_AXI_0_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 BVALID" *) input M_AXI_0_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 RDATA" *) input [31:0]M_AXI_0_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 RLAST" *) input M_AXI_0_rlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 RREADY" *) output M_AXI_0_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 RRESP" *) input [1:0]M_AXI_0_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 RVALID" *) input M_AXI_0_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 WDATA" *) output [31:0]M_AXI_0_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 WLAST" *) output M_AXI_0_wlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 WREADY" *) input M_AXI_0_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 WSTRB" *) output [3:0]M_AXI_0_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_0 WVALID" *) output M_AXI_0_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.ACLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.ACLK, ASSOCIATED_BUSIF M_AXI_0, ASSOCIATED_RESET aresetn, CLK_DOMAIN spi_tb_aclk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) input aclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.ARESETN RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.ARESETN, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input aresetn;
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
  wire [31:0]axi_vip_0_M_AXI_ARADDR;
  wire [7:0]axi_vip_0_M_AXI_ARLEN;
  wire [2:0]axi_vip_0_M_AXI_ARPROT;
  wire axi_vip_0_M_AXI_ARREADY;
  wire axi_vip_0_M_AXI_ARVALID;
  wire [31:0]axi_vip_0_M_AXI_AWADDR;
  wire [7:0]axi_vip_0_M_AXI_AWLEN;
  wire [2:0]axi_vip_0_M_AXI_AWPROT;
  wire axi_vip_0_M_AXI_AWREADY;
  wire axi_vip_0_M_AXI_AWVALID;
  wire axi_vip_0_M_AXI_BREADY;
  wire [1:0]axi_vip_0_M_AXI_BRESP;
  wire axi_vip_0_M_AXI_BVALID;
  wire [31:0]axi_vip_0_M_AXI_RDATA;
  wire axi_vip_0_M_AXI_RLAST;
  wire axi_vip_0_M_AXI_RREADY;
  wire axi_vip_0_M_AXI_RVALID;
  wire [31:0]axi_vip_0_M_AXI_WDATA;
  wire axi_vip_0_M_AXI_WLAST;
  wire axi_vip_0_M_AXI_WREADY;
  wire [3:0]axi_vip_0_M_AXI_WSTRB;
  wire axi_vip_0_M_AXI_WVALID;
  wire cs_n;
  wire miso;
  wire mosi;
  wire pdi;
  wire sclk;
  wire [23:0]smartconnect_0_M00_AXI_ARADDR;
  wire [2:0]smartconnect_0_M00_AXI_ARPROT;
  wire smartconnect_0_M00_AXI_ARREADY;
  wire smartconnect_0_M00_AXI_ARVALID;
  wire [23:0]smartconnect_0_M00_AXI_AWADDR;
  wire [2:0]smartconnect_0_M00_AXI_AWPROT;
  wire smartconnect_0_M00_AXI_AWREADY;
  wire smartconnect_0_M00_AXI_AWVALID;
  wire smartconnect_0_M00_AXI_BREADY;
  wire [1:0]smartconnect_0_M00_AXI_BRESP;
  wire smartconnect_0_M00_AXI_BVALID;
  wire [31:0]smartconnect_0_M00_AXI_RDATA;
  wire smartconnect_0_M00_AXI_RREADY;
  wire [1:0]smartconnect_0_M00_AXI_RRESP;
  wire smartconnect_0_M00_AXI_RVALID;
  wire [31:0]smartconnect_0_M00_AXI_WDATA;
  wire smartconnect_0_M00_AXI_WREADY;
  wire [3:0]smartconnect_0_M00_AXI_WSTRB;
  wire smartconnect_0_M00_AXI_WVALID;
  wire [6:0]smartconnect_0_M02_AXI_ARADDR;
  wire [2:0]smartconnect_0_M02_AXI_ARPROT;
  wire smartconnect_0_M02_AXI_ARREADY;
  wire smartconnect_0_M02_AXI_ARVALID;
  wire [6:0]smartconnect_0_M02_AXI_AWADDR;
  wire [2:0]smartconnect_0_M02_AXI_AWPROT;
  wire smartconnect_0_M02_AXI_AWREADY;
  wire smartconnect_0_M02_AXI_AWVALID;
  wire smartconnect_0_M02_AXI_BREADY;
  wire [1:0]smartconnect_0_M02_AXI_BRESP;
  wire smartconnect_0_M02_AXI_BVALID;
  wire [31:0]smartconnect_0_M02_AXI_RDATA;
  wire smartconnect_0_M02_AXI_RREADY;
  wire [1:0]smartconnect_0_M02_AXI_RRESP;
  wire smartconnect_0_M02_AXI_RVALID;
  wire [31:0]smartconnect_0_M02_AXI_WDATA;
  wire smartconnect_0_M02_AXI_WREADY;
  wire [3:0]smartconnect_0_M02_AXI_WSTRB;
  wire smartconnect_0_M02_AXI_WVALID;
  wire start;

  spi_tb_Version_0_0 Version_0
       (.s_axi_aclk(aclk),
        .s_axi_araddr(smartconnect_0_M02_AXI_ARADDR),
        .s_axi_aresetn(aresetn),
        .s_axi_arprot(smartconnect_0_M02_AXI_ARPROT),
        .s_axi_arready(smartconnect_0_M02_AXI_ARREADY),
        .s_axi_arvalid(smartconnect_0_M02_AXI_ARVALID),
        .s_axi_awaddr(smartconnect_0_M02_AXI_AWADDR),
        .s_axi_awprot(smartconnect_0_M02_AXI_AWPROT),
        .s_axi_awready(smartconnect_0_M02_AXI_AWREADY),
        .s_axi_awvalid(smartconnect_0_M02_AXI_AWVALID),
        .s_axi_bready(smartconnect_0_M02_AXI_BREADY),
        .s_axi_bresp(smartconnect_0_M02_AXI_BRESP),
        .s_axi_bvalid(smartconnect_0_M02_AXI_BVALID),
        .s_axi_rdata(smartconnect_0_M02_AXI_RDATA),
        .s_axi_rready(smartconnect_0_M02_AXI_RREADY),
        .s_axi_rresp(smartconnect_0_M02_AXI_RRESP),
        .s_axi_rvalid(smartconnect_0_M02_AXI_RVALID),
        .s_axi_wdata(smartconnect_0_M02_AXI_WDATA),
        .s_axi_wready(smartconnect_0_M02_AXI_WREADY),
        .s_axi_wstrb(smartconnect_0_M02_AXI_WSTRB),
        .s_axi_wvalid(smartconnect_0_M02_AXI_WVALID));
  spi_tb_axi_spi_top_0_5 axi_spi_top_0
       (.cs_n(cs_n),
        .miso(miso),
        .mosi(mosi),
        .pdi(pdi),
        .s00_axi_aclk(aclk),
        .s00_axi_araddr(smartconnect_0_M00_AXI_ARADDR),
        .s00_axi_aresetn(aresetn),
        .s00_axi_arprot(smartconnect_0_M00_AXI_ARPROT),
        .s00_axi_arready(smartconnect_0_M00_AXI_ARREADY),
        .s00_axi_arvalid(smartconnect_0_M00_AXI_ARVALID),
        .s00_axi_awaddr(smartconnect_0_M00_AXI_AWADDR),
        .s00_axi_awprot(smartconnect_0_M00_AXI_AWPROT),
        .s00_axi_awready(smartconnect_0_M00_AXI_AWREADY),
        .s00_axi_awvalid(smartconnect_0_M00_AXI_AWVALID),
        .s00_axi_bready(smartconnect_0_M00_AXI_BREADY),
        .s00_axi_bresp(smartconnect_0_M00_AXI_BRESP),
        .s00_axi_bvalid(smartconnect_0_M00_AXI_BVALID),
        .s00_axi_rdata(smartconnect_0_M00_AXI_RDATA),
        .s00_axi_rready(smartconnect_0_M00_AXI_RREADY),
        .s00_axi_rresp(smartconnect_0_M00_AXI_RRESP),
        .s00_axi_rvalid(smartconnect_0_M00_AXI_RVALID),
        .s00_axi_wdata(smartconnect_0_M00_AXI_WDATA),
        .s00_axi_wready(smartconnect_0_M00_AXI_WREADY),
        .s00_axi_wstrb(smartconnect_0_M00_AXI_WSTRB),
        .s00_axi_wvalid(smartconnect_0_M00_AXI_WVALID),
        .sclk(sclk),
        .spi_Mclk(aclk),
        .spi_ressetn(aresetn),
        .start(1'b0));
  spi_tb_axi_vip_0_0 axi_vip_0
       (.aclk(aclk),
        .aresetn(aresetn),
        .m_axi_araddr(axi_vip_0_M_AXI_ARADDR),
        .m_axi_arlen(axi_vip_0_M_AXI_ARLEN),
        .m_axi_arprot(axi_vip_0_M_AXI_ARPROT),
        .m_axi_arready(axi_vip_0_M_AXI_ARREADY),
        .m_axi_arvalid(axi_vip_0_M_AXI_ARVALID),
        .m_axi_awaddr(axi_vip_0_M_AXI_AWADDR),
        .m_axi_awlen(axi_vip_0_M_AXI_AWLEN),
        .m_axi_awprot(axi_vip_0_M_AXI_AWPROT),
        .m_axi_awready(axi_vip_0_M_AXI_AWREADY),
        .m_axi_awvalid(axi_vip_0_M_AXI_AWVALID),
        .m_axi_bready(axi_vip_0_M_AXI_BREADY),
        .m_axi_bresp(axi_vip_0_M_AXI_BRESP),
        .m_axi_bvalid(axi_vip_0_M_AXI_BVALID),
        .m_axi_rdata(axi_vip_0_M_AXI_RDATA),
        .m_axi_rlast(axi_vip_0_M_AXI_RLAST),
        .m_axi_rready(axi_vip_0_M_AXI_RREADY),
        .m_axi_rvalid(axi_vip_0_M_AXI_RVALID),
        .m_axi_wdata(axi_vip_0_M_AXI_WDATA),
        .m_axi_wlast(axi_vip_0_M_AXI_WLAST),
        .m_axi_wready(axi_vip_0_M_AXI_WREADY),
        .m_axi_wstrb(axi_vip_0_M_AXI_WSTRB),
        .m_axi_wvalid(axi_vip_0_M_AXI_WVALID));
  spi_tb_smartconnect_0_0 smartconnect_0
       (.M00_AXI_araddr(smartconnect_0_M00_AXI_ARADDR),
        .M00_AXI_arprot(smartconnect_0_M00_AXI_ARPROT),
        .M00_AXI_arready(smartconnect_0_M00_AXI_ARREADY),
        .M00_AXI_arvalid(smartconnect_0_M00_AXI_ARVALID),
        .M00_AXI_awaddr(smartconnect_0_M00_AXI_AWADDR),
        .M00_AXI_awprot(smartconnect_0_M00_AXI_AWPROT),
        .M00_AXI_awready(smartconnect_0_M00_AXI_AWREADY),
        .M00_AXI_awvalid(smartconnect_0_M00_AXI_AWVALID),
        .M00_AXI_bready(smartconnect_0_M00_AXI_BREADY),
        .M00_AXI_bresp(smartconnect_0_M00_AXI_BRESP),
        .M00_AXI_bvalid(smartconnect_0_M00_AXI_BVALID),
        .M00_AXI_rdata(smartconnect_0_M00_AXI_RDATA),
        .M00_AXI_rready(smartconnect_0_M00_AXI_RREADY),
        .M00_AXI_rresp(smartconnect_0_M00_AXI_RRESP),
        .M00_AXI_rvalid(smartconnect_0_M00_AXI_RVALID),
        .M00_AXI_wdata(smartconnect_0_M00_AXI_WDATA),
        .M00_AXI_wready(smartconnect_0_M00_AXI_WREADY),
        .M00_AXI_wstrb(smartconnect_0_M00_AXI_WSTRB),
        .M00_AXI_wvalid(smartconnect_0_M00_AXI_WVALID),
        .M01_AXI_araddr(M_AXI_0_araddr),
        .M01_AXI_arburst(M_AXI_0_arburst),
        .M01_AXI_arcache(M_AXI_0_arcache),
        .M01_AXI_arlen(M_AXI_0_arlen),
        .M01_AXI_arlock(M_AXI_0_arlock),
        .M01_AXI_arprot(M_AXI_0_arprot),
        .M01_AXI_arqos(M_AXI_0_arqos),
        .M01_AXI_arready(M_AXI_0_arready),
        .M01_AXI_arsize(M_AXI_0_arsize),
        .M01_AXI_arvalid(M_AXI_0_arvalid),
        .M01_AXI_awaddr(M_AXI_0_awaddr),
        .M01_AXI_awburst(M_AXI_0_awburst),
        .M01_AXI_awcache(M_AXI_0_awcache),
        .M01_AXI_awlen(M_AXI_0_awlen),
        .M01_AXI_awlock(M_AXI_0_awlock),
        .M01_AXI_awprot(M_AXI_0_awprot),
        .M01_AXI_awqos(M_AXI_0_awqos),
        .M01_AXI_awready(M_AXI_0_awready),
        .M01_AXI_awsize(M_AXI_0_awsize),
        .M01_AXI_awvalid(M_AXI_0_awvalid),
        .M01_AXI_bready(M_AXI_0_bready),
        .M01_AXI_bresp(M_AXI_0_bresp),
        .M01_AXI_bvalid(M_AXI_0_bvalid),
        .M01_AXI_rdata(M_AXI_0_rdata),
        .M01_AXI_rlast(M_AXI_0_rlast),
        .M01_AXI_rready(M_AXI_0_rready),
        .M01_AXI_rresp(M_AXI_0_rresp),
        .M01_AXI_rvalid(M_AXI_0_rvalid),
        .M01_AXI_wdata(M_AXI_0_wdata),
        .M01_AXI_wlast(M_AXI_0_wlast),
        .M01_AXI_wready(M_AXI_0_wready),
        .M01_AXI_wstrb(M_AXI_0_wstrb),
        .M01_AXI_wvalid(M_AXI_0_wvalid),
        .M02_AXI_araddr(smartconnect_0_M02_AXI_ARADDR),
        .M02_AXI_arprot(smartconnect_0_M02_AXI_ARPROT),
        .M02_AXI_arready(smartconnect_0_M02_AXI_ARREADY),
        .M02_AXI_arvalid(smartconnect_0_M02_AXI_ARVALID),
        .M02_AXI_awaddr(smartconnect_0_M02_AXI_AWADDR),
        .M02_AXI_awprot(smartconnect_0_M02_AXI_AWPROT),
        .M02_AXI_awready(smartconnect_0_M02_AXI_AWREADY),
        .M02_AXI_awvalid(smartconnect_0_M02_AXI_AWVALID),
        .M02_AXI_bready(smartconnect_0_M02_AXI_BREADY),
        .M02_AXI_bresp(smartconnect_0_M02_AXI_BRESP),
        .M02_AXI_bvalid(smartconnect_0_M02_AXI_BVALID),
        .M02_AXI_rdata(smartconnect_0_M02_AXI_RDATA),
        .M02_AXI_rready(smartconnect_0_M02_AXI_RREADY),
        .M02_AXI_rresp(smartconnect_0_M02_AXI_RRESP),
        .M02_AXI_rvalid(smartconnect_0_M02_AXI_RVALID),
        .M02_AXI_wdata(smartconnect_0_M02_AXI_WDATA),
        .M02_AXI_wready(smartconnect_0_M02_AXI_WREADY),
        .M02_AXI_wstrb(smartconnect_0_M02_AXI_WSTRB),
        .M02_AXI_wvalid(smartconnect_0_M02_AXI_WVALID),
        .S00_AXI_araddr(axi_vip_0_M_AXI_ARADDR),
        .S00_AXI_arburst({1'b0,1'b1}),
        .S00_AXI_arcache({1'b0,1'b0,1'b1,1'b1}),
        .S00_AXI_arlen(axi_vip_0_M_AXI_ARLEN),
        .S00_AXI_arlock(1'b0),
        .S00_AXI_arprot(axi_vip_0_M_AXI_ARPROT),
        .S00_AXI_arqos({1'b0,1'b0,1'b0,1'b0}),
        .S00_AXI_arready(axi_vip_0_M_AXI_ARREADY),
        .S00_AXI_arsize({1'b0,1'b1,1'b0}),
        .S00_AXI_arvalid(axi_vip_0_M_AXI_ARVALID),
        .S00_AXI_awaddr(axi_vip_0_M_AXI_AWADDR),
        .S00_AXI_awburst({1'b0,1'b1}),
        .S00_AXI_awcache({1'b0,1'b0,1'b1,1'b1}),
        .S00_AXI_awlen(axi_vip_0_M_AXI_AWLEN),
        .S00_AXI_awlock(1'b0),
        .S00_AXI_awprot(axi_vip_0_M_AXI_AWPROT),
        .S00_AXI_awqos({1'b0,1'b0,1'b0,1'b0}),
        .S00_AXI_awready(axi_vip_0_M_AXI_AWREADY),
        .S00_AXI_awsize({1'b0,1'b1,1'b0}),
        .S00_AXI_awvalid(axi_vip_0_M_AXI_AWVALID),
        .S00_AXI_bready(axi_vip_0_M_AXI_BREADY),
        .S00_AXI_bresp(axi_vip_0_M_AXI_BRESP),
        .S00_AXI_bvalid(axi_vip_0_M_AXI_BVALID),
        .S00_AXI_rdata(axi_vip_0_M_AXI_RDATA),
        .S00_AXI_rlast(axi_vip_0_M_AXI_RLAST),
        .S00_AXI_rready(axi_vip_0_M_AXI_RREADY),
        .S00_AXI_rvalid(axi_vip_0_M_AXI_RVALID),
        .S00_AXI_wdata(axi_vip_0_M_AXI_WDATA),
        .S00_AXI_wlast(axi_vip_0_M_AXI_WLAST),
        .S00_AXI_wready(axi_vip_0_M_AXI_WREADY),
        .S00_AXI_wstrb(axi_vip_0_M_AXI_WSTRB),
        .S00_AXI_wvalid(axi_vip_0_M_AXI_WVALID),
        .aclk(aclk),
        .aresetn(aresetn));
endmodule
