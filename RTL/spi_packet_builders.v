
`timescale 1ns/1ps

// Bit reversal
module bit_reverse #(parameter integer W = 60)(
    input  wire [W-1:0] in_bits,
    output wire [W-1:0] out_bits
);
    genvar i;
    generate for (i=0;i<W;i=i+1) begin : g_rev
        assign out_bits[i] = in_bits[W-1-i];
    end endgenerate
endmodule

// ===== Serial 60b =====
// Control word 12b = {b11=0, b10=PAR(optional), ADDR[9:0]}, followed by 48b DATA → total 60b, MSB-first
// Odd parity (if enabled) is defined as "XOR all 60b then invert" → b10=1 means odd.
module aw_serial60_builder #(
    parameter         DATA_IN_LSBF = 1'b0,
    parameter         PARITY_EN    = 1'b0
)(
    input  wire [9:0]  addr10,
    input  wire [47:0] data48_in,
    output wire [59:0] frame60_msbf
);
    wire [47:0] data48_msbf;
    generate
        if (DATA_IN_LSBF) begin : g_drev
            bit_reverse #(.W(48)) u_dr (.in_bits(data48_in), .out_bits(data48_msbf));
        end else begin
            assign data48_msbf = data48_in;
        end
    endgenerate

    wire [11:0] ctrl_no_par = {1'b0, 1'b0, addr10};
    wire parity_odd = ~^({ctrl_no_par, data48_msbf});
    wire [11:0] ctrl12 = PARITY_EN ? {1'b0, parity_odd, addr10} : ctrl_no_par;

    assign frame60_msbf = {ctrl12, data48_msbf};
endmodule

// ===== Broadcast 62b =====
// Control word 14b = {1'b1, ctrl_low13} (ctrl_low13 contains 10b address and other control bits), followed by 48b DATA
module aw_broadcast62_builder #(
    parameter         DATA_IN_LSBF = 1'b0
)(
    input  wire [12:0] ctrl_low13,    // {other control[12:3], ADDR[9:0]}
    input  wire [47:0] data48_in,
    output wire [61:0] frame62_msbf
);
    wire [47:0] data48_msbf;
    generate
        if (DATA_IN_LSBF) begin : g_drev
            bit_reverse #(.W(48)) u_dr (.in_bits(data48_in), .out_bits(data48_msbf));
        end else begin
            assign data48_msbf = data48_in;
        end
    endgenerate
    wire [13:0] ctrl14 = {1'b1, ctrl_low13};
    assign frame62_msbf = {ctrl14, data48_msbf};
endmodule

// ===== Concatenate N 60b (MSB-first) =====
// REVERSE_ORDER=1 → input {IC[N-1],...,IC[0]} passes through directly (MSB at last device)
module aw_chain_concat #(parameter integer N=4, parameter REVERSE_ORDER=1'b1)(
    input  wire [N*60-1:0] pkts60_each_ic,
    output wire [N*60-1:0] chain_msbf
);
    generate
        if (REVERSE_ORDER) begin : g_passthru
            assign chain_msbf = pkts60_each_ic;
        end else begin : g_reorder
            genvar k;
            for (k=0;k<N;k=k+1) begin : g_seg
                assign chain_msbf[(N-1-k)*60 +: 60] = pkts60_each_ic[k*60 +: 60];
            end
        end
    endgenerate
endmodule
