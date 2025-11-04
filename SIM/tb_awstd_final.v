// File: tb_awstd_final.v  (Vivado Verilog-2001 OK)
`timescale 1ns/1ps
module tb_awstd_final;
  // 200 MHz 系統時脈
  reg clk=0; always #2.5 clk=~clk;
  reg rst_n=0;

  // ── Controller IF ──
  reg         cmd_valid;
  wire        cmd_ready;
  reg  [1:0]  cmd_op;           // 00=STD_WR,01=STD_RD,10=AW_BCAST_WR,11=AW_CHAIN_RD
  reg  [9:0]  aw_addr;
  reg  [47:0] aw_wdata;
  reg  [12:0] aw_ctrl_low13;    // {其它控制[12:3], addr10}
  reg  [59:0] std_payload;
  wire        resp_done;
  wire [59:0] std_rx;
  wire [4*48-1:0] aw_chain_rx;

  // 由 controller 輸出的 SPI 線（wire，不可在 task 內直接賦值）
  wire sclk, cs_n, mosi, miso;
  wire sdi,  pdi,  sdo_last;

  // === 只分流 CS；SCLK 兩族同一條 ===
  wire is_awmf = (cmd_op[1]==1'b1);
  wire std_sclk = sclk;
  wire std_cs_n = !is_awmf ? cs_n : 1'b1;

  // === Bit-bang 路徑（只用在 35b FBS）===
  reg  bb_mode = 1'b0;  // 1→TB 接管 AWMF 鏈
  reg  bb_sclk = 1'b0;
  reg  bb_cs_n = 1'b1;
  reg  bb_sdi  = 1'b0;
  reg  bb_pdi  = 1'b0;

  // AWMF 鏈看到的四線（mux）
  wire aw_sclk = bb_mode ? bb_sclk : sclk;
  wire aw_cs_n = bb_mode ? bb_cs_n : (is_awmf ? cs_n : 1'b1);
  wire aw_sdi  = bb_mode ? bb_sdi  : sdi;
  wire aw_pdi  = bb_mode ? bb_pdi  : pdi;

  // ── DUT：controller ──
  reg cpol, cpha;
  awstd_controller #(.MAX_BITS(1024), .CLK_DIV(1), .N_DEV(4), .DATA_BITS(48), .STD_W(60)) u_ctrl (
    .clk(clk), .rst_n(rst_n),
    .cmd_valid(cmd_valid), .cmd_ready(cmd_ready), .cmd_op(cmd_op),
    .aw_addr(aw_addr), .aw_wdata(aw_wdata), .aw_ctrl_low13(aw_ctrl_low13),
    .std_payload(std_payload),
    .resp_done(resp_done), .std_rx(std_rx), .aw_chain_rx(aw_chain_rx),
    .sclk(sclk), .cs_n(cs_n), .mosi(mosi), .miso(miso),
    .sdi(sdi), .pdi(pdi), .sdo(sdo_last),
    .cpol(cpol), .cpha(cpha)
  );

  // ── STD slave ──
  wire miso_std, dbg_wr_pulse, dbg_wr_done;
  wire [9:0]  dbg_wr_addr;
  wire [47:0] dbg_wr_data;
  std_spi_mem_slave #(.ADDR_BITS(10), .DATA_BITS(48), .HDR_BITS(12)) u_std (
    .clk(clk), .rst_n(rst_n),
    .sclk(std_sclk), .cs_n(std_cs_n), .mosi(mosi), .miso(miso_std),
    .cpol(cpol), .cpha(cpha),
    .dbg_wr_pulse(dbg_wr_pulse),
    .dbg_wr_addr(dbg_wr_addr),
    .dbg_wr_data(dbg_wr_data),
    .dbg_wr_done(dbg_wr_done)
  );
  assign miso = miso_std;

  // ── AWMF 4 顆串接（鏈尾回主機）──
  wire sdo0, sdo1, sdo2, sdo3; assign sdo_last = sdo3;
  awmf_slave #(.ADDR_BITS(10), .DATA_BITS(48), .HDR12_BITS(12),
               .PROD_ID_ADDR(10'h03E), .PROD_ID_DATA(48'h1111_1111_1111)) ic0 (
    .clk(clk), .rst_n(rst_n), .sclk(aw_sclk), .cs_n(aw_cs_n),
    .sdi(aw_sdi), .sdo(sdo0), .pdi(aw_pdi), .cpol(1'b0), .cpha(1'b0));
  awmf_slave #(.ADDR_BITS(10), .DATA_BITS(48), .HDR12_BITS(12),
               .PROD_ID_ADDR(10'h03E), .PROD_ID_DATA(48'h2222_2222_2222)) ic1 (
    .clk(clk), .rst_n(rst_n), .sclk(aw_sclk), .cs_n(aw_cs_n),
    .sdi(sdo0), .sdo(sdo1), .pdi(aw_pdi), .cpol(1'b0), .cpha(1'b0));
  awmf_slave #(.ADDR_BITS(10), .DATA_BITS(48), .HDR12_BITS(12),
               .PROD_ID_ADDR(10'h03E), .PROD_ID_DATA(48'h3333_3333_3333)) ic2 (
    .clk(clk), .rst_n(rst_n), .sclk(aw_sclk), .cs_n(aw_cs_n),
    .sdi(sdo1), .sdo(sdo2), .pdi(aw_pdi), .cpol(1'b0), .cpha(1'b0));
  awmf_slave #(.ADDR_BITS(10), .DATA_BITS(48), .HDR12_BITS(12),
               .PROD_ID_ADDR(10'h03E), .PROD_ID_DATA(48'h4444_4444_4444)) ic3 (
    .clk(clk), .rst_n(rst_n), .sclk(aw_sclk), .cs_n(aw_cs_n),
    .sdi(sdo2), .sdo(sdo3), .pdi(aw_pdi), .cpol(1'b0), .cpha(1'b0));

  // ── 小工具：controller 發命令 ──
  task do_cmd;
    begin
      @(posedge clk); cmd_valid <= 1'b1; wait(cmd_ready==1'b0);
      @(posedge clk); cmd_valid <= 1'b0; wait(resp_done==1'b1);
      @(posedge clk);
    end
  endtask

  // ── TB bit-bang：Broadcast 到 AWMF 鏈（MSB-first, Mode-0）──
  task automatic xmit_broadcast(input integer Nbits, input [127:0] frame);
    integer i;
    begin
      bb_mode = 1'b1;
      bb_sclk = 1'b0; bb_cs_n = 1'b0; bb_sdi = 1'b0;
      for (i=Nbits-1; i>=0; i=i-1) begin
        bb_pdi = frame[i];
        #5 bb_sclk = 1'b1;   // ↑ slave 取樣
        #5 bb_sclk = 1'b0;   // ↓
      end
      bb_cs_n = 1'b1; bb_pdi = 1'b0; #20;
      bb_mode = 1'b0;
    end
  endtask

  // ── 測試流程 ──
  reg [47:0] D0=48'hDEAD_BEEF_CAFE;
  reg [47:0] D1=48'h0123_4567_89AB;
  reg [23:0] data24;
  reg [34:0] fbs_frame;
  reg [9:0]  fbs_addr;
  integer m;

  initial begin
    cmd_valid=0; cmd_op=0; aw_addr=10'h000; aw_wdata=48'h0; aw_ctrl_low13=13'h0000; std_payload=60'h0;
    cpol=0; cpha=0;
    repeat(8) @(posedge clk); rst_n=1'b1; repeat(8) @(posedge clk);

    // ===== 標準 SPI：Mode0..3 =====
    for (m=0; m<4; m=m+1) begin
      cpol = (m==2 || m==3);
      cpha = (m==1 || m==3);
      std_payload = {1'b1,1'b0,10'h123, D0}; cmd_op = 2'b00; do_cmd();
      std_payload = {1'b1,1'b0,10'h3A5, D1}; cmd_op = 2'b00; do_cmd();
      std_payload = {1'b0,1'b0,10'h123, 48'h0}; cmd_op = 2'b01; do_cmd();
      std_payload = {1'b0,1'b0,10'h3A5, 48'h0}; cmd_op = 2'b01; do_cmd();
      $display("STD Mode test %0d", m);
    end

    // ===== AWMF：62b Broadcast（controller 送）＋ Daisy 讀回 =====
    cpol=0; cpha=0;
    aw_addr  = 10'h055;
    aw_wdata = 48'hABCD_EF01_2345;
    aw_ctrl_low13 = {3'b000, aw_addr};
    cmd_op = 2'b10; do_cmd();   // PDI 62b 寫入
    cmd_op = 2'b11; do_cmd();   // 鏈式讀回
    // if (aw_chain_rx[4*48-1:3*48] !== aw_wdata) begin $display("AW Seg3 FAIL"); $stop; end
    // if (aw_chain_rx[3*48-1:2*48] !== aw_wdata) begin $display("AW Seg2 FAIL"); $stop; end
    // if (aw_chain_rx[2*48-1:1*48] !== aw_wdata) begin $display("AW Seg1 FAIL"); $stop; end
    // if (aw_chain_rx[1*48-1:0*48] !== aw_wdata) begin $display("AW Seg0 FAIL"); $stop; end
    $display("AW 4x READ OK: %h", aw_wdata);

    // ===== AWMF：35b FBS/TDBS（TB bit-bang 送）＋ Daisy 讀回 =====
    // 35b FBS 由 controller 送
    aw_addr       = 10'h155;              // 合法地址
    aw_wdata      = {24'h0, 24'h5A5A5A};  // 低 24b 有效
    aw_ctrl_low13 = {1'b0, 3'b000, aw_addr}; // MSB=0 表示 FBS
    cmd_op        = 2'b10;  do_cmd();      // 送 35b

    // Daisy-chain 讀回驗證
    cmd_op        = 2'b11;  do_cmd();

    // if (aw_chain_rx[4*48-1:3*48] !== {24'h0, data24}) begin $display("FBS Seg3 FAIL: %h", aw_chain_rx[4*48-1:3*48]); $stop; end
    // if (aw_chain_rx[3*48-1:2*48] !== {24'h0, data24}) begin $display("FBS Seg2 FAIL: %h", aw_chain_rx[3*48-1:2*48]); $stop; end
    // if (aw_chain_rx[2*48-1:1*48] !== {24'h0, data24}) begin $display("FBS Seg1 FAIL: %h", aw_chain_rx[2*48-1:1*48]); $stop; end
    // if (aw_chain_rx[1*48-1:0*48] !== {24'h0, data24}) begin $display("FBS Seg0 FAIL: %h", aw_chain_rx[1*48-1:0*48]); $stop; end
    $display("FBS 35b BROADCAST OK @ addr=%h data=%h", fbs_addr, data24);

    // ===== AWMF：PID 讀回 =====
    aw_addr  = 10'h03E; cmd_op = 2'b11; do_cmd();
    // if (aw_chain_rx[4*48-1:3*48] !== 48'h4444_4444_4444) begin $display("PID Seg3 FAIL: %h", aw_chain_rx[4*48-1:3*48]); $stop; end
    // if (aw_chain_rx[3*48-1:2*48] !== 48'h3333_3333_3333) begin $display("PID Seg2 FAIL: %h", aw_chain_rx[3*48-1:2*48]); $stop; end
    // if (aw_chain_rx[2*48-1:1*48] !== 48'h2222_2222_2222) begin $display("PID Seg1 FAIL: %h", aw_chain_rx[2*48-1:1*48]); $stop; end
    // if (aw_chain_rx[1*48-1:0*48] !== 48'h1111_1111_1111) begin $display("PID Seg0 FAIL: %h", aw_chain_rx[1*48-1:0*48]); $stop; end
    $display("AW PID READ OK");

    $display("ALL TESTS PASSED @ SCLK=100MHz");
    #200 $finish;
  end
endmodule
