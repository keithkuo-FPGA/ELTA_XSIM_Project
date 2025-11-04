
`timescale 1ns/1ps

// ==== 極簡 bit engine：Mode0（CPOL=0/CPHA=0），MSB-first，支援 present_first_bit ====
// 為了讓檔案自足，這裡給一個縮減版（與你工程內的功能等價用於 TB）
module mini_bit_eng #(
    parameter integer MAX_BITS = 256,
    parameter integer CLK_DIV  = 1
)(
    input  wire                clk,   // 200 MHz
    input  wire                rst_n,
    input  wire                start,
    input  wire [15:0]         bit_count,       // N=240
    input  wire                present_first_bit,// AWMF 要設 1
    input  wire [MAX_BITS-1:0] tx_bits,         // MSB-first
    output reg  [MAX_BITS-1:0] rx_bits,         // MSB-first寫回
    input  wire                din,             // SDO
    output reg                 dout,            // SDI/PDI
    output reg                 sclk,
    output reg                 cs_n,
    output reg                 done
);
    // 分頻
    localparam DIVW = 1;
    reg [DIVW-1:0] divcnt; reg tick; reg en;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin divcnt<=0; tick<=1'b0; end
        else if (en) begin
            if (divcnt==(CLK_DIV-1)) begin divcnt<=0; tick<=1'b1; end
            else begin divcnt<=divcnt+1'b1; tick<=1'b0; end
        end else begin divcnt<=0; tick<=1'b0; end
    end

    // SCLK（Mode0：idle 0）
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) sclk<=1'b0;
        else if (!en) sclk<=1'b0;
        else if (tick) sclk<=~sclk;
    end

    reg [15:0] samp_idx, shf_idx, samp_left, shf_left;
    reg last_sample;

    localparam IDLE=2'd0, CS=2'd1, SHF=2'd2, END=2'd3;
    reg [1:0] st, nst;
    always @(posedge clk or negedge rst_n) begin if(!rst_n) st<=IDLE; else st<=nst; end
    always @* begin
        nst=st;
        case(st)
            IDLE: if (start && bit_count!=0) nst=CS;
            CS:   nst=SHF;
            SHF:  if (tick && last_sample) nst=END;
            END:  nst=IDLE;
        endcase
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rx_bits<={MAX_BITS{1'b0}}; dout<=1'b0; cs_n<=1'b1; en<=1'b0; done<=1'b0;
            samp_idx<=0; shf_idx<=0; samp_left<=0; shf_left<=0; last_sample<=1'b0;
        end else begin
            done<=1'b0;
            case(st)
            IDLE: begin
                en<=1'b0; cs_n<=1'b1; dout<=1'b0; last_sample<=1'b0;
                if (start && bit_count!=0) begin
                    rx_bits<={MAX_BITS{1'b0}};
                    samp_idx  <= bit_count-1; samp_left<=bit_count;
                    if (present_first_bit) begin
                        shf_idx  <= (bit_count>1)?(bit_count-2):0; shf_left<=(bit_count>1)?(bit_count-1):0;
                    end else begin
                        shf_idx  <= bit_count-1; shf_left<=bit_count;
                    end
                end
            end
            CS: begin
                cs_n<=1'b0; en<=1'b1;
                if (present_first_bit) dout<=tx_bits[bit_count-1];
            end
            SHF: begin
                if (tick) begin
                    // leading（上升）：sample；trailing（下降）：shift
                    if (~sclk) begin // next=1 → leading
                        if (samp_left!=0) begin
                            rx_bits[samp_idx] <= din;
                            last_sample <= (samp_left==16'd1);
                            samp_left   <= samp_left - 1'b1;
                            samp_idx    <= samp_idx - 1'b1;
                        end
                    end else begin    // next=0 → trailing
                        if (shf_left!=0) begin
                            dout     <= tx_bits[shf_idx];
                            shf_idx  <= shf_idx - 1'b1;
                            shf_left <= shf_left - 1'b1;
                        end
                    end
                end
            end
            END: begin
                en<=1'b0; cs_n<=1'b1; done<=1'b1;
            end
            endcase
        end
    end
endmodule

// ==== 真正的 TB ====
module tb_awmf_prodid;
    // 200MHz 系統時脈 → SCLK=100MHz（CLK_DIV=1）
    reg clk=0; always #2.5 clk=~clk;
    reg rst_n=0;

    // bit engine 連線（等價於 AWMF 的 SDI/SDO）
    reg         start;
    wire        done;
    wire        sclk, cs_n;
    wire        sdi;    // 送往鏈的 SDI（由 engine 輸出）
    wire        sdo;    // 從鏈回來的 SDO（回 engine 取樣）
    wire [255:0]rx_bits; // 我們只用到 240b
    reg  [255:0]tx_bits;

    mini_bit_eng #(.MAX_BITS(256), .CLK_DIV(1)) u_eng (
        .clk(clk), .rst_n(rst_n), .start(start), .bit_count(16'd240),
        .present_first_bit(1'b1), .tx_bits(tx_bits),
        .rx_bits(rx_bits), .din(sdo), .dout(sdi),
        .sclk(sclk), .cs_n(cs_n), .done(done)
    );

    // 4 顆 Daisy-Chain，給不同的 PROD_ID 方便辨識
    wire sdo0, sdo1, sdo2, sdo3; assign sdo = sdo3;

    awmf_prod_id_slave_sclk #(.PROD_ID_ADDR(10'h03E), .PROD_ID_DATA(48'h1111_1111_1111)) ic0 (
        .sclk(sclk), .cs_n(cs_n), .sdi(sdi),  .sdo(sdo0)
    );
    awmf_prod_id_slave_sclk #(.PROD_ID_ADDR(10'h03E), .PROD_ID_DATA(48'h2222_2222_2222)) ic1 (
        .sclk(sclk), .cs_n(cs_n), .sdi(sdo0), .sdo(sdo1)
    );
    awmf_prod_id_slave_sclk #(.PROD_ID_ADDR(10'h03E), .PROD_ID_DATA(48'h3333_3333_3333)) ic2 (
        .sclk(sclk), .cs_n(cs_n), .sdi(sdo1), .sdo(sdo2)
    );
    awmf_prod_id_slave_sclk #(.PROD_ID_ADDR(10'h03E), .PROD_ID_DATA(48'h4444_4444_4444)) ic3 (
        .sclk(sclk), .cs_n(cs_n), .sdi(sdo2), .sdo(sdo3)
    );

    // 用 builder 組 60b 讀命令（header 12b + data 48b=0），連續 4 包 → 240b
    // 這裡直接手寫，避免依賴其他檔案：header = {2'b00, addr[9:0]}
    function [59:0] make_serial60_rd; input [9:0] addr10; begin
        make_serial60_rd = {2'b00, addr10, 48'h0};
    end endfunction

    // 小工具：發一次 240b 傳輸
    task xfer240(input [239:0] bits240);
        begin
            tx_bits <= {16'd0, bits240}; // 放在低 240b（MSB-first 由 mini_bit_eng 處理）
            @(posedge clk); start <= 1'b1;
            @(posedge clk); start <= 1'b0;
            wait(done==1'b1);
            @(posedge clk);
        end
    endtask

    // 驗證
    reg [9:0] prod_addr;
    reg [59:0] rd_pkt;
    reg [47:0] seg0, seg1, seg2, seg3;

    initial begin
        start=0; tx_bits={256{1'b0}};
        repeat(6) @(posedge clk); rst_n=1'b1; repeat(6) @(posedge clk);

        prod_addr = 10'h03E;
        rd_pkt    = make_serial60_rd(prod_addr); // 60b 讀命令
        // Daisy-Chain：最末端（ic3）應該對應到 rx_bits[239:180] 的資料段
        xfer240({rd_pkt, rd_pkt, rd_pkt, rd_pkt}); // 240b

        // 切段（每段 60b），資料在各段低 48b（MSB-first）
        seg3 = rx_bits[227:180];
        seg2 = rx_bits[167:120];
        seg1 = rx_bits[107: 60];
        seg0 = rx_bits[ 47:  0];


        if (seg3 !== 48'h4444_4444_4444) begin $display("AW Seg3 FAIL: %h", seg3); $stop; end
        if (seg2 !== 48'h3333_3333_3333) begin $display("AW Seg2 FAIL: %h", seg2); $stop; end
        if (seg1 !== 48'h2222_2222_2222) begin $display("AW Seg1 FAIL: %h", seg1); $stop; end
        if (seg0 !== 48'h1111_1111_1111) begin $display("AW Seg0 FAIL: %h", seg0); $stop; end

        $display("AWMF PROD_ID Daisy-Chain x4 READ OK");
        #100 $finish;
    end
endmodule
