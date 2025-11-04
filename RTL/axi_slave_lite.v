
`timescale 1 ns / 1 ps

module AXI_lite_to_Reg #
       (
           // Users to add parameters here
           parameter integer NUM_REGS 			= 4,
           parameter integer CHAIN_N_DEV       	= 4,
           parameter integer CHAIN_BITS_PERDEV 	= 48,
           parameter integer CHAIN_REGS_PERDEV 	= (CHAIN_BITS_PERDEV + C_S_AXI_DATA_WIDTH - 1)/C_S_AXI_DATA_WIDTH, // 48/32=2
           parameter integer CHAIN_NUM_REGS    	= CHAIN_N_DEV * CHAIN_REGS_PERDEV,
           parameter integer STD_RO_BITS        = 60,
           parameter integer STD_NUM_REGS       = (STD_RO_BITS + C_S_AXI_DATA_WIDTH - 1) / C_S_AXI_DATA_WIDTH,     // 60/32=2
           parameter integer FIFO_NUM_REGS      = 1,

           parameter integer STD_RO_BASE        = 8,     // std_rx → slv_reg[8],[9]
           parameter integer CHAIN_RO_BASE     	= 18,    // first index in slv_reg[] reserved for RO window
           parameter integer FIFO_STATE_BASE    = 26,
           parameter 		 STD_RO_EN			= 1'b1,  // enable the RO window
           parameter         CHAIN_RO_EN       	= 1'b1,  // enable the RO window
           parameter         FIFO_STATE_RO_EN   = 1'b1,  // enable the RO window

           // User parameters ends
           // Do not modify the parameters beyond this line

           // Width of S_AXI data bus
           parameter integer C_S_AXI_DATA_WIDTH	= 32,
           // Width of S_AXI address bus
           parameter integer C_S_AXI_ADDR_WIDTH	= 24
       )
       (
           // Users to add ports here

           // User ports ends
           // Do not modify the ports beyond this line

           // Global Clock Signal
           input wire  S_AXI_ACLK,
           // Global Reset Signal. This Signal is Active LOW
           input wire  S_AXI_ARESETN,
           // Write address (issued by master, acceped by Slave)
           input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_AWADDR,
           // Write channel Protection type. This signal indicates the
           // privilege and security level of the transaction, and whether
           // the transaction is a data access or an instruction access.
           input wire [2 : 0] S_AXI_AWPROT,
           // Write address valid. This signal indicates that the master signaling
           // valid write address and control information.
           input wire  S_AXI_AWVALID,
           // Write address ready. This signal indicates that the slave is ready
           // to accept an address and associated control signals.
           output wire  S_AXI_AWREADY,
           // Write data (issued by master, acceped by Slave)
           input wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_WDATA,
           // Write strobes. This signal indicates which byte lanes hold
           // valid data. There is one write strobe bit for each eight
           // bits of the write data bus.
           input wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] S_AXI_WSTRB,
           // Write valid. This signal indicates that valid write
           // data and strobes are available.
           input wire  S_AXI_WVALID,
           // Write ready. This signal indicates that the slave
           // can accept the write data.
           output wire  S_AXI_WREADY,
           // Write response. This signal indicates the status
           // of the write transaction.
           output wire [1 : 0] S_AXI_BRESP,
           // Write response valid. This signal indicates that the channel
           // is signaling a valid write response.
           output wire  S_AXI_BVALID,
           // Response ready. This signal indicates that the master
           // can accept a write response.
           input wire  S_AXI_BREADY,
           // Read address (issued by master, acceped by Slave)
           input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_ARADDR,
           // Protection type. This signal indicates the privilege
           // and security level of the transaction, and whether the
           // transaction is a data access or an instruction access.
           input wire [2 : 0] S_AXI_ARPROT,
           // Read address valid. This signal indicates that the channel
           // is signaling valid read address and control information.
           input wire  S_AXI_ARVALID,
           // Read address ready. This signal indicates that the slave is
           // ready to accept an address and associated control signals.
           output wire  S_AXI_ARREADY,
           // Read data (issued by slave)
           output wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_RDATA,
           // Read response. This signal indicates the status of the
           // read transfer.
           output wire [1 : 0] S_AXI_RRESP,
           // Read valid. This signal indicates that the channel is
           // signaling the required read data.
           output wire  S_AXI_RVALID,
           // Read ready. This signal indicates that the master can
           // accept the read data and response information.
           input wire  S_AXI_RREADY,

           input wire [STD_NUM_REGS*C_S_AXI_DATA_WIDTH-1:0]   std_ro_data,
           input wire                                         std_ro_load,
           input wire [CHAIN_NUM_REGS*C_S_AXI_DATA_WIDTH-1:0] chain_ro_data,
           input wire                                         chain_ro_load,
           input wire [FIFO_NUM_REGS*C_S_AXI_DATA_WIDTH-1:0]  fifo_state_ro_data,
           // output wire [C_S_AXI_DATA_WIDTH-1:0] Data_out [0:NUM_REGS-1]
           output wire [NUM_REGS*C_S_AXI_DATA_WIDTH-1:0] Data_out


       );

// AXI4LITE signals
reg [C_S_AXI_ADDR_WIDTH-1 : 0] 	axi_awaddr;
reg  	axi_awready;
reg  	axi_wready;
reg [1 : 0] 	axi_bresp;
reg  	axi_bvalid;
reg [C_S_AXI_ADDR_WIDTH-1 : 0] 	axi_araddr;
reg  	axi_arready;
reg [1 : 0] 	axi_rresp;
reg  	axi_rvalid;

// Example-specific design signals
// local parameter for addressing 32 bit / 64 bit C_S_AXI_DATA_WIDTH
// ADDR_LSB is used for addressing 32/64 bit registers/memories
// ADDR_LSB = 2 for 32 bits (n downto 2)
// ADDR_LSB = 3 for 64 bits (n downto 3)
localparam integer ADDR_LSB = (C_S_AXI_DATA_WIDTH/32) + 1;
// localparam integer OPT_MEM_ADDR_BITS = 1;

function integer CLOG2;
    input integer val;
    integer i;
    begin
        CLOG2 = 0;
        for (i = val-1; i > 0; i = i >> 1)
            CLOG2 = CLOG2 + 1;
    end
endfunction

localparam integer ADDR_INDEX_WIDTH = (NUM_REGS <= 1) ? 1 : CLOG2(NUM_REGS);
localparam integer ADDR_SLICE_MSB   = ADDR_LSB + ADDR_INDEX_WIDTH - 1;


//----------------------------------------------
//-- Signals for user logic register space example
//------------------------------------------------
//-- Number of Slave Registers 4
// reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg0;
// reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg1;
// reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg2;
// reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg3;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg	[0:NUM_REGS-1];
wire [ADDR_INDEX_WIDTH-1:0] wr_sel = (S_AXI_AWVALID) ? S_AXI_AWADDR[ADDR_SLICE_MSB:ADDR_LSB] :
     axi_awaddr[ADDR_SLICE_MSB:ADDR_LSB];
wire [ADDR_INDEX_WIDTH-1:0] rd_sel = axi_araddr[ADDR_SLICE_MSB:ADDR_LSB];
wire in_std_ro   = (STD_RO_EN)   && (wr_sel >= STD_RO_BASE)   && (wr_sel < STD_RO_BASE   + STD_NUM_REGS);
wire in_chain_ro = (CHAIN_RO_EN) && (wr_sel >= CHAIN_RO_BASE) && (wr_sel < CHAIN_RO_BASE + CHAIN_NUM_REGS);
wire in_fifo_state_ro = (FIFO_STATE_RO_EN) && (wr_sel >= FIFO_STATE_BASE) && (wr_sel < FIFO_STATE_BASE + FIFO_NUM_REGS);

integer  byte_index;
integer  reg_index;


// I/O Connections assignments

assign S_AXI_AWREADY	= axi_awready;
assign S_AXI_WREADY	= axi_wready;
assign S_AXI_BRESP	= axi_bresp;
assign S_AXI_BVALID	= axi_bvalid;
assign S_AXI_ARREADY	= axi_arready;
assign S_AXI_RRESP	= axi_rresp;
assign S_AXI_RVALID	= axi_rvalid;
//state machine varibles
reg [1:0] state_write;
reg [1:0] state_read;
//State machine local parameters
localparam Idle = 2'b00,Raddr = 2'b10,Rdata = 2'b11 ,Waddr = 2'b10,Wdata = 2'b11;
// Implement Write state machine
// Outstanding write transactions are not supported by the slave i.e., master should assert bready to receive response on or before it starts sending the new transaction
always @(posedge S_AXI_ACLK) begin
    if (S_AXI_ARESETN == 1'b0) begin
        axi_awready <= 0;
        axi_wready <= 0;
        axi_bvalid <= 0;
        axi_bresp <= 0;
        axi_awaddr <= 0;
        state_write <= Idle;
    end
    else begin
        case(state_write)
            Idle: begin
                if(S_AXI_ARESETN == 1'b1) begin
                    axi_awready <= 1'b1;
                    axi_wready <= 1'b1;
                    state_write <= Waddr;
                end
                else
                    state_write <= state_write;
            end
            Waddr:        //At this state, slave is ready to receive address along with corresponding control signals and first data packet. Response valid is also handled at this state
            begin
                if (S_AXI_AWVALID && S_AXI_AWREADY) begin
                    axi_awaddr <= S_AXI_AWADDR;
                    if(S_AXI_WVALID) begin
                        axi_awready <= 1'b1;
                        state_write <= Waddr;
                        axi_bvalid <= 1'b1;
                    end
                    else begin
                        axi_awready <= 1'b0;
                        state_write <= Wdata;
                        if (S_AXI_BREADY && axi_bvalid)
                            axi_bvalid <= 1'b0;
                    end
                end
                else begin
                    state_write <= state_write;
                    if (S_AXI_BREADY && axi_bvalid)
                        axi_bvalid <= 1'b0;
                end
            end
            Wdata:        //At this state, slave is ready to receive the data packets until the number of transfers is equal to burst length
            begin
                if (S_AXI_WVALID) begin
                    state_write <= Waddr;
                    axi_bvalid <= 1'b1;
                    axi_awready <= 1'b1;
                end
                else begin
                    state_write <= state_write;
                    if (S_AXI_BREADY && axi_bvalid)
                        axi_bvalid <= 1'b0;
                end
            end
        endcase
    end
end

// Implement memory mapped register select and write logic generation
// The write data is accepted and written to memory mapped registers when
// axi_awready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted. Write strobes are used to
// select byte enables of slave registers while writing.
// These registers are cleared when reset (active low) is applied.
// Slave register write enable is asserted when valid address and data are available
// and the slave is ready to accept the write address and write data.

integer k;
always @( posedge S_AXI_ACLK ) begin
    if ( S_AXI_ARESETN == 1'b0 ) begin
        for (reg_index = 0; reg_index < NUM_REGS; reg_index = reg_index + 1)
            slv_reg[reg_index] <= {C_S_AXI_DATA_WIDTH{1'b0}};
    end
    else begin
        if (STD_RO_EN && std_ro_load) begin
            for (k = 0; k < STD_NUM_REGS; k = k + 1)
                slv_reg[STD_RO_BASE + k] <= std_ro_data[k*C_S_AXI_DATA_WIDTH +: C_S_AXI_DATA_WIDTH];
        end
        if (CHAIN_RO_EN && chain_ro_load) begin
            for (k = 0; k < CHAIN_NUM_REGS; k = k + 1)
                slv_reg[CHAIN_RO_BASE + k] <= chain_ro_data[k*C_S_AXI_DATA_WIDTH +: C_S_AXI_DATA_WIDTH];
        end

        if (FIFO_STATE_RO_EN) begin
            for (k = 0; k < FIFO_NUM_REGS; k = k + 1)
                slv_reg[FIFO_STATE_BASE + k] <= fifo_state_ro_data[k*C_S_AXI_DATA_WIDTH +: C_S_AXI_DATA_WIDTH];
        end

        if (S_AXI_WVALID) begin
            if (wr_sel < NUM_REGS) begin
                // Block writes to the RO window (CHAIN_RO_BASE .. CHAIN_RO_BASE+CHAIN_NUM_REGS-1)
                if (!(in_std_ro || in_chain_ro || in_fifo_state_ro)) begin
                    for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1) begin
                        if (S_AXI_WSTRB[byte_index]) begin
                            slv_reg[wr_sel][(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
                        end
                    end
                end
            end
        end
    end
end

// Copy RO data into slv_reg window atomically on strobe
// integer k;
// always @(posedge S_AXI_ACLK) begin
// 	if (!S_AXI_ARESETN) begin
// 		// reset RO
// 	end else begin
// 		if (STD_RO_EN && std_ro_load) begin
// 			for (k = 0; k < STD_NUM_REGS; k = k + 1)
// 				slv_reg[STD_RO_BASE + k] <= std_ro_data[k*C_S_AXI_DATA_WIDTH +: C_S_AXI_DATA_WIDTH];
// 		end
// 		if (CHAIN_RO_EN && chain_ro_load) begin
// 			for (k = 0; k < CHAIN_NUM_REGS; k = k + 1)
// 				slv_reg[CHAIN_RO_BASE + k] <= chain_ro_data[k*C_S_AXI_DATA_WIDTH +: C_S_AXI_DATA_WIDTH];
// 		end
// 	end
// end

// Implement read state machine
always @(posedge S_AXI_ACLK) begin
    if (S_AXI_ARESETN == 1'b0) begin
        //asserting initial values to all 0's during reset
        axi_arready <= 1'b0;
        axi_rvalid <= 1'b0;
        axi_rresp <= 1'b0;
        state_read <= Idle;
    end
    else begin
        case(state_read)
            Idle:     //Initial state inidicating reset is done and ready to receive read/write transactions
            begin
                if (S_AXI_ARESETN == 1'b1) begin
                    state_read <= Raddr;
                    axi_arready <= 1'b1;
                end
                else
                    state_read <= state_read;
            end
            Raddr:        //At this state, slave is ready to receive address along with corresponding control signals
            begin
                if (S_AXI_ARVALID && S_AXI_ARREADY) begin
                    state_read <= Rdata;
                    axi_araddr <= S_AXI_ARADDR;
                    axi_rvalid <= 1'b1;
                    axi_arready <= 1'b0;
                end
                else
                    state_read <= state_read;
            end
            Rdata:        //At this state, slave is ready to send the data packets until the number of transfers is equal to burst length
            begin
                if (S_AXI_RVALID && S_AXI_RREADY) begin
                    axi_rvalid <= 1'b0;
                    axi_arready <= 1'b1;
                    state_read <= Raddr;
                end
                else
                    state_read <= state_read;
            end
        endcase
    end
end
// Implement memory mapped register select and read logic generation
//   assign S_AXI_RDATA = (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == 2'h0) ? slv_reg0 : (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == 2'h1) ? slv_reg1 : (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == 2'h2) ? slv_reg2 : (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == 2'h3) ? slv_reg3 : 0;
assign S_AXI_RDATA = (rd_sel < NUM_REGS) ? slv_reg[rd_sel] : {C_S_AXI_DATA_WIDTH{1'b0}};
// Add user logic here
genvar gi;
generate
    for (gi = 0; gi < NUM_REGS; gi = gi + 1) begin : GEN_DATA_OUT
        assign Data_out[gi*C_S_AXI_DATA_WIDTH +: C_S_AXI_DATA_WIDTH] = slv_reg[gi];
    end
endgenerate


// User logic ends

endmodule
