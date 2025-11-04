`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:
// Design Name: 
// Module Name: 
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


import axi_vip_pkg::*;
import spi_tb_axi_vip_0_0_pkg::*;

parameter Tc0 = 5    ; // freq = 100MHz
parameter Td0 = Tc0*2; 

parameter integer ver_base_addr             = 32'hA0000000;
parameter integer spi_base_address			= 32'h00000000;
//Ctrl command
parameter integer spi_base_address1	 		= spi_base_address 	+	32'h04	;
//Address
parameter integer spi_base_address2 		= spi_base_address 	+	32'h08	;
//Data
parameter integer spi_base_address3 		= spi_base_address 	+	32'h0C	;
parameter integer spi_base_address4	 		= spi_base_address 	+	32'h10	;
//Broadcast control
parameter integer spi_base_address5 		= spi_base_address 	+	32'h14	;
//Standard payload
parameter integer spi_base_address6 		= spi_base_address 	+	32'h18	;
parameter integer spi_base_address7 		= spi_base_address 	+	32'h1C	;
//Standard rx data
parameter integer spi_base_address8 		= spi_base_address 	+	32'h20	;
parameter integer spi_base_address9 		= spi_base_address 	+	32'h24	;
//Daisy-Chain
parameter integer spi_base_address10 		= spi_base_address 	+	32'h28	;
parameter integer spi_base_address11 		= spi_base_address 	+	32'h2C	;
parameter integer spi_base_address12 		= spi_base_address 	+	32'h30	;
parameter integer spi_base_address13 		= spi_base_address 	+	32'h34	;
parameter integer spi_base_address14 		= spi_base_address 	+	32'h38	;
parameter integer spi_base_address15 		= spi_base_address 	+	32'h3C	;
parameter integer spi_base_address16 		= spi_base_address 	+	32'h40	;
parameter integer spi_base_address17 		= spi_base_address 	+	32'h44	;
//
parameter integer fifo_state_address1 		= spi_base_address 	+	32'h68	;
// Parameters of Axi Slave Bus Interface S_AXI
parameter integer         S_AXI_DATA_WIDTH	        = 32;
parameter integer         S_AXI_ADDR_WIDTH	        = 7;

xil_axi_resp_t 	resp;
xil_axi_prot_t  prot = 0;

localparam int MAX_POLL        = 100000;   // 防卡死上限
localparam int POLL_GAP_CYCLES = 10;       // 每次讀之間隔的時脈週期數(可設0做back-to-back)

module ip_tb();

	bit clk300 = 0, clk100 = 0, rst_n = 0;
	always #3ns clk300 =  ~clk300;
	always #(Tc0) clk100 =  ~clk100;
	wire sclk   ;
	wire cs_n  ;
	wire mosi  ;
	wire miso  ;
    wire sdi   ;
    wire pdi   ;
    wire sdo   ;
	wire done  ;

    wire [63:0] d0_wdao_0;
    wire        d0_wvld_0;
    wire [63:0] d0_wdao_1;
    wire        d0_wvld_1;
    wire [63:0] d0_wdao_2;
    wire        d0_wvld_2;
    wire [63:0] d0_wdao_3;
    wire        d0_wvld_3;

    reg [31:0] data_buffer = 0;
    reg [31:0] addr;

    reg [31:0] tries;

    //-------------------------------------------------------------
    wire                                      s_axi_aclk;
    wire                                      s_axi_aresetn;
    wire        [S_AXI_ADDR_WIDTH-1 : 0]      s_axi_awaddr;
    wire        [2:0]                         s_axi_awprot;
    wire                                      s_axi_awvalid;
    wire                                      s_axi_awready;
    wire        [S_AXI_DATA_WIDTH-1 : 0]      s_axi_wdata;
    wire        [(S_AXI_DATA_WIDTH/8)-1 : 0]  s_axi_wstrb;
    wire                                      s_axi_wvalid;
    wire                                      s_axi_wready;
    wire        [1:0]                         s_axi_bresp;
    wire                                      s_axi_bvalid;
    wire                                      s_axi_bready;
    wire        [S_AXI_ADDR_WIDTH-1 : 0]      s_axi_araddr;
    wire        [2:0]                         s_axi_arprot;
    wire                                      s_axi_arvalid;
    wire                                      s_axi_arready;
    wire        [S_AXI_DATA_WIDTH-1 : 0]      s_axi_rdata;
    wire        [1:0]                         s_axi_rresp;
    wire                                      s_axi_rvalid;
    wire                                      s_axi_rready;

    reg                 cmd_valid;
    reg [2:0]           cmd_op;
    reg                 cmd_cpol, cmd_cpha;
    reg                 cmd_mask;


    reg [47:0]          D0=48'hDEAD_BEEF_CAFE;
    reg [47:0]          D1=48'h0123_4567_89AB;
    reg [23:0]          data24;
    reg [34:0]          fbs_frame;
    reg [9:0]           fbs_addr;
    reg [59:0]          std_payload;

    reg                 start;
    reg [1023:0]        i;

	spi_tb U1(
		.aresetn    (rst_n),
		.aclk		(clk100),

        .start      (start),
        .sclk       (sclk),
        .cs_n       (cs_n),
        .mosi       (mosi),
        .miso       (miso),
        // .sdi        (sdi),
        .pdi        (pdi),
        // .sdo        (sdo)

        // M_AXI0
        // .M_AXI_CLK                   (clk100),
        // .M_AXI_Reset                 (rst_n),
        .M_AXI_0_araddr              (s_axi_araddr),
        .M_AXI_0_arprot              (s_axi_arprot),
        .M_AXI_0_arready             (s_axi_arready),
        .M_AXI_0_arvalid             (s_axi_arvalid),
        .M_AXI_0_awaddr              (s_axi_awaddr),
        .M_AXI_0_awprot              (s_axi_awprot),
        .M_AXI_0_awready             (s_axi_awready),
        .M_AXI_0_awvalid             (s_axi_awvalid),
        .M_AXI_0_bready              (s_axi_bready),
        .M_AXI_0_bresp               (s_axi_bresp),
        .M_AXI_0_bvalid              (s_axi_bvalid),
        .M_AXI_0_rdata               (s_axi_rdata),
        .M_AXI_0_rready              (s_axi_rready),
        .M_AXI_0_rresp               (s_axi_rresp),
        .M_AXI_0_rvalid              (s_axi_rvalid),
        .M_AXI_0_wdata               (s_axi_wdata),
        .M_AXI_0_wready              (s_axi_wready),
        .M_AXI_0_wstrb               (s_axi_wstrb),
        .M_AXI_0_wvalid              (s_axi_wvalid)
	);

//---------------Version design--------------------------------
// Version # (
//             .C_S_AXI_DATA_WIDTH         (S_AXI_DATA_WIDTH),
//             .C_S_AXI_ADDR_WIDTH         (S_AXI_ADDR_WIDTH)
//         ) Version_inst (
//             .s_axi_aclk                 (clk100),
//             .s_axi_aresetn              (rst_n),
//             .s_axi_awaddr               (s_axi_awaddr),
//             .s_axi_awprot               (s_axi_awprot),
//             .s_axi_awvalid              (s_axi_awvalid),
//             .s_axi_awready              (s_axi_awready),
//             .s_axi_wdata                (s_axi_wdata),
//             .s_axi_wstrb                (s_axi_wstrb),
//             .s_axi_wvalid               (s_axi_wvalid),
//             .s_axi_wready               (s_axi_wready),
//             .s_axi_bresp                (s_axi_bresp),
//             .s_axi_bvalid               (s_axi_bvalid),
//             .s_axi_bready               (s_axi_bready),
//             .s_axi_araddr               (s_axi_araddr),
//             .s_axi_arprot               (s_axi_arprot),
//             .s_axi_arvalid              (s_axi_arvalid),
//             .s_axi_arready              (s_axi_arready),
//             .s_axi_rdata                (s_axi_rdata),
//             .s_axi_rresp                (s_axi_rresp),
//             .s_axi_rvalid               (s_axi_rvalid),
//             .s_axi_rready               (s_axi_rready)
//         );


ificx4 ificx4_u0 (
	.rst_n (rst_n    ),
	.mclk  (clk100   ),
	.scl   (sclk     ),
	.cs_n  (cs_n     ),
	.mosi  (mosi     ),
	.miso  (miso     ),
	.wdao_0(d0_wdao_0),
	.wvld_0(d0_wvld_0),
	.wdao_1(d0_wdao_1),
	.wvld_1(d0_wvld_1),
	.wdao_2(d0_wdao_2),
	.wvld_2(d0_wvld_2),
	.wdao_3(d0_wdao_3),
	.wvld_3(d0_wvld_3)
);

	axi_monitor_transaction		slv_monitor_transaction;
	xil_axi_uint                mst_agent_verbosity = 0;
	spi_tb_axi_vip_0_0_mst_t	mst_agent;

	initial begin   
		#400ns
		rst_n	 =	1;
        start    =  0;
        cmd_mask =  0;

		slv_monitor_transaction = new("slave monitor transaction");
		//Create an agent
		mst_agent = new("master vip agent",U1.axi_vip_0.inst.IF);
		mst_agent.set_agent_tag("Master VIP");
		// set print out verbosity level
		mst_agent.set_verbosity(mst_agent_verbosity);

		//Start the agent
		mst_agent.start_master();
		#400ns

		// custom mode
		// mst_agent.AXI4LITE_WRITE_BURST(spi_base_address,prot,32'h00000000,resp);

        // cmd_valid = 1'b0;
        // cmd_op = 2'b00;
        // cmd_cpol = 1'b0;
        // cmd_cpha = 1'b0;
        // data_buffer = {26'd0, cmd_cpha, cmd_cpol, cmd_op, cmd_valid};
		// mst_agent.AXI4LITE_WRITE_BURST(spi_base_address1,prot,data_buffer,resp);


        // Read the AXI GPIO Data register 2
        #200ns
        addr = 4;
        mst_agent.AXI4LITE_READ_BURST(ver_base_addr + addr,prot,data_buffer,resp);
        $display("data_buffer=%h", data_buffer);

        #200ns
        addr = 8;
        mst_agent.AXI4LITE_READ_BURST(ver_base_addr + addr,prot,data_buffer,resp);
        $display("data_buffer=%h", data_buffer);

        #200ns
        addr = 12;
        mst_agent.AXI4LITE_READ_BURST(ver_base_addr + addr,prot,data_buffer,resp);
        $display("data_buffer=%h", data_buffer);

        #200ns

        for (i=0; i<32; i=i+1) begin
            //STD_WR
            data_buffer = D0[31:0];
            mst_agent.AXI4LITE_WRITE_BURST(spi_base_address6,prot,data_buffer,resp);
            data_buffer = {10'h03E, D0[47:32]};
            mst_agent.AXI4LITE_WRITE_BURST(spi_base_address7,prot,data_buffer,resp);

            // mst_agent.AXI4LITE_READ_BURST(spi_base_address7,prot,data_buffer,resp);
            // $display("data_buffer=%h", data_buffer);
            
            cmd_valid = 1'b1;
            cmd_op = 3'b000;
            cmd_cpol = 1'b0;
            cmd_cpha = 1'b0;
            data_buffer = {25'd0, cmd_mask, cmd_cpha, cmd_cpol, cmd_op, cmd_valid};
            mst_agent.AXI4LITE_WRITE_BURST(spi_base_address1,prot,data_buffer,resp);

            // #1200ns
            cmd_valid = 1'b0;
            cmd_op = 3'b000;
            cmd_cpol = 1'b0;
            cmd_cpha = 1'b0;
            data_buffer = {25'd0, cmd_mask, cmd_cpha, cmd_cpol, cmd_op, cmd_valid};
            mst_agent.AXI4LITE_WRITE_BURST(spi_base_address1,prot,data_buffer,resp);

            // #1200ns
            //STD_RD
            data_buffer = 32'h00;
            mst_agent.AXI4LITE_WRITE_BURST(spi_base_address6,prot,data_buffer,resp);
            data_buffer = {10'h03A, 15'h0};
            mst_agent.AXI4LITE_WRITE_BURST(spi_base_address7,prot,data_buffer,resp);

            cmd_valid = 1'b1;
            cmd_op = 3'b001;
            cmd_cpol = 1'b0;
            cmd_cpha = 1'b0;
            data_buffer = {25'd0, cmd_mask, cmd_cpha, cmd_cpol, cmd_op, cmd_valid};
            mst_agent.AXI4LITE_WRITE_BURST(spi_base_address1,prot,data_buffer,resp);

            cmd_valid = 1'b0;
            cmd_op = 3'b001;
            cmd_cpol = 1'b0;
            cmd_cpha = 1'b0;
            data_buffer = {25'd0, cmd_mask, cmd_cpha, cmd_cpol, cmd_op, cmd_valid};
            mst_agent.AXI4LITE_WRITE_BURST(spi_base_address1,prot,data_buffer,resp);

            // #1200ns
            //STD_WR
            data_buffer = D0[31:0];
            mst_agent.AXI4LITE_WRITE_BURST(spi_base_address6,prot,data_buffer,resp);
            data_buffer = {10'h03E, D0[47:32]};
            mst_agent.AXI4LITE_WRITE_BURST(spi_base_address7,prot,data_buffer,resp);

            cmd_valid = 1'b1;
            cmd_op = 3'b000;
            cmd_cpol = 1'b0;
            cmd_cpha = 1'b0;
            data_buffer = {25'd0, cmd_mask, cmd_cpha, cmd_cpol, cmd_op, cmd_valid};
            mst_agent.AXI4LITE_WRITE_BURST(spi_base_address1,prot,data_buffer,resp);

            // #1200ns
            cmd_valid = 1'b0;
            cmd_op = 3'b000;
            cmd_cpol = 1'b0;
            cmd_cpha = 1'b0;
            data_buffer = {25'd0, cmd_mask, cmd_cpha, cmd_cpol, cmd_op, cmd_valid};
            mst_agent.AXI4LITE_WRITE_BURST(spi_base_address1,prot,data_buffer,resp);

            // #1200ns
            //STD_RD
            data_buffer = 32'h00;
            mst_agent.AXI4LITE_WRITE_BURST(spi_base_address6,prot,data_buffer,resp);
            data_buffer = {10'h03A, 15'h0};
            mst_agent.AXI4LITE_WRITE_BURST(spi_base_address7,prot,data_buffer,resp);

            cmd_valid = 1'b1;
            cmd_op = 3'b001;
            cmd_cpol = 1'b0;
            cmd_cpha = 1'b0;
            data_buffer = {25'd0, cmd_mask, cmd_cpha, cmd_cpol, cmd_op, cmd_valid};
            mst_agent.AXI4LITE_WRITE_BURST(spi_base_address1,prot,data_buffer,resp);

            cmd_valid = 1'b0;
            cmd_op = 3'b001;
            cmd_cpol = 1'b0;
            cmd_cpha = 1'b0;
            data_buffer = {25'd0, cmd_mask, cmd_cpha, cmd_cpol, cmd_op, cmd_valid};
            mst_agent.AXI4LITE_WRITE_BURST(spi_base_address1,prot,data_buffer,resp);
        end

        for (i=0; i<32; i=i+1) begin
            // #1200ns
            //62b Broadcast
            data_buffer = 10'h055;
            mst_agent.AXI4LITE_WRITE_BURST(spi_base_address2,prot,data_buffer,resp);
            data_buffer = D0[31:0];
            mst_agent.AXI4LITE_WRITE_BURST(spi_base_address3,prot,data_buffer,resp);
            data_buffer = D0[47:32];
            mst_agent.AXI4LITE_WRITE_BURST(spi_base_address4,prot,data_buffer,resp);
            // data_buffer = {3'b000, 10'h055};
            // mst_agent.AXI4LITE_WRITE_BURST(spi_base_address5,prot,data_buffer,resp);
            cmd_valid = 1'b1;
            cmd_op = 3'b010;
            cmd_cpol = 1'b0;
            cmd_cpha = 1'b0;
            data_buffer = {25'd0, cmd_mask, cmd_cpha, cmd_cpol, cmd_op, cmd_valid};
            mst_agent.AXI4LITE_WRITE_BURST(spi_base_address1,prot,data_buffer,resp);

            cmd_valid = 1'b0;
            cmd_op = 3'b010;
            cmd_cpol = 1'b0;
            cmd_cpha = 1'b0;
            data_buffer = {25'd0, cmd_mask, cmd_cpha, cmd_cpol, cmd_op, cmd_valid};
            mst_agent.AXI4LITE_WRITE_BURST(spi_base_address1,prot,data_buffer,resp);
        end
        
        for (i=0; i<50; i=i+1) begin
            // #1200ns
            tries = 0;

            // mst_agent.AXI4LITE_READ_BURST(fifo_state_address1,prot,data_buffer,resp);
            // $display("fifo_state=%h, %0d", data_buffer, i);
            // wait (data_buffer==0);

            while (1) begin
                mst_agent.AXI4LITE_READ_BURST(fifo_state_address1, prot, data_buffer, resp);
                $display("[%0t] i=%0d  fifo_state=0x%08h (%0d)", $time, i, data_buffer, data_buffer);

                if (data_buffer == 32'h0) begin
                    $display("[%0t] i=%0d  fifo_state cleared, continue.", $time, i);
                    break; // 跳出 while，進入 for 的下一輪
                end

                tries = tries + 1;
                if (tries >= MAX_POLL) begin
                    $fatal(1, "[%0t] i=%0d  ERROR: poll timeout after %0d reads. last=0x%08h",
                                $time, i, MAX_POLL, data_buffer);
                end

                // 間隔幾拍再讀（設成0就back-to-back）
                repeat (POLL_GAP_CYCLES) @(posedge clk100);
            end

            //Daisy-Chain
            data_buffer = 32'h1ABCDEF56;
            mst_agent.AXI4LITE_WRITE_BURST(spi_base_address10,prot,data_buffer,resp);
            data_buffer = {10'h100, 16'h0AA1};
            mst_agent.AXI4LITE_WRITE_BURST(spi_base_address11,prot,data_buffer,resp);

            data_buffer = 32'h2ABCDEF57;
            mst_agent.AXI4LITE_WRITE_BURST(spi_base_address12,prot,data_buffer,resp);
            data_buffer = {10'h101, 16'h0AA2};
            mst_agent.AXI4LITE_WRITE_BURST(spi_base_address13,prot,data_buffer,resp);

            data_buffer = 32'h3ABCDEF58;
            mst_agent.AXI4LITE_WRITE_BURST(spi_base_address14,prot,data_buffer,resp);
            data_buffer = {10'h102, 16'h0AA3};
            mst_agent.AXI4LITE_WRITE_BURST(spi_base_address15,prot,data_buffer,resp);

            data_buffer = i;
            mst_agent.AXI4LITE_WRITE_BURST(spi_base_address16,prot,data_buffer,resp);
            data_buffer = {10'h103, 16'h0AA4};
            mst_agent.AXI4LITE_WRITE_BURST(spi_base_address17,prot,data_buffer,resp);


            cmd_valid = 1'b1;
            cmd_op = 3'b100;
            cmd_cpol = 1'b0;
            cmd_cpha = 1'b0;
            data_buffer = {25'd0, cmd_mask, cmd_cpha, cmd_cpol, cmd_op, cmd_valid};
            mst_agent.AXI4LITE_WRITE_BURST(spi_base_address1,prot,data_buffer,resp);

            cmd_valid = 1'b0;
            cmd_op = 3'b100;
            cmd_cpol = 1'b0;
            cmd_cpha = 1'b0;
            data_buffer = {25'd0, cmd_mask, cmd_cpha, cmd_cpol, cmd_op, cmd_valid};
            mst_agent.AXI4LITE_WRITE_BURST(spi_base_address1,prot,data_buffer,resp);
        end
	end

endmodule