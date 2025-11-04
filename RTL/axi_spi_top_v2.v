`timescale 1ns/1ps
module axi_spi_top #(
           parameter integer NUM_REGS               = 18,
           parameter integer STD_W                  = 60,
           parameter integer N_DEV                  = 4,    // Daisy-Chain 4
           parameter integer C_S00_AXI_DATA_WIDTH   = 32,
           parameter integer C_S00_AXI_ADDR_WIDTH   = 24,
           // NEW: 每欄位 FIFO 深度（可依吞吐調整）
           parameter integer CMD_FIFO_DEPTH         = 16
       )(
           // AXI4-Lite
           input  wire                                  s00_axi_aclk,
           input  wire                                  s00_axi_aresetn,
           input  wire [C_S00_AXI_ADDR_WIDTH-1 : 0]     s00_axi_awaddr,
           input  wire [2 : 0]                          s00_axi_awprot,
           input  wire                                  s00_axi_awvalid,
           output wire                                  s00_axi_awready,
           input  wire [C_S00_AXI_DATA_WIDTH-1 : 0]     s00_axi_wdata,
           input  wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
           input  wire                                  s00_axi_wvalid,
           output wire                                  s00_axi_wready,
           output wire [1 : 0]                          s00_axi_bresp,
           output wire                                  s00_axi_bvalid,
           input  wire                                  s00_axi_bready,
           input  wire [C_S00_AXI_ADDR_WIDTH-1 : 0]     s00_axi_araddr,
           input  wire [2 : 0]                          s00_axi_arprot,
           input  wire                                  s00_axi_arvalid,
           output wire                                  s00_axi_arready,
           output wire [C_S00_AXI_DATA_WIDTH-1 : 0]     s00_axi_rdata,
           output wire [1 : 0]                          s00_axi_rresp,
           output wire                                  s00_axi_rvalid,
           input  wire                                  s00_axi_rready,

           // SPI clk/rst
           input  wire                                  spi_Mclk,
           input  wire                                  spi_ressetn,
           input  wire                                  start,  // 保留不用
           // SPI pins
           output wire                                  sclk,
           output wire                                  cs_n,
           output wire                                  mosi,
           input  wire                                  miso,
           output wire                                  pdi
       );

localparam integer W            = C_S00_AXI_DATA_WIDTH;
localparam integer REGS_PER_DEV = (48+W-1)/W;   // 2
localparam integer NUM_RO       = N_DEV*REGS_PER_DEV;
localparam integer STD_REGS     = (STD_W + W - 1)/W; // 2

wire clk   = spi_Mclk;
wire rst_n = spi_ressetn;

// ---------------- AXI register readback bus ----------------
wire [NUM_REGS*W-1:0] data_out_bus;

wire [W-1:0] data_out0  = data_out_bus[0*W +: W];
wire [W-1:0] data_out1  = data_out_bus[1*W +: W];
wire [W-1:0] data_out2  = data_out_bus[2*W +: W];
wire [W-1:0] data_out3  = data_out_bus[3*W +: W];
wire [W-1:0] data_out4  = data_out_bus[4*W +: W];
wire [W-1:0] data_out5  = data_out_bus[5*W +: W];
wire [W-1:0] data_out6  = data_out_bus[6*W +: W];
wire [W-1:0] data_out7  = data_out_bus[7*W +: W];
// RO (std)
wire [W-1:0] std_ro_lo  = data_out_bus[8*W +: W];
wire [W-1:0] std_ro_hi  = data_out_bus[9*W +: W];
// chain write
wire [W-1:0] data_out10 = data_out_bus[10*W +: W];
wire [W-1:0] data_out11 = data_out_bus[11*W +: W];
wire [W-1:0] data_out12 = data_out_bus[12*W +: W];
wire [W-1:0] data_out13 = data_out_bus[13*W +: W];
wire [W-1:0] data_out14 = data_out_bus[14*W +: W];
wire [W-1:0] data_out15 = data_out_bus[15*W +: W];
wire [W-1:0] data_out16 = data_out_bus[16*W +: W];
wire [W-1:0] data_out17 = data_out_bus[17*W +: W];

// ---------------- SPI→AXI response CDC (沿用) ----------------
wire [STD_REGS*W-1:0] std_ro_data;
wire [NUM_RO*W-1:0]   chain_ro_data_bus;
wire                  std_ro_load, chain_ro_load;

// Daisy-chain RX 拆包（沿用）
reg  [W-1:0] axi_chain_rd [0:NUM_RO-1];
wire [STD_W-1:0]    std_rx;
wire [N_DEV*48-1:0] aw_chain_rx;
wire                resp_done;

genvar gi;
generate
  for (gi=0; gi<N_DEV; gi=gi+1) begin: GEN_SPLIT
    localparam integer D_H = (gi+1)*48 - 1;
    localparam integer D_L = gi*48;
    wire [47:0] dev48_i = aw_chain_rx[D_H:D_L];
    localparam integer R_LO = gi*REGS_PER_DEV;
    localparam integer R_HI = gi*REGS_PER_DEV + 1;
    always @(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
        axi_chain_rd[R_LO] <= {W{1'b0}};
        axi_chain_rd[R_HI] <= {W{1'b0}};
      end else if (resp_done) begin
        axi_chain_rd[R_LO] <= dev48_i[31:0];
        axi_chain_rd[R_HI] <= {{(W-16){1'b0}}, dev48_i[47:32]};
      end
    end
  end
endgenerate

genvar bj;
generate
  for (bj=0; bj<NUM_RO; bj=bj+1) begin: GEN_PACK
    assign chain_ro_data_bus[bj*W +: W] = axi_chain_rd[bj];
  end
endgenerate

// ---------------- AXI_lite_to_Reg (原樣) ----------------
AXI_lite_to_Reg # (
  .NUM_REGS           (NUM_REGS + NUM_RO),
  .CHAIN_N_DEV        (N_DEV),
  .CHAIN_RO_BASE      (NUM_REGS),
  .C_S_AXI_DATA_WIDTH (C_S00_AXI_DATA_WIDTH),
  .C_S_AXI_ADDR_WIDTH (C_S00_AXI_ADDR_WIDTH)
) AXI_lite_to_Reg_i (
  .S_AXI_ACLK   (s00_axi_aclk),
  .S_AXI_ARESETN(s00_axi_aresetn),
  .S_AXI_AWADDR (s00_axi_awaddr),
  .S_AXI_AWPROT (s00_axi_awprot),
  .S_AXI_AWVALID(s00_axi_awvalid),
  .S_AXI_AWREADY(s00_axi_awready),
  .S_AXI_WDATA  (s00_axi_wdata),
  .S_AXI_WSTRB  (s00_axi_wstrb),
  .S_AXI_WVALID (s00_axi_wvalid),
  .S_AXI_WREADY (s00_axi_wready),
  .S_AXI_BRESP  (s00_axi_bresp),
  .S_AXI_BVALID (s00_axi_bvalid),
  .S_AXI_BREADY (s00_axi_bready),
  .S_AXI_ARADDR (s00_axi_araddr),
  .S_AXI_ARPROT (s00_axi_arprot),
  .S_AXI_ARVALID(s00_axi_arvalid),
  .S_AXI_ARREADY(s00_axi_arready),
  .S_AXI_RDATA  (s00_axi_rdata),
  .S_AXI_RRESP  (s00_axi_rresp),
  .S_AXI_RVALID (s00_axi_rvalid),
  .S_AXI_RREADY (s00_axi_rready),
  .std_ro_data  (std_ro_data),
  .std_ro_load  (std_ro_load),
  .chain_ro_data(chain_ro_data_bus),
  .chain_ro_load(chain_ro_load),
  .Data_out     (data_out_bus)
);

// ============================================================================
// ====================== NEW: 每欄位一個 FIFO + 嚴格背壓 ======================
// ============================================================================

localparam integer NWORDS = 18;
// 8/9 是 RO，不入 FIFO：11111111_00_11111111
localparam [NWORDS-1:0] NEED_MASK = 18'b111111110011111111;

// AXI domain：偵測 GO 上升緣 → 同拍把 0..17 寫進各自 FIFO
wire axi_go = data_out1[0];
reg  axi_go_d;
always @(posedge s00_axi_aclk or negedge s00_axi_aresetn) begin
  if (!s00_axi_aresetn) axi_go_d <= 1'b0;
  else                  axi_go_d <= axi_go;
end
wire axi_go_pulse = axi_go & ~axi_go_d;

// FIFO buses
wire [NWORDS*W-1:0] fifo_dout_bus;
wire [NWORDS-1:0]   fifo_empty;
wire [NWORDS-1:0]   fifo_full;
reg  [NWORDS-1:0]   fifo_rd_en;

wire fifo_full_any = |(fifo_full & NEED_MASK);

// 產生 18 個 async FIFO（FWFT）
genvar gf;
generate
  for (gf=0; gf<NWORDS; gf=gf+1) begin: GEN_CMD_FIFOS
    xpm_fifo_async #(
      .FIFO_MEMORY_TYPE ("block"),
      .FIFO_WRITE_DEPTH (CMD_FIFO_DEPTH),
      .WRITE_DATA_WIDTH (W),
      .READ_DATA_WIDTH  (W),
      .READ_MODE        ("fwft"),   // 立即可見第一筆
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
      .data_valid    (),            // FWFT -> 用 !empty
      .rd_rst_busy   (),
      .sleep(1'b0), .injectdbiterr(1'b0), .injectsbiterr(1'b0),
      .sbiterr(), .dbiterr(), .prog_empty(), .prog_full(),
      .wr_data_count(), .rd_data_count()
    );
  end
endgenerate

// 所有必要 FIFO 非空 → 有一整筆 ready
wire all_needed_ready = ~| ( (fifo_empty) & NEED_MASK );

// 對齊暫存（只在「要發」時才鎖）與發射
reg [W-1:0] w0,w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15,w16,w17;
reg         go_latched;
reg         start_to_ctrl;
wire        ctrl_ready;

// 狀態機：WAIT → LAUNCH → BUSY，BUSY 等 resp_done 再回 WAIT
localparam S_WAIT=2'd0, S_LAUNCH=2'd1, S_BUSY=2'd2;
reg [1:0] st, nst;

always @* begin
  nst = st;
  fifo_rd_en = {NWORDS{1'b0}};
  case (st)
    S_WAIT: begin
      // 僅當 controller 空閒且整筆 ready 才進入發射流程
      if (ctrl_ready && all_needed_ready)
        nst = S_LAUNCH;
    end
    S_LAUNCH: begin
      // 同拍 pop 一整筆（8/9 不讀）；若 GO=1 進 BUSY，否則回 WAIT
      fifo_rd_en = NEED_MASK;
      if (go_latched) nst = S_BUSY;
      else            nst = S_WAIT; // NOP：丟掉不發，不卡住
    end
    S_BUSY: begin
      if (resp_done) nst = S_WAIT;  // 正式傳送完畢才允許下一筆
    end
    default: nst = S_WAIT;
  endcase
end

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    st <= S_WAIT;
    start_to_ctrl <= 1'b0;
    go_latched    <= 1'b0;
    {w0,w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15,w16,w17} <= {18{32'h0}};
  end else begin
    st <= nst;
    start_to_ctrl <= 1'b0;

    case (st)
      S_WAIT: begin
        if (ctrl_ready && all_needed_ready) begin
          // 只在要發時才鎖住一整筆
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
          go_latched <= fifo_dout_bus[1*W + 0]; // 只用鎖住的 GO
        end
      end

      S_LAUNCH: begin
        // 用鎖住的 GO 發 1 拍 start；同拍在上面的組合區 pop FIFO
        start_to_ctrl <= go_latched;
      end

      S_BUSY: begin
        // 等 resp_done；不做任何取數或發射
      end
    endcase
  end
end

// 還原給 controller 的欄位
wire [2:0]  dq_op     = w1[3:1];
wire        dq_cpol   = w1[4];
wire        dq_cpha   = w1[5];
wire [9:0]  dq_addr   = w2[9:0];
wire [47:0] dq_wdata  = {w4[15:0], w3};
wire [12:0] dq_low13  = w5[12:0];
wire [STD_W-1:0] dq_std = {w7[27:0], w6};
wire [N_DEV*10-1:0] dq_caddr =
     {w17[25:16], w15[25:16], w13[25:16], w11[25:16]};
wire [N_DEV*48-1:0] dq_cwdata =
     {w17[15:0], w16, w15[15:0], w14, w13[15:0], w12, w11[15:0], w10};

// ---------------- AWMF controller ----------------
awstd_controller #(
  .MAX_BITS           (1024),
  .CLK_DIV            (1),
  .N_DEV              (N_DEV),
  .DATA_BITS          (48),
  .STD_W              (STD_W),
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
  .aw_chain_addr10_wr ({w17[25:16], w15[25:16], w13[25:16], w11[25:16]}),
  .aw_chain_addr10_rd ({w17[25:16], w15[25:16], w13[25:16], w11[25:16]}),
  .aw_chain_wdata     ({w17[15:0], w16, w15[15:0], w14, w13[15:0], w12, w11[15:0], w10}),
  .resp_done          (resp_done),
  .std_rx             (std_rx),
  .aw_chain_rx        (aw_chain_rx),
  .sclk               (sclk),
  .cs_n               (cs_n),
  .mosi               (mosi),
  .miso               (miso),
  .pdi                (pdi),
  .cpol               (dq_cpol),
  .cpha               (dq_cpha)
);

// ---------------- SPI→AXI response CDC（與你一樣） ----------------
spi_resp_cdc #(
  .W     (W),
  .STD_W (STD_W),
  .N_DEV (N_DEV)
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

//------------------------------------------------------------------------------
//  spi_resp_cdc（保持原樣）
//------------------------------------------------------------------------------
module spi_resp_cdc #(
  parameter integer W      = 32,
  parameter integer STD_W  = 60,
  parameter integer N_DEV  = 4
)(
  input  wire                 sclk,
  input  wire                 s_rst_n,
  input  wire                 resp_done,
  input  wire [STD_W-1:0]     std_rx,
  input  wire [N_DEV*48-1:0]  aw_chain_rx,
  input  wire                 aclk,
  input  wire                 a_rst_n,
  output reg                  std_ro_load,
  output reg  [((STD_W+W-1)/W)*W -1:0] std_ro_data,
  output reg                  chain_ro_load,
  output reg  [(N_DEV*((48+W-1)/W)*W) -1:0] chain_ro_data
);
  localparam integer REGS_PER_DEV = (48+W-1)/W;

  reg [STD_W-1:0]    std_rx_shd;
  reg [N_DEV*48-1:0] chain_rx_shd;
  always @(posedge sclk or negedge s_rst_n) begin
    if (!s_rst_n) begin
      std_rx_shd   <= {STD_W{1'b0}};
      chain_rx_shd <= {(N_DEV*48){1'b0}};
    end else if (resp_done) begin
      std_rx_shd   <= std_rx;
      chain_rx_shd <= aw_chain_rx;
    end
  end

  wire resp_done_aclk;
  xpm_cdc_pulse #(
    .DEST_SYNC_FF(2), .INIT_SYNC_FF(1), .REG_OUTPUT(0), .RST_USED(1), .SIM_ASSERT_CHK(0)
  ) u_p (
    .src_clk  (sclk),
    .src_rst  (!s_rst_n),
    .src_pulse(resp_done),
    .dest_clk (aclk),
    .dest_rst (!a_rst_n),
    .dest_pulse(resp_done_aclk)
  );

  integer i;
  always @(posedge aclk or negedge a_rst_n) begin
    if (!a_rst_n) begin
      std_ro_load<=1'b0; chain_ro_load<=1'b0;
      std_ro_data<=0;     chain_ro_data<=0;
    end else begin
      std_ro_load<=1'b0; chain_ro_load<=1'b0;
      if (resp_done_aclk) begin
        std_ro_data[0*W +: W] <= std_rx_shd[31:0];
        std_ro_data[1*W +: W] <= {{(W-(STD_W-32)){1'b0}}, std_rx_shd[STD_W-1:32]};
        for (i=0;i<N_DEV;i=i+1) begin
          chain_ro_data[(i*REGS_PER_DEV+0)*W +: W] <= chain_rx_shd[i*48 +: 32];
          chain_ro_data[(i*REGS_PER_DEV+1)*W +: W] <= {{(W-16){1'b0}}, chain_rx_shd[i*48+32 +: 16]};
        end
        std_ro_load<=1'b1; chain_ro_load<=1'b1;
      end
    end
  end
endmodule
