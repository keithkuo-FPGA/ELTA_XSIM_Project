
`timescale 1ns/1ps
module awmf_slave #(
    parameter integer ADDR_BITS      = 10,
    parameter integer DATA_BITS      = 48,
    parameter integer HDR12_BITS     = 12,

    // PID（PROD_ID）設定
    parameter [ADDR_BITS-1:0] PROD_ID_ADDR = 10'h03E,
    parameter [DATA_BITS-1:0] PROD_ID_DATA = 48'hABCD_EF01_2345,

    // 35-bit Broadcast（FBS/TDBS）切片參數（MSB-first）
    // 預設：{EN[34], ADDR[33:24] = 10-bit, DATA[23:0] = 24-bit}
    parameter integer FBS_BITS     = 35,
    parameter integer FBS_EN_BIT   = 34,
    parameter integer FBS_ADDR_MSB = 33,
    parameter integer FBS_ADDR_LSB = 24,
    parameter integer FBS_DATA_MSB = 23,
    parameter integer FBS_DATA_LSB = 0
)(
    input  wire                   clk,      // 保留（本模組核心用 sclk 邊緣）
    input  wire                   rst_n,
    input  wire                   sclk,
    input  wire                   cs_n,

    // Daisy-chain serial path（60b: 12b header + 48b data）
    input  wire                   sdi,   // 從上一顆來（主機方向→遠端）
    output reg                    sdo,   // 往下一顆去（遠端→主機回程）

    // Broadcast path（共用 pdi 線）：62b PDI 或 35b FBS/TDBS
    input  wire                   pdi,

    // 保留（本模型固定 CPOL=0/CPHA=0；為相容放著不用）
    input  wire                   cpol,
    input  wire                   cpha
);
    // --------- X/Z → 0 淨化，避免未知值污染管線 ---------
    wire sdi_01 = (sdi === 1'b1) ? 1'b1 : 1'b0;
    wire pdi_01 = (pdi === 1'b1) ? 1'b1 : 1'b0;

    // --------- 內部記憶體：一般位址讀寫都走這裡（PID 例外走常數） ---------
    reg [DATA_BITS-1:0] regfile [0:(1<<ADDR_BITS)-1];

    // --------- posedge SCLK：收 SDI header、收 PDI/FBS、在 CS↑ commit ---------
    reg                  cs_n_d;          // CS 上升沿偵測
    reg [HDR12_BITS-1:0] hdr_sh;
    reg [5:0]            hdr_cnt;         // 0..12
    reg [ADDR_BITS-1:0]  addr_lat;
    reg                  rw_is_write_lat; // 1=寫, 0=讀

    // Broadcast shift/計數
    reg [61:0]           pdi_sh;          // 62b 視窗（PDI）
    reg [6:0]            pdi_cnt;         // 0..62
    reg [34:0]           fbs_sh;          // 35b 視窗（FBS/TDBS）
    reg [5:0]            fbs_cnt;         // 0..35

    // 提供給 negedge 的握手/資料
    reg                  sdi_sampled;     // 上一個 posedge 抓到的 SDI
    reg                  rd_req_toggle;   // READ 請求（toggle）
    reg [DATA_BITS-1:0]  rd_data_latched; // READ 要輸出的 48b
    reg                  rd_is_valid;     // 此次請求是否為 READ

    // 先組出下一拍 header 值（避免 SV 巢狀取位）
    wire [HDR12_BITS-1:0] hdr_next_w   = {hdr_sh[HDR12_BITS-2:0], sdi_01};
    wire                  next_rw_wr_w = hdr_next_w[HDR12_BITS-1];
    wire [ADDR_BITS-1:0]  next_addr_w  = hdr_next_w[ADDR_BITS-1:0];

    always @(posedge sclk or negedge rst_n) begin
        if (!rst_n) begin
            cs_n_d          <= 1'b1;
            hdr_sh          <= {HDR12_BITS{1'b0}};
            hdr_cnt         <= 6'd0;
            addr_lat        <= {ADDR_BITS{1'b0}};
            rw_is_write_lat <= 1'b0;

            pdi_sh          <= 62'd0;    pdi_cnt <= 7'd0;
            fbs_sh          <= 35'd0;    fbs_cnt <= 6'd0;

            sdi_sampled     <= 1'b0;
            rd_req_toggle   <= 1'b0;
            rd_data_latched <= {DATA_BITS{1'b0}};
            rd_is_valid     <= 1'b0;
        end else begin
            cs_n_d <= cs_n;

            if (cs_n) begin
                // 交易間：清收集狀態，避免殘留/X
                hdr_sh      <= {HDR12_BITS{1'b0}};
                hdr_cnt     <= 6'd0;
                sdi_sampled <= 1'b0;

                pdi_sh      <= 62'd0;    pdi_cnt <= 7'd0;
                fbs_sh      <= 35'd0;    fbs_cnt <= 6'd0;
            end else begin
                // 只在 CS=0 時取樣與收集
                sdi_sampled <= sdi_01;

                // ---- 收 header（MSB-first）----
                if (hdr_cnt < HDR12_BITS) begin
                    hdr_sh  <= hdr_next_w;
                    hdr_cnt <= hdr_cnt + 6'd1;

                    if (hdr_cnt == (HDR12_BITS-1)) begin
                        // header 完成（本拍）
                        rw_is_write_lat <= next_rw_wr_w;
                        addr_lat        <= next_addr_w;

                        // READ：預載資料並發出請求
                        if (!next_rw_wr_w) begin
                            rd_is_valid     <= 1'b1;
                            rd_data_latched <= (next_addr_w==PROD_ID_ADDR) ? PROD_ID_DATA
                                               : regfile[next_addr_w];
                            rd_req_toggle   <= ~rd_req_toggle;
                        end else begin
                            rd_is_valid     <= 1'b0;
                        end
                    end
                end

                // ---- 收 Broadcast：PDI(62) 與 FBS(35) 兩個視窗都累積 ----
                pdi_sh  <= {pdi_sh[60:0], pdi_01};
                if (pdi_cnt < 7'd62) pdi_cnt <= pdi_cnt + 7'd1;

                fbs_sh  <= {fbs_sh[33:0], pdi_01};
                if (fbs_cnt < 6'd35)     fbs_cnt <= fbs_cnt + 6'd1;
            end

            // ---- CS 上升：Commit 寫入 ----
            if (cs_n && !cs_n_d) begin
                // 62b PDI：ctrl14[13]==1 表示有效寫入
                if (pdi_cnt>=7'd62 && pdi_sh[61]==1'b1) begin
                    // ctrl14[9:0] = [57:48]；data48 = [47:0]
                    regfile[pdi_sh[57:48]] <= pdi_sh[47:0];
                end
                // 35b FBS/TDBS：依參數化切片，data 擴展到 48b（高位補 0）
                else if (fbs_cnt==FBS_BITS && fbs_sh[FBS_EN_BIT]==1'b1) begin
                    regfile[fbs_sh[FBS_ADDR_MSB:FBS_ADDR_LSB]] <=
                        {{(48-(FBS_DATA_MSB-FBS_DATA_LSB+1)){1'b0}},
                          fbs_sh[FBS_DATA_MSB:FBS_DATA_LSB]};
                end

                // 清計數，等下一筆
                pdi_cnt <= 7'd0; pdi_sh <= 62'd0;
                fbs_cnt <= 6'd0; fbs_sh <= 35'd0;
            end
        end
    end

    // --------- negedge SCLK：60b pass-through + 在讀視窗輸出 48b ---------
    reg [59:0] sdi_pipe;         // 60-bit pass-through（每顆形成 60 位延遲）
    reg        rd_seen_toggle;   // 已處理的請求記號
    reg [5:0]  rd_cnt;           // 0..48
    reg        rd_active;        // 正在輸出資料

    always @(negedge sclk or negedge rst_n) begin
        if (!rst_n) begin
            sdi_pipe      <= 60'd0;
            rd_seen_toggle<= 1'b0;
            rd_cnt        <= 6'd0;
            rd_active     <= 1'b0;
            sdo           <= 1'b0;
        end else begin
            if (cs_n) begin
                // 交易間：全部歸零，避免殘留/X 進下一筆
                sdi_pipe       <= 60'd0;
                rd_active      <= 1'b0;
                rd_cnt         <= 6'd0;
                rd_seen_toggle <= rd_req_toggle; // 吃掉殘留請求
                sdo            <= 1'b0;
            end else begin
                // 只有 CS=0 才推進 60b pass-through（用已淨化的 sdi_sampled）
                sdi_pipe <= {sdi_pipe[58:0], sdi_sampled};

                // 新的 READ 請求（header 剛完成）
                if (rd_req_toggle != rd_seen_toggle) begin
                    rd_seen_toggle <= rd_req_toggle;
                    rd_active      <= rd_is_valid;
                    rd_cnt         <= 6'd0;
                end

                if (rd_active && rd_cnt < DATA_BITS) begin
                    // 在自己的 48b 視窗：MSB-first 連續輸出
                    sdo    <= rd_data_latched[DATA_BITS-1 - rd_cnt];
                    rd_cnt <= rd_cnt + 6'd1;
                end else begin
                    // 其餘時間：單純 pass-through（形成 60 位延遲）
                    sdo    <= sdi_pipe[59];
                end
            end
        end
    end
endmodule
