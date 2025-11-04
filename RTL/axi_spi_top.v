
`timescale 1ns/1ps
module axi_spi_top #(
           parameter integer NUM_REGS               = 18,
           parameter integer STD_W                  = 60,
           parameter integer N_DEV                  = 4,    // Daisy-Chain 4
           // Parameters of Axi Slave Bus Interface S00_AXI
           parameter integer C_S00_AXI_DATA_WIDTH	= 32,
           parameter integer C_S00_AXI_ADDR_WIDTH	= 24,
           //
           parameter integer CMD_FIFO_DEPTH         = 16
       )(
           // Ports of Axi Slave Bus Interface S00_AXI
           input wire                                  s00_axi_aclk,
           input wire                                  s00_axi_aresetn,
           input wire [C_S00_AXI_ADDR_WIDTH-1 : 0]     s00_axi_awaddr,
           input wire [2 : 0]                          s00_axi_awprot,
           input wire                                  s00_axi_awvalid,
           output wire                                 s00_axi_awready,
           input wire [C_S00_AXI_DATA_WIDTH-1 : 0]     s00_axi_wdata,
           input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
           input wire                                  s00_axi_wvalid,
           output wire                                 s00_axi_wready,
           output wire [1 : 0]                         s00_axi_bresp,
           output wire                                 s00_axi_bvalid,
           input wire                                  s00_axi_bready,
           input wire [C_S00_AXI_ADDR_WIDTH-1 : 0]     s00_axi_araddr,
           input wire [2 : 0]                          s00_axi_arprot,
           input wire                                  s00_axi_arvalid,
           output wire                                 s00_axi_arready,
           output wire [C_S00_AXI_DATA_WIDTH-1 : 0]    s00_axi_rdata,
           output wire [1 : 0]                         s00_axi_rresp,
           output wire                                 s00_axi_rvalid,
           input wire                                  s00_axi_rready,

           input wire                                  spi_Mclk,
           input wire                                  spi_ressetn,
           input wire                                  start,
           output wire                                 sclk,
           output wire                                 cs_n,
           output wire                                 mosi,
           input  wire                                 miso,
           // output wire                                 sdi,
           output wire                                 pdi
           // input  wire                                 sdo
       );

localparam integer W = C_S00_AXI_DATA_WIDTH;
localparam integer REGS_PER_DEV = (48+W-1)/W;   // 2
localparam integer NUM_RO       = N_DEV*REGS_PER_DEV;
localparam integer STD_REGS     = (STD_W + W - 1)/W; // 2
localparam integer NUM_RO_STATE = 1;


wire                clk   = spi_Mclk;
wire                rst_n = spi_ressetn;

wire                cmd_valid;
wire                cmd_ready;
wire [2:0]          cmd_op;
wire                cmd_cpol, cmd_cpha;

wire [9:0]          aw_addr;
wire [47:0]         aw_wdata;
wire [12:0]         aw_ctrl_low13;

wire [N_DEV*10-1:0] aw_chain_addr10_wr; //
wire [N_DEV*10-1:0] aw_chain_addr10_rd; //
wire [N_DEV*48-1:0] aw_chain_wdata;     //

wire [STD_W-1:0]    std_payload;
wire                resp_done;
wire [STD_W-1:0]    std_rx;
wire [N_DEV*48-1:0] aw_chain_rx;


wire [NUM_REGS*W-1:0] data_out_bus;

wire [W-1:0] data_out0  = data_out_bus[0*W +: W];
//Ctrl command
wire [W-1:0] data_out1  = data_out_bus[1*W +: W];
//Address
wire [W-1:0] data_out2  = data_out_bus[2*W +: W];
//Data
wire [W-1:0] data_out3  = data_out_bus[3*W +: W];
wire [W-1:0] data_out4  = data_out_bus[4*W +: W];
//Broadcast control
wire [W-1:0] data_out5  = data_out_bus[5*W +: W];
//Standard payload
wire [W-1:0] data_out6  = data_out_bus[6*W +: W];
wire [W-1:0] data_out7  = data_out_bus[7*W +: W];
//Standard rx data
// wire [W-1:0] std_ro_lo  = data_out_bus[8*W +: W];  // std_rx[31:0]
// wire [W-1:0] std_ro_hi  = data_out_bus[9*W +: W];  // {4'b0, std_rx[59:32]}
wire [STD_REGS*W-1:0] std_ro_data;

//Daisy-Chain write
wire [W-1:0] data_out10 = data_out_bus[10*W +: W];
wire [W-1:0] data_out11 = data_out_bus[11*W +: W];
wire [W-1:0] data_out12 = data_out_bus[12*W +: W];
wire [W-1:0] data_out13 = data_out_bus[13*W +: W];
wire [W-1:0] data_out14 = data_out_bus[14*W +: W];
wire [W-1:0] data_out15 = data_out_bus[15*W +: W];
wire [W-1:0] data_out16 = data_out_bus[16*W +: W];
wire [W-1:0] data_out17 = data_out_bus[17*W +: W];
//Daisy-Chain read
reg  [W-1:0] axi_chain_rd [0:NUM_RO-1];  // already in your design (resp_done)
wire [NUM_RO*W-1:0] chain_ro_data_bus;

wire [W-1:0] fifo_state_ro_data;

wire         std_ro_load, chain_ro_load;

// ============================================================================
assign cmd_valid                = (data_out1[6] == 1'b1) ? (data_out1[0]) : (data_out1[0] | start);
assign cmd_op                   = data_out1[3:1];
assign cmd_cpol                 = data_out1[4];
assign cmd_cpha                 = data_out1[5];

assign aw_addr                  = data_out2[9:0];
assign aw_wdata                 = {data_out4[15:0], data_out3};
assign aw_ctrl_low13            = data_out5[12:0];

assign std_payload              = {data_out7[27:0], data_out6};

// assign std_ro_data[0*W +: W]    = std_rx[31:0];
// assign std_ro_data[1*W +: W]    = {{(W-(STD_W-32)){1'b0}}, std_rx[STD_W-1:32]}; // {4'b0, std_rx[59:32]}

assign aw_chain_addr10_wr       = {data_out17[25:16], data_out15[25:16], data_out13[25:16], data_out11[25:16]};
assign aw_chain_addr10_rd       = {data_out17[25:16], data_out15[25:16], data_out13[25:16], data_out11[25:16]};
assign aw_chain_wdata           = {data_out17[15:0], data_out16, data_out15[15:0], data_out14, data_out13[15:0], data_out12, data_out11[15:0], data_out10};

// assign std_ro_load              = resp_done;
// assign chain_ro_load            = resp_done;

// genvar gi;
// generate
//     for (gi=0; gi<N_DEV; gi=gi+1) begin: GEN_SPLIT
//         localparam integer D_H = (gi+1)*48 - 1;
//         localparam integer D_L = gi*48;

//         wire [47:0] dev48_i = aw_chain_rx[D_H:D_L];

//         localparam integer R_LO = gi*REGS_PER_DEV;     // L 32
//         localparam integer R_HI = gi*REGS_PER_DEV + 1; // H 16

//         always @(posedge clk or negedge rst_n) begin
//             if (!rst_n) begin
//                 axi_chain_rd[R_LO] <= {W{1'b0}};
//                 axi_chain_rd[R_HI] <= {W{1'b0}};
//             end
//             else if (resp_done) begin
//                 axi_chain_rd[R_LO] <= dev48_i[31:0];
//                 axi_chain_rd[R_HI] <= {{(W-16){1'b0}}, dev48_i[47:32]};
//             end
//         end
//     end
// endgenerate

// genvar bj;
// generate
//     for (bj=0; bj<NUM_RO; bj=bj+1) begin: GEN_PACK
//         assign chain_ro_data_bus[bj*W +: W] = axi_chain_rd[bj];
//     end
// endgenerate


// ============================================================================
// Instantiation of Axi Bus Interface S00_AXI
AXI_lite_to_Reg # (
                    .NUM_REGS           (NUM_REGS + NUM_RO + NUM_RO_STATE),
                    .CHAIN_N_DEV        (N_DEV),
                    .CHAIN_RO_BASE      (NUM_REGS),
                    .C_S_AXI_DATA_WIDTH (C_S00_AXI_DATA_WIDTH),
                    .C_S_AXI_ADDR_WIDTH (C_S00_AXI_ADDR_WIDTH)
                ) AXI_lite_to_Reg (
                    .S_AXI_ACLK         (s00_axi_aclk),
                    .S_AXI_ARESETN      (s00_axi_aresetn),
                    .S_AXI_AWADDR       (s00_axi_awaddr),
                    .S_AXI_AWPROT       (s00_axi_awprot),
                    .S_AXI_AWVALID      (s00_axi_awvalid),
                    .S_AXI_AWREADY      (s00_axi_awready),
                    .S_AXI_WDATA        (s00_axi_wdata),
                    .S_AXI_WSTRB        (s00_axi_wstrb),
                    .S_AXI_WVALID       (s00_axi_wvalid),
                    .S_AXI_WREADY       (s00_axi_wready),
                    .S_AXI_BRESP        (s00_axi_bresp),
                    .S_AXI_BVALID       (s00_axi_bvalid),
                    .S_AXI_BREADY       (s00_axi_bready),
                    .S_AXI_ARADDR       (s00_axi_araddr),
                    .S_AXI_ARPROT       (s00_axi_arprot),
                    .S_AXI_ARVALID      (s00_axi_arvalid),
                    .S_AXI_ARREADY      (s00_axi_arready),
                    .S_AXI_RDATA        (s00_axi_rdata),
                    .S_AXI_RRESP        (s00_axi_rresp),
                    .S_AXI_RVALID       (s00_axi_rvalid),
                    .S_AXI_RREADY       (s00_axi_rready),

                    .std_ro_data        (std_ro_data),
                    .std_ro_load        (std_ro_load),
                    .chain_ro_data      (chain_ro_data_bus),
                    .chain_ro_load      (chain_ro_load),
                    .fifo_state_ro_data (fifo_state_ro_data),
                    .Data_out           (data_out_bus)

                );

// ============================================================================
localparam integer NWORDS = 18;
// 8/9 is Read reg，FIFO：11111111_00_11111111
localparam [NWORDS-1:0] NEED_MASK = 18'b111111110011111111;
localparam [17:0] USE_BLOCK_MASK = 18'b111111110000000000; // 17..10=1, 9..0=0

wire axi_go = cmd_valid;
reg  axi_go_d;
always @(posedge s00_axi_aclk or negedge s00_axi_aresetn) begin
    if (!s00_axi_aresetn)
        axi_go_d <= 1'b0;
    else
        axi_go_d <= axi_go;
end
wire axi_go_pulse = axi_go & ~axi_go_d;

// FIFO buses
wire [NWORDS*W-1:0] fifo_dout_bus;
wire [NWORDS-1:0]   fifo_empty;
wire [NWORDS-1:0]   fifo_full;
reg  [NWORDS-1:0]   fifo_rd_en;

wire fifo_full_any = |(fifo_full & NEED_MASK);
assign fifo_state_ro_data = {31'h0, fifo_full_any};

// gen 18 async FIFO（FWFT）
genvar gf;
generate
    for (gf=0; gf<NWORDS; gf=gf+1) begin: GEN_CMD_FIFOS
        if (USE_BLOCK_MASK[gf]) begin : USE_BRAM
            xpm_fifo_async #(
                            .FIFO_MEMORY_TYPE ("block"),
                            .FIFO_WRITE_DEPTH (CMD_FIFO_DEPTH*2),
                            .WRITE_DATA_WIDTH (W),
                            .READ_DATA_WIDTH  (W),
                            .READ_MODE        ("fwft"),
                            .CDC_SYNC_STAGES  (2),
                            .ECC_MODE         ("no_ecc"),
                            .SIM_ASSERT_CHK   (0)
                        ) u_cmd_fifo_i (
                            .rst           (~s00_axi_aresetn | ~rst_n),
                            .wr_clk        (s00_axi_aclk),
                            .wr_en         (axi_go_pulse & NEED_MASK[gf] & ~fifo_full_any),
                            .din           (data_out_bus[gf*W +: W]),
                            .full          (fifo_full[gf]),
                            .wr_rst_busy   (),
                            .rd_clk        (clk),
                            .rd_en         (fifo_rd_en[gf]),
                            .dout          (fifo_dout_bus[gf*W +: W]),
                            .empty         (fifo_empty[gf]),
                            .data_valid    (),
                            .rd_rst_busy   (),
                            .sleep(1'b0),
                            .injectdbiterr(1'b0),
                            .injectsbiterr(1'b0),
                            .sbiterr(),
                            .dbiterr(),
                            .prog_empty(),
                            .prog_full(),
                            .wr_data_count(),
                            .rd_data_count()
                        );
        end else begin : USE_LUT
            xpm_fifo_async #(
                            .FIFO_MEMORY_TYPE ("distributed"),
                            .FIFO_WRITE_DEPTH (CMD_FIFO_DEPTH),
                            .WRITE_DATA_WIDTH (W),
                            .READ_DATA_WIDTH  (W),
                            .READ_MODE        ("fwft"),
                            .CDC_SYNC_STAGES  (2),
                            .ECC_MODE         ("no_ecc"),
                            .SIM_ASSERT_CHK   (0)
                        ) u_cmd_fifo_i (
                            .rst           (~s00_axi_aresetn | ~rst_n),
                            .wr_clk        (s00_axi_aclk),
                            .wr_en         (axi_go_pulse & NEED_MASK[gf] & ~fifo_full_any),
                            .din           (data_out_bus[gf*W +: W]),
                            .full          (fifo_full[gf]),
                            .wr_rst_busy   (),
                            .rd_clk        (clk),
                            .rd_en         (fifo_rd_en[gf]),
                            .dout          (fifo_dout_bus[gf*W +: W]),
                            .empty         (fifo_empty[gf]),
                            .data_valid    (),
                            .rd_rst_busy   (),
                            .sleep(1'b0),
                            .injectdbiterr(1'b0),
                            .injectsbiterr(1'b0),
                            .sbiterr(),
                            .dbiterr(),
                            .prog_empty(),
                            .prog_full(),
                            .wr_data_count(),
                            .rd_data_count()
                        );
        end
    end
endgenerate

wire all_needed_ready = ~| ( (fifo_empty) & NEED_MASK );

reg [W-1:0] w0,w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15,w16,w17;
reg         go_latched;
reg         start_to_ctrl;
wire        ctrl_ready;

// STATE：WAIT → LAUNCH → BUSY，BUSY wait resp_done
localparam S_WAIT=2'd0, S_LAUNCH=2'd1, S_BUSY=2'd2;
reg [1:0] st, nst;

always @* begin
    nst = st;
    fifo_rd_en = {NWORDS{1'b0}};
    case (st)
        S_WAIT: begin
            if (ctrl_ready && all_needed_ready)
                nst = S_LAUNCH;
        end
        S_LAUNCH: begin
            fifo_rd_en = NEED_MASK;
            if (go_latched)
                nst = S_BUSY;
            else
                nst = S_WAIT; // NOP
        end
        S_BUSY: begin
            if (resp_done)
                nst = S_WAIT;  // DONE next
        end
        default:
            nst = S_WAIT;
    endcase
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        st <= S_WAIT;
        start_to_ctrl <= 1'b0;
        go_latched    <= 1'b0;
        {w0,w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15,w16,w17} <= {18{32'h0}};
    end
    else begin
        st <= nst;
        start_to_ctrl <= 1'b0;

        case (st)
            S_WAIT: begin
                if (ctrl_ready && all_needed_ready) begin
                    w0  <= fifo_dout_bus[0*W +: W];
                    w1  <= fifo_dout_bus[1*W +: W];
                    w2  <= fifo_dout_bus[2*W +: W];
                    w3  <= fifo_dout_bus[3*W +: W];
                    w4  <= fifo_dout_bus[4*W +: W];
                    w5  <= fifo_dout_bus[5*W +: W];
                    w6  <= fifo_dout_bus[6*W +: W];
                    w7  <= fifo_dout_bus[7*W +: W];
                    w8  <= fifo_dout_bus[8*W +: W];
                    w9  <= fifo_dout_bus[9*W +: W];
                    w10 <= fifo_dout_bus[10*W +: W];
                    w11 <= fifo_dout_bus[11*W +: W];
                    w12 <= fifo_dout_bus[12*W +: W];
                    w13 <= fifo_dout_bus[13*W +: W];
                    w14 <= fifo_dout_bus[14*W +: W];
                    w15 <= fifo_dout_bus[15*W +: W];
                    w16 <= fifo_dout_bus[16*W +: W];
                    w17 <= fifo_dout_bus[17*W +: W];
                    go_latched <= fifo_dout_bus[1*W + 0]; // LOCK GO
                end
            end

            S_LAUNCH: begin
                start_to_ctrl <= go_latched;
            end

            S_BUSY: begin
                // wait resp_done
            end
        endcase
    end
end

wire [2:0]          dq_op       = w1[3:1];
wire                dq_cpol     = w1[4];
wire                dq_cpha     = w1[5];
wire [9:0]          dq_addr     = w2[9:0];
wire [47:0]         dq_wdata    = {w4[15:0], w3};
wire [12:0]         dq_low13    = w5[12:0];
wire [STD_W-1:0]    dq_std      = {w7[27:0], w6};
wire [N_DEV*10-1:0] dq_dcaddr   = {w17[25:16], w15[25:16], w13[25:16], w11[25:16]};
wire [N_DEV*48-1:0] dq_dcwdata  = {w17[15:0], w16, w15[15:0], w14, w13[15:0], w12, w11[15:0], w10};

// ============================================================================
awstd_controller #(
                     .MAX_BITS           (1024),
                     .CLK_DIV            (1),
                     .N_DEV              (4),
                     .DATA_BITS          (48),
                     .STD_W              (60),
                     .SUPPORT_CHAIN_WR   (1'b1)
                 ) awstd_ctrl (
                     .clk                (clk),
                     .rst_n              (rst_n),
                     .cmd_valid          (start_to_ctrl),
                     .cmd_ready          (ctrl_ready),
                     .cmd_op             (dq_op),
                     .aw_addr            (dq_addr),
                     .aw_wdata           (dq_wdata),
                     .aw_ctrl_low13      (dq_low13),
                     .std_payload        (dq_std),
                     .aw_chain_addr10_wr (dq_dcaddr),
                     .aw_chain_addr10_rd (dq_dcaddr),
                     .aw_chain_wdata     (dq_dcwdata),
                     .resp_done          (resp_done),
                     .std_rx             (std_rx),
                     .aw_chain_rx        (aw_chain_rx),
                     .sclk               (sclk),
                     .cs_n               (cs_n),
                     .mosi               (mosi),
                     .miso               (miso),
                     // .sdi            (sdi),
                     .pdi                (pdi),
                     // .sdo            (sdo),
                     .cpol               (cmd_cpol),
                     .cpha               (cmd_cpha)
                 );


// ---------------- SPI→AXI response CDC ----------------
spi_resp_cdc #(
                 .W             (W),
                 .STD_W         (STD_W),
                 .N_DEV         (N_DEV)
             ) u_resp_cdc (
                 .sclk          (clk),
                 .s_rst_n       (rst_n),
                 .resp_done     (resp_done),
                 .std_rx        (std_rx),
                 .aw_chain_rx   (aw_chain_rx),
                 .aclk          (s00_axi_aclk),
                 .a_rst_n       (s00_axi_aresetn),
                 .std_ro_load   (std_ro_load),
                 .std_ro_data   (std_ro_data),
                 .chain_ro_load (chain_ro_load),
                 .chain_ro_data (chain_ro_data_bus)
             );


endmodule
