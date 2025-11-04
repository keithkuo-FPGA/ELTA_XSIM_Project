// File: modular_slave.v (Verilog-2001 safe; CS gate fix + header latch fix)
`timescale 1ns/1ps
module modular_slave #(
    parameter integer ADDR_BITS = 10,
    parameter integer DATA_BITS = 48,
    parameter integer HDR_BITS  = 12
)(
    input  wire                   clk,    // ≥ 2x SCLK
    input  wire                   rst_n,
    input  wire                   sclk,
    input  wire                   cs_n,
    input  wire                   mosi,
    output reg                    miso,
    input  wire                   sdi,
    input  wire                   pdi,
    output reg                    sdo,
    input  wire                   ldb_n,
    input  wire                   mode_awmf,
    input  wire                   cpol,
    input  wire                   cpha
);
    localparam integer FRAME_BITS = HDR_BITS + DATA_BITS;

    // ---- 邊緣偵測（同步到 clk）----
    reg sclk_d1,sclk_d2, cs_d1,cs_d2, ldb_d1,ldb_d2;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sclk_d1<=0; sclk_d2<=0; cs_d1<=1; cs_d2<=1; ldb_d1<=1; ldb_d2<=1;
        end else begin
            sclk_d1<=sclk; sclk_d2<=sclk_d1;
            cs_d1<=cs_n;   cs_d2<=cs_d1;
            ldb_d1<=ldb_n; ldb_d2<=ldb_d1;
        end
    end
    wire sclk_rise =  (sclk_d1 & ~sclk_d2);
    wire sclk_fall = (~sclk_d1 &  sclk_d2);
    wire cs_fall   = (~cs_d1 &  cs_d2);
    wire cs_rise   = ( cs_d1 & ~cs_d2);
    wire ldb_fall  = (~ldb_d1 &  ldb_d2);

    wire leading_edge  = (cpol==1'b0) ? sclk_rise : sclk_fall;
    wire trailing_edge = (cpol==1'b0) ? sclk_fall : sclk_rise;
    wire sample_edge   = (cpha==1'b0) ? leading_edge  : trailing_edge;
    wire shift_edge    = (cpha==1'b0) ? trailing_edge : leading_edge;

    // ---- 內部狀態 ----
    reg [DATA_BITS-1:0]  regfile [0:(1<<ADDR_BITS)-1];
    reg [FRAME_BITS-1:0] sh_in;
    reg [DATA_BITS-1:0]  sh_out;
    reg [8:0]            bit_cnt;      // 計「取樣」次數（0..FRAME_BITS）
    reg [ADDR_BITS-1:0]  addr_lat;
    reg                  rw_lat;       // 1=寫, 0=讀
    reg                  in_bit_d;

    wire in_bit = mode_awmf ? (sdi | pdi) : mosi;

    // ★ 組合預估「下一拍」移位結果（含本次 in_bit）
    wire [FRAME_BITS-1:0] sh_in_next_w = {sh_in[FRAME_BITS-2:0], in_bit};
    wire [HDR_BITS-1:0]   hdr_next_w   = sh_in_next_w[HDR_BITS-1:0];

    integer i;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i=0;i<(1<<ADDR_BITS);i=i+1) regfile[i] <= {DATA_BITS{1'b0}};
            sh_in<={FRAME_BITS{1'b0}}; sh_out<={DATA_BITS{1'b0}};
            bit_cnt<=0; addr_lat<={ADDR_BITS{1'b0}}; rw_lat<=1'b0;
            miso<=1'b0; sdo<=1'b0; in_bit_d<=1'b0;
        end else begin
            // 起始：CS↓ 清狀態
            if (cs_fall) begin
                bit_cnt<=0; in_bit_d<=1'b0;
                if (mode_awmf) sdo<=1'b0; else miso<=1'b0;
            end

            // ===== 取樣邊緣 =====
            // ★ 改用「!cs_n」（即時 CS）當閘門，避免第一個 bit 被漏掉
            if (!cs_n && sample_edge) begin
                sh_in    <= sh_in_next_w;
                bit_cnt  <= bit_cnt + 1'b1;
                in_bit_d <= in_bit;

                // 收到第 HDR_BITS 個 header bit 時（這拍 hdr_next_w 已完整）
                if (bit_cnt == (HDR_BITS-1)) begin
                    rw_lat   <= hdr_next_w[HDR_BITS-1];
                    addr_lat <= hdr_next_w[ADDR_BITS-1:0];
                    if (hdr_next_w[HDR_BITS-1]==1'b0) begin
                        // 讀：預載輸出移位器
                        sh_out <= regfile[hdr_next_w[ADDR_BITS-1:0]];
                    end
                end
            end

            // ===== 切換邊緣（輸出）=====
            if (!cs_n && shift_edge) begin
                if (bit_cnt>=HDR_BITS && bit_cnt<FRAME_BITS && rw_lat==1'b0) begin
                    // 讀：在切換邊緣推出 MSB，下一拍主機在取樣邊緣收
                    if (mode_awmf) sdo <= sh_out[DATA_BITS-1];
                    else            miso<= sh_out[DATA_BITS-1];
                    sh_out <= {sh_out[DATA_BITS-2:0], 1'b0};
                end else begin
                    // header 或寫入期間：AW 模式做串接轉發；標準 MISO 維持 0
                    if (mode_awmf) sdo <= in_bit_d;
                    else            miso<= 1'b0;
                end
            end

            // ===== 收尾：CS↑ 或 LDB↓ → 寫入才更新 regfile =====
            if (cs_rise || (mode_awmf && ldb_fall)) begin
                if (rw_lat==1'b1 && bit_cnt>=FRAME_BITS) begin
                    // 資料在低 DATA_BITS（MSB-first 收進，擺位已對）
                    regfile[addr_lat] <= sh_in[DATA_BITS-1:0];
                end
            end
        end
    end
endmodule
