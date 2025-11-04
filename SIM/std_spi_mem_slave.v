// File: std_spi_mem_slave.v (Verilog-2001, with debug outputs)
`timescale 1ns/1ps
module std_spi_mem_slave #(
    parameter integer ADDR_BITS = 10,
    parameter integer DATA_BITS = 48,
    parameter integer HDR_BITS  = 12     // {RW, 1'b0, ADDR[9:0]} (MSB-first)
)(
    input  wire                   clk,    // ≥ 2x SCLK
    input  wire                   rst_n,
    input  wire                   sclk,
    input  wire                   cs_n,
    input  wire                   mosi,
    output reg                    miso,
    input  wire                   cpol,
    input  wire                   cpha,

    // debug
    output reg                    dbg_wr_pulse,
    output reg [ADDR_BITS-1:0]    dbg_wr_addr,
    output reg [DATA_BITS-1:0]    dbg_wr_data,
    output reg                    dbg_wr_done   // ★ 新增：黏住直到下次 cs_fall
);
    // 邊緣偵測
    reg sclk_d1,sclk_d2, cs_d1,cs_d2;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sclk_d1<=0; sclk_d2<=0; cs_d1<=1; cs_d2<=1;
        end else begin
            sclk_d1<=sclk; sclk_d2<=sclk_d1;
            cs_d1<=cs_n;   cs_d2<=cs_d1;
        end
    end
    wire sclk_rise =  (sclk_d1 & ~sclk_d2);
    wire sclk_fall = (~sclk_d1 &  sclk_d2);
    wire cs_fall   = (~cs_d1 &  cs_d2);
    wire cs_rise   = ( cs_d1 & ~cs_d2);

    wire leading_edge  = (cpol==1'b0) ? sclk_rise : sclk_fall;
    wire trailing_edge = (cpol==1'b0) ? sclk_fall : sclk_rise;
    wire sample_edge   = (cpha==1'b0) ? leading_edge  : trailing_edge;
    wire shift_edge    = (cpha==1'b0) ? trailing_edge : leading_edge;

    // 記憶體與移位器
    reg [DATA_BITS-1:0] regfile [0:(1<<ADDR_BITS)-1];

    reg [HDR_BITS-1:0]  hdr_sh;
    reg [5:0]           hdr_cnt;        // 0..12
    reg [DATA_BITS-1:0] din_sh;
    reg [5:0]           din_cnt;        // 0..48
    reg [DATA_BITS-1:0] dout_sh;
    reg [5:0]           dout_cnt;       // 0..48

    reg                  rw_lat;        // 1=寫, 0=讀
    reg [ADDR_BITS-1:0]  addr_lat;

    // 下一拍 header（含當前 mosi）
    wire [HDR_BITS-1:0]  hdr_next_w = {hdr_sh[HDR_BITS-2:0], mosi};


    integer i;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i=0;i<(1<<ADDR_BITS);i=i+1) regfile[i] <= {DATA_BITS{1'b0}};
            hdr_sh <= {HDR_BITS{1'b0}}; hdr_cnt <= 0;
            din_sh <= {DATA_BITS{1'b0}}; din_cnt <= 0;
            dout_sh<= {DATA_BITS{1'b0}}; dout_cnt<= 0;
            rw_lat <= 1'b0; addr_lat <= {ADDR_BITS{1'b0}};
            miso   <= 1'b0;
            // reset
            dbg_wr_pulse<=1'b0; dbg_wr_addr<={ADDR_BITS{1'b0}};
            dbg_wr_data<={DATA_BITS{1'b0}}; dbg_wr_done<=1'b0;
        end else begin
            dbg_wr_pulse <= 1'b0; // default

            // CS↓：清狀態
            if (cs_fall) begin
                hdr_sh <= {HDR_BITS{1'b0}}; hdr_cnt <= 0;
                din_sh <= {DATA_BITS{1'b0}}; din_cnt <= 0;
                dout_cnt<=0;
                miso   <= 1'b0;
                dbg_wr_done <= 1'b0;             // ★ 清除
            end

            // 取樣邊緣：收 header / 收寫入資料
            if (!cs_n && sample_edge) begin
                if (hdr_cnt < HDR_BITS) begin
                    hdr_sh  <= hdr_next_w;
                    hdr_cnt <= hdr_cnt + 1'b1;

                    if (hdr_cnt == (HDR_BITS-1)) begin
                        rw_lat   <= hdr_next_w[HDR_BITS-1];      // MSB=RW
                        addr_lat <= hdr_next_w[ADDR_BITS-1:0];   // LSBs=ADDR
                        if (hdr_next_w[HDR_BITS-1]==1'b0) begin
                            dout_sh  <= regfile[hdr_next_w[ADDR_BITS-1:0]];
                            dout_cnt <= 0;
                        end
                    end
                end else if (rw_lat) begin
                    if (din_cnt < DATA_BITS) begin
                        din_sh  <= {din_sh[DATA_BITS-2:0], mosi};
                        din_cnt <= din_cnt + 1'b1;
                    end
                end
            end

            // 切換邊緣：輸出讀資料（MSB-first）
            if (!cs_n && shift_edge) begin
                if (!rw_lat && hdr_cnt==HDR_BITS) begin
                    if (dout_cnt < DATA_BITS) begin
                        miso    <= dout_sh[DATA_BITS-1];
                        dout_sh <= {dout_sh[DATA_BITS-2:0], 1'b0};
                        dout_cnt<= dout_cnt + 1'b1;
                    end else begin
                        miso <= 1'b0;
                    end
                end else begin
                    miso <= 1'b0;
                end
            end

            // CS↑：若為寫入且 48b 已收滿 → 寫入記憶體 & 發出 debug 脈衝
            if (cs_rise) begin
                if (rw_lat && din_cnt==DATA_BITS) begin
                    regfile[addr_lat] <= din_sh;
                    dbg_wr_pulse      <= 1'b1;
                    dbg_wr_addr       <= addr_lat;
                    dbg_wr_data       <= din_sh;
                    dbg_wr_done       <= 1'b1;   // ★ 黏住
                end
            end
        end
    end
endmodule
