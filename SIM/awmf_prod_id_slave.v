// File: awmf_prod_id_slave_sclk.v
`timescale 1ns/1ps
module awmf_prod_id_slave_sclk #(
    parameter integer ADDR_BITS     = 10,
    parameter integer DATA_BITS     = 48,
    parameter integer HDR12_BITS    = 12,
    parameter [ADDR_BITS-1:0] PROD_ID_ADDR = 10'h055,
    parameter [DATA_BITS-1:0] PROD_ID_DATA = 48'hABCD_EF01_2345
)(
    input  wire sclk,     // SPI clock
    input  wire cs_n,     // SPI chip select (active low)
    input  wire sdi,      // serial in  (from previous device)
    output reg  sdo       // serial out (to next device)
);
    // 60b 鏈延遲（MSB 端送出）
    reg  [59:0] sdi_shift;
    reg         sdi_latched;        // 在 posedge 抓到的 SDI，於下一個 negedge 併入鏈

    // Header 與輸出資料
    reg  [HDR12_BITS-1:0] hdr_sh;
    reg  [5:0]            hdr_cnt;   // 0..12
    reg  [ADDR_BITS-1:0]  addr_lat;

    reg  [DATA_BITS-1:0]  dout_sh;   // 我這顆要送出去的 48b（MSB-first）
    reg  [5:0]            dout_cnt;  // 0..48

    // === CS 上升：重置一輪 ===
    always @(posedge cs_n) begin
        sdi_shift <= 60'd0;
        sdi_latched <= 1'b0;
        hdr_sh   <= {HDR12_BITS{1'b0}};
        hdr_cnt  <= 6'd0;
        addr_lat <= {ADDR_BITS{1'b0}};
        dout_sh  <= {DATA_BITS{1'b0}};
        dout_cnt <= 6'd0;
        sdo      <= 1'b0;
    end

    // === posedge SCLK：取樣 SDI、收 header ===
    always @(posedge sclk) begin
        if (!cs_n) begin
            sdi_latched <= sdi;  // 先抓下來，給 negedge 串進 60b 鏈

            if (hdr_cnt < HDR12_BITS) begin
                // MSB-first 收 header
                hdr_sh  <= {hdr_sh[HDR12_BITS-2:0], sdi};
                hdr_cnt <= hdr_cnt + 6'd1;

                if (hdr_cnt == (HDR12_BITS-1)) begin
                    // header 已滿（此拍 hdr_sh 尚未含當前 sdi，所以用 next 組合）
                    // next = {hdr_sh[10:0], sdi}；定義：{2'b00, addr[9:0]}
                    addr_lat <= {hdr_sh[ADDR_BITS-2:0], sdi};

                    // 準備輸出資料：位址對 → 回 PROD_ID；否則回 0
                    if ({hdr_sh[ADDR_BITS-2:0], sdi} == PROD_ID_ADDR)
                        dout_sh <= PROD_ID_DATA;
                    else
                        dout_sh <= {DATA_BITS{1'b0}};
                    dout_cnt <= 6'd0;
                end
            end
        end
    end

    // === negedge SCLK：形成 60b pass-through；在自己資料時槽覆寫輸出 ===
    always @(negedge sclk) begin
        if (!cs_n) begin
            // 60b 鏈移位：上一個 posedge 抓到的位元塞進 LSB，MSB 端送出
            sdi_shift <= {sdi_shift[58:0], sdi_latched};

            if (hdr_cnt == HDR12_BITS && dout_cnt < DATA_BITS) begin
                // 在自己的 48b 視窗：MSB-first 推資料
                sdo      <= dout_sh[DATA_BITS-1];
                dout_sh  <= {dout_sh[DATA_BITS-2:0], 1'b0};
                dout_cnt <= dout_cnt + 6'd1;
            end else begin
                // 其他時間：單純 pass-through（60b 延遲）
                sdo      <= sdi_shift[59];
            end
        end
    end
endmodule
