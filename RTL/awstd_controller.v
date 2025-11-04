`timescale 1ns/1ps
module awstd_controller #(
    parameter integer MAX_BITS         = 240,
    parameter integer CLK_DIV          = 1,    // clk=200MHz, CLK_DIV=1 → SCLK=100MHz
    parameter integer N_DEV            = 4,    // number of devices in chain
    parameter integer DATA_BITS        = 48,
    parameter integer STD_W            = 60,
    // If datasheet supports SDI/SDO chain write (60b write frame), set to 1.
    // Otherwise, chain write will fallback to PDI broadcast write.
    parameter         SUPPORT_CHAIN_WR = 1'b0
)(
    input  wire                   clk,
    input  wire                   rst_n,
    // Command
    input  wire                   cmd_valid,
    output reg                    cmd_ready,
    input  wire [2:0]             cmd_op,      // 000=STD_WR, 001=STD_RD, 010=AW_BCAST_WR,
                                               // 011=AW_CHAIN_RD, 100=AW_CHAIN_WR
    // Single/broadcast fields
    input  wire [9:0]             aw_addr,       // for broadcast/single
    input  wire [47:0]            aw_wdata,      // for broadcast/single
    input  wire [12:0]            aw_ctrl_low13, // PDI broadcast ctrl (contains addr10 etc.)
    input  wire [STD_W-1:0]       std_payload,   // standard SPI payload (e.g. 60b)
    // Per-device (chain) fields
    input  wire [N_DEV*10-1:0]    aw_chain_addr10_wr, // per-device write addr[9:0]
    input  wire [N_DEV*10-1:0]    aw_chain_addr10_rd, // per-device read  addr[9:0]
    input  wire [N_DEV*48-1:0]    aw_chain_wdata,     // per-device write data[47:0]
    // Response
    output reg                    resp_done,
    output reg [STD_W-1:0]        std_rx,
    output reg [N_DEV*48-1:0]     aw_chain_rx,   // {devN-1,...,dev0}, each 48b MSB-first after reverse
    // SPI physical pins
    output wire                   sclk,
    output wire                   cs_n,
    output wire                   mosi,
    input  wire                   miso,
    output wire                   pdi,
    // Mode
    input  wire                   cpol,
    input  wire                   cpha
);
    // ========= Builders =========
    // 60-bit serial frame builders (MSB-first)
    wire [59:0] serial60_rd_single, serial60_wr_bcast;
    aw_serial60_builder #(.DATA_IN_LSBF(1'b0), .PARITY_EN(1'b0)) u_srd_single (
        .addr10(aw_addr),    .data48_in(48'h0),     .frame60_msbf(serial60_rd_single)
    );
    aw_serial60_builder #(.DATA_IN_LSBF(1'b0), .PARITY_EN(1'b0)) u_swr_bcast (
        .addr10(aw_addr),    .data48_in(aw_wdata),  .frame60_msbf(serial60_wr_bcast)
    );

    // 62-bit PDI broadcast write (MSB-first)
    wire [61:0] bcast62;
    aw_broadcast62_builder #(.DATA_IN_LSBF(1'b0)) u_bct (
        .ctrl_low13(aw_ctrl_low13), .data48_in(aw_wdata), .frame62_msbf(bcast62)
    );

    // ====== CHAIN READ: per-device addr → 60b read pkts → concat ======
    wire [N_DEV*60-1:0] pkts60_rd;
    genvar gi_r;
    generate
      for (gi_r=0; gi_r<N_DEV; gi_r=gi_r+1) begin: GEN_PKTS_RD
        localparam integer AR_H = (gi_r+1)*10 - 1;
        localparam integer AR_L = gi_r*10;
        wire [9:0] addr_r_i = aw_chain_addr10_rd[AR_H:AR_L];

        wire [59:0] serial60_rd_i;
        aw_serial60_builder #(.DATA_IN_LSBF(1'b0), .PARITY_EN(1'b0)) u_srd_i (
            .addr10(addr_r_i), .data48_in(48'h0), .frame60_msbf(serial60_rd_i)
        );

        localparam integer RD_H = (gi_r+1)*60 - 1;
        localparam integer RD_L = gi_r*60;
        assign pkts60_rd[RD_H:RD_L] = serial60_rd_i;
      end
    endgenerate

    wire [N_DEV*60-1:0] chain_rd_cmd;
    // REVERSE_ORDER: set according to your physical daisy direction
    aw_chain_concat #(.N(N_DEV), .REVERSE_ORDER(1)) u_chain_rd (
        .pkts60_each_ic(pkts60_rd),
        .chain_msbf(chain_rd_cmd)
    );

    // ====== CHAIN WRITE: per-device addr+data → 60b write pkts → concat ======
    wire [N_DEV*60-1:0] pkts60_wr;
    genvar gi_w;
    generate
      for (gi_w=0; gi_w<N_DEV; gi_w=gi_w+1) begin: GEN_PKTS_WR
        localparam integer AW_H = (gi_w+1)*10 - 1;
        localparam integer AW_L = gi_w*10;
        localparam integer DW_H = (gi_w+1)*48 - 1;
        localparam integer DW_L = gi_w*48;

        wire [9:0]  addr_w_i = aw_chain_addr10_wr[AW_H:AW_L];
        wire [47:0] wdata_i  = aw_chain_wdata[DW_H:DW_L];

        wire [59:0] serial60_wr_i;
        aw_serial60_builder #(.DATA_IN_LSBF(1'b0), .PARITY_EN(1'b0)) u_swr_i (
            .addr10(addr_w_i), .data48_in(wdata_i), .frame60_msbf(serial60_wr_i)
        );

        localparam integer WR_H = (gi_w+1)*60 - 1;
        localparam integer WR_L = gi_w*60;
        assign pkts60_wr[WR_H:WR_L] = serial60_wr_i;
      end
    endgenerate

    wire [N_DEV*60-1:0] chain_wr_cmd;
    aw_chain_concat #(.N(N_DEV), .REVERSE_ORDER(1)) u_chain_wr (
        .pkts60_each_ic(pkts60_wr),
        .chain_msbf(chain_wr_cmd)
    );

    // ========= Connect to routing layer (bit-engine) =========
    reg                start;
    reg  [15:0]        bit_count;
    reg  [MAX_BITS-1:0]tx_bits;
    wire [MAX_BITS-1:0]rx_bits;
    wire               busy, done;
    reg  mode_awmf, use_pdi, present_first_bit;

    wire sclk_i, cs_n_i, mosi_i, sdi_i, pdi_i;

    // cmd_valid rising edge (sync)
    reg cmd_meta, cmd_sync, cmd_sync_d;
    always @(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
        cmd_meta<=1'b0; cmd_sync<=1'b0; cmd_sync_d<=1'b0;
      end else begin
        cmd_meta<=cmd_valid; cmd_sync<=cmd_meta; cmd_sync_d<=cmd_sync;
      end
    end
    wire cmd_rise    = cmd_sync & ~cmd_sync_d;

    // FSM
    localparam S_IDLE=2'd0, S_GO=2'd1, S_WAIT=2'd2, S_DONE=2'd3;
    reg [1:0] st, nst;
    wire start_pulse = cmd_rise & (st==S_IDLE);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) st<=S_IDLE; else st<=nst;
    end
    always @* begin
        nst = st;
        case(st)
            S_IDLE: if (start_pulse) nst=S_GO;
            S_GO:   nst=S_WAIT;
            S_WAIT: if (done) nst=S_DONE;
            S_DONE: nst=S_IDLE;
            default:nst=S_IDLE;
        endcase
    end

    spi_master_top #(.MAX_BITS(MAX_BITS), .CLK_DIV(CLK_DIV)) u_top (
        .clk(clk), .rst_n(rst_n),
        .start(start), .bit_count(bit_count), .tx_bits(tx_bits), .rx_bits(rx_bits),
        .busy(busy), .done(done),
        .mode_awmf(mode_awmf), .use_pdi(use_pdi),
        .cpol(cpol), .cpha(cpha), .present_first_bit(present_first_bit),
        .sclk(sclk_i), .cs_n(cs_n_i), .mosi(mosi_i), .miso(miso),
        .sdi(sdi_i), .pdi(pdi_i), .sdo(miso)
    );

    // 5-pin to out
    assign sclk = sclk_i;
    assign cs_n = cs_n_i;
    // AW mode uses SDI as the "MOSI" line; STD mode uses MOSI
    assign mosi = (mode_awmf) ? sdi_i : mosi_i;
    // PDI only for AWMF broadcast; STD mode drives 0
    assign pdi  = (mode_awmf) ? pdi_i : 1'b0;

    // ====== Constants ======
    localparam integer BCAST_BITS  = 62;
    localparam integer SERIAL_BITS = 60;
    localparam integer CHAIN_BITS  = (N_DEV*60);

    // ====== RX post-process for CHAIN_RD (generic N_DEV) ======
    // Build a combinational bus aw_chain_rx_comb from rx_bits:
    // split into 60b segments, take [47:0], bit-reverse each, pack into {N-1..0}
    wire [N_DEV*48-1:0] aw_chain_rx_comb;
    genvar gi_x;
    generate
      for (gi_x=0; gi_x<N_DEV; gi_x=gi_x+1) begin: GEN_RX_PACK
        localparam integer S_H = (gi_x+1)*60 - 1;
        localparam integer S_L = gi_x*60;
        wire [59:0] seg_i = rx_bits[S_H:S_L];
        wire [47:0] raw48 = seg_i[47:0];
        // wire [47:0] msb48;
        // bit_reverse #(.W(48)) u_rev_i (.in_bits(raw48), .out_bits(msb48));

        localparam integer R_H = (gi_x+1)*48 - 1;
        localparam integer R_L = gi_x*48;
        // assign aw_chain_rx_comb[R_H:R_L] = msb48;
        assign aw_chain_rx_comb[R_H:R_L] = raw48;
      end
    endgenerate

    // ====== Command issue / result latch ======
    localparam [2:0] OP_STD_WR      = 3'b000;
    localparam [2:0] OP_STD_RD      = 3'b001;
    localparam [2:0] OP_AW_BCAST_WR = 3'b010;
    localparam [2:0] OP_AW_CHAIN_RD = 3'b011;
    localparam [2:0] OP_AW_CHAIN_WR = 3'b100;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cmd_ready<=1'b1; resp_done<=1'b0;
            start<=1'b0; bit_count<=16'd0; tx_bits<={MAX_BITS{1'b0}};
            mode_awmf<=1'b0; use_pdi<=1'b0; present_first_bit<=1'b0;
            std_rx<={STD_W{1'b0}}; aw_chain_rx<={(N_DEV*48){1'b0}};
        end else begin
            start<=1'b0; resp_done<=1'b0;
            case(st)
                S_IDLE: begin
                    cmd_ready<=1'b1;
                    if (start_pulse) begin
                        cmd_ready<=1'b0;
                        case (cmd_op)
                            OP_STD_WR: begin
                                mode_awmf<=1'b0; use_pdi<=1'b0; present_first_bit <= (cpha==1'b0);
                                bit_count<=STD_W[15:0];
                                tx_bits  <={{(MAX_BITS-STD_W){1'b0}}, std_payload};
                            end
                            OP_STD_RD: begin
                                mode_awmf<=1'b0; use_pdi<=1'b0; present_first_bit <= (cpha==1'b0);
                                bit_count<=STD_W[15:0];
                                tx_bits  <={{(MAX_BITS-STD_W){1'b0}}, std_payload};
                            end
                            OP_AW_BCAST_WR: begin
                                mode_awmf<=1'b1; use_pdi<=1'b1; present_first_bit<=1'b1;
                                bit_count<=BCAST_BITS[15:0];
                                tx_bits  <={{(MAX_BITS-BCAST_BITS){1'b0}}, bcast62};
                            end
                            OP_AW_CHAIN_RD: begin
                                mode_awmf<=1'b1; use_pdi<=1'b0; present_first_bit<=1'b1;
                                bit_count<=CHAIN_BITS[15:0];
                                tx_bits  <={{(MAX_BITS-CHAIN_BITS){1'b0}}, chain_rd_cmd};
                            end
                            OP_AW_CHAIN_WR: begin
                                if (SUPPORT_CHAIN_WR) begin
                                  // TRUE chain write: per-device addr+data, one CS low
                                  mode_awmf<=1'b1; use_pdi<=1'b0; present_first_bit<=1'b1;
                                  bit_count<=CHAIN_BITS[15:0];
                                  tx_bits  <={{(MAX_BITS-CHAIN_BITS){1'b0}}, chain_wr_cmd};
                                end else begin
                                  // Fallback: use PDI broadcast write (same addr+data)
                                  mode_awmf<=1'b1; use_pdi<=1'b1; present_first_bit<=1'b1;
                                  bit_count<=BCAST_BITS[15:0];
                                  tx_bits  <={{(MAX_BITS-BCAST_BITS){1'b0}}, bcast62};
                                end
                            end
                            default: begin
                                mode_awmf<=1'b0; use_pdi<=1'b0; present_first_bit<=1'b0;
                                bit_count<=16'd0; tx_bits<={MAX_BITS{1'b0}};
                            end
                        endcase
                    end
                end
                S_GO:   start<=1'b1;
                S_WAIT: ; // wait for bit engine
                S_DONE: begin
                    resp_done<=1'b1;
                    if (cmd_op==OP_STD_WR || cmd_op==OP_STD_RD) begin
                        std_rx <= rx_bits[STD_W-1:0];
                    end
                    if (cmd_op==OP_AW_CHAIN_WR || cmd_op==OP_AW_CHAIN_RD) begin
                        aw_chain_rx <= aw_chain_rx_comb; // generic N
                    end
                end
            endcase
        end
    end
endmodule
