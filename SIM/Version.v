`timescale 1 ns / 1 ps

	module Version #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line
		// Users to add parameters here
		// Date in values
		parameter               VERSION_YYYY 		      = 2025,
		parameter               VERSION_MM 		          = 8,
		parameter               VERSION_DD	 	          = 14,

		// Semantic Versioning:
		parameter               VERSION_MAJ    	          = 0,
		parameter               VERSION_MIN    	          = 2,
		parameter               VERSION_REV    	          = 0001,

		// Company_ID:
		// 0 - Unknown
		// 1 - TMYTEK
		parameter               VERSION_COMPANY    	      = 1,

		// Model_ID:
		// 0 - Unknown
		// 1 - ELTA
		// 2 - 
		parameter               VERSION_MODE    	      = 1,

		// Board_ID:
		// 0 - Unknown
		// 1 - 
		// 2 - 
		parameter               VERSION_BOARD    	      = 1,

		// Hardware_ID:
		// 0 - Unknown
		// 1 - First edition
		parameter               VERSION_HW    	      	  = 1,

		// Other Text Length by byte:
		parameter               NOTE_LENGTH		    	  = 112,

		// Other_Text: Vivado 2024.2 - Lite Test Project
		parameter 				TEXT_0    				  = "Viva",
		parameter 				TEXT_1    				  = "do 2",
		parameter 				TEXT_2    				  = "024.",
		parameter 				TEXT_3    				  = "2 - ",
		parameter 				TEXT_4    				  = "    ",
		parameter 				TEXT_5    				  = "    ",
		parameter 				TEXT_6    				  = "    ",
		parameter 				TEXT_7    				  = "    ",
		parameter 				TEXT_8    				  = "    ",
		parameter 				TEXT_9    				  = "    ",
		parameter 				TEXT_10    				  = "    ",
		parameter 				TEXT_11    				  = "    ",
		parameter 				TEXT_12    				  = "    ",
		parameter 				TEXT_13    				  = "    ",
		parameter 				TEXT_14    				  = "    ",
		parameter 				TEXT_15    				  = "    ",
		parameter 				TEXT_16    				  = "    ",
		parameter 				TEXT_17    				  = "    ",
		parameter 				TEXT_18    				  = "    ",
		parameter 				TEXT_19    				  = "    ",
		parameter 				TEXT_20    				  = "    ",
		parameter 				TEXT_21    				  = "    ",
		parameter 				TEXT_22    				  = "    ",
		parameter 				TEXT_23    				  = "    ",
		parameter 				TEXT_24    				  = "    ",
		parameter 				TEXT_25    				  = "    ",
		parameter 				TEXT_26   				  = "    ",
		parameter 				TEXT_27    				  = "    ",


		// Parameters of Axi Slave Bus Interface S00_AXI
		parameter integer C_S00_AXI_DATA_WIDTH	= 32,
		parameter integer C_S00_AXI_ADDR_WIDTH	= 7
	)
	(
		// Users to add ports here

		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S00_AXI
		input wire  s_axi_aclk,
		input wire  s_axi_aresetn,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s_axi_awaddr,
		input wire [2 : 0] s_axi_awprot,
		input wire  s_axi_awvalid,
		output wire  s_axi_awready,
		input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s_axi_wdata,
		input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s_axi_wstrb,
		input wire  s_axi_wvalid,
		output wire  s_axi_wready,
		output wire [1 : 0] s_axi_bresp,
		output wire  s_axi_bvalid,
		input wire  s_axi_bready,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s_axi_araddr,
		input wire [2 : 0] s_axi_arprot,
		input wire  s_axi_arvalid,
		output wire  s_axi_arready,
		output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s_axi_rdata,
		output wire [1 : 0] s_axi_rresp,
		output wire  s_axi_rvalid,
		input wire  s_axi_rready
	);
// Instantiation of Axi Bus Interface S00_AXI
	Version_AXI # ( 
		.VERSION_YYYY(VERSION_YYYY),
		.VERSION_MM(VERSION_MM),
		.VERSION_DD(VERSION_DD),
		.VERSION_MAJ(VERSION_MAJ),
		.VERSION_MIN(VERSION_MIN),
		.VERSION_REV(VERSION_REV),
		.VERSION_COMPANY(VERSION_COMPANY),
		.VERSION_MODE(VERSION_MODE),
		.VERSION_BOARD(VERSION_BOARD),
		.VERSION_HW(VERSION_HW),
		.NOTE_LENGTH(NOTE_LENGTH),
		.TEXT_0(TEXT_0),
		.TEXT_1(TEXT_1),
		.TEXT_2(TEXT_2),
		.TEXT_3(TEXT_3),
		.TEXT_4(TEXT_4),
		.TEXT_5(TEXT_5),
		.TEXT_6(TEXT_6),
		.TEXT_7(TEXT_7),
		.TEXT_8(TEXT_8),
		.TEXT_9(TEXT_9),
		.TEXT_10(TEXT_10),
		.TEXT_11(TEXT_11),
		.TEXT_12(TEXT_12),
		.TEXT_13(TEXT_13),
		.TEXT_14(TEXT_14),
		.TEXT_15(TEXT_15),
		.TEXT_16(TEXT_16),
		.TEXT_17(TEXT_17),
		.TEXT_18(TEXT_18),
		.TEXT_19(TEXT_19),
		.TEXT_20(TEXT_20),
		.TEXT_21(TEXT_21),
		.TEXT_22(TEXT_22),
		.TEXT_23(TEXT_23),
		.TEXT_24(TEXT_24),
		.TEXT_25(TEXT_25),
		.TEXT_26(TEXT_26),
		.TEXT_27(TEXT_27),
		.C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
	) Version_AXI_inst (
		.S_AXI_ACLK(s_axi_aclk),
		.S_AXI_ARESETN(s_axi_aresetn),
		.S_AXI_AWADDR(s_axi_awaddr),
		.S_AXI_AWPROT(s_axi_awprot),
		.S_AXI_AWVALID(s_axi_awvalid),
		.S_AXI_AWREADY(s_axi_awready),
		.S_AXI_WDATA(s_axi_wdata),
		.S_AXI_WSTRB(s_axi_wstrb),
		.S_AXI_WVALID(s_axi_wvalid),
		.S_AXI_WREADY(s_axi_wready),
		.S_AXI_BRESP(s_axi_bresp),
		.S_AXI_BVALID(s_axi_bvalid),
		.S_AXI_BREADY(s_axi_bready),
		.S_AXI_ARADDR(s_axi_araddr),
		.S_AXI_ARPROT(s_axi_arprot),
		.S_AXI_ARVALID(s_axi_arvalid),
		.S_AXI_ARREADY(s_axi_arready),
		.S_AXI_RDATA(s_axi_rdata),
		.S_AXI_RRESP(s_axi_rresp),
		.S_AXI_RVALID(s_axi_rvalid),
		.S_AXI_RREADY(s_axi_rready)
	);

	// Add user logic here

	// User logic ends

	endmodule
