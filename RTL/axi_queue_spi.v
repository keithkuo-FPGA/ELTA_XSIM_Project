`timescale 1ns/1ps
//------------------------------------------------------------------------------
// spi_cmd_queue — shallow single-clock FIFO (no BRAM), with chain-write fields
// Base pack: std(60) + wdata(48) + low13(13) + addr(10) + pad(2) + op(3) = 136
// Extra    : cw_mask(N) + cw_addr(10N) + cw_wdata(48N)
// Total W  : 136 + N + 10N + 48N
// Show-ahead read: out_valid=~empty, dout combinational to mem[raddr].
// Pop when (out_valid && out_ready). 建議用「同拍鎖資料、次拍發 start」。
//------------------------------------------------------------------------------
module spi_cmd_queue #(
  parameter integer DEPTH = 8,
  parameter integer N_DEV = 4
)(
  input  wire         clk,
  input  wire         rst_n,

  // upstream push
  input  wire         in_push,
  input  wire [2:0]   in_op,
  input  wire [9:0]   in_addr,
  input  wire [12:0]  in_low13,
  input  wire [47:0]  in_wdata,
  input  wire [59:0]  in_std,
  output wire         in_ready,

  input  wire [N_DEV-1:0]        in_cw_mask,
  input  wire [N_DEV*10-1:0]     in_cw_addr,
  input  wire [N_DEV*48-1:0]     in_cw_wdata,

  // downstream pop
  output wire         out_valid,
  input  wire         out_ready,
  output wire [2:0]   out_op,
  output wire [9:0]   out_addr,
  output wire [12:0]  out_low13,
  output wire [47:0]  out_wdata,
  output wire [59:0]  out_std,

  output wire [N_DEV-1:0]        out_cw_mask,
  output wire [N_DEV*10-1:0]     out_cw_addr,
  output wire [N_DEV*48-1:0]     out_cw_wdata
);

localparam integer BASE_W      = 136;
localparam integer CW_MASK_W   = N_DEV;
localparam integer CW_ADDR_W   = N_DEV*10;
localparam integer CW_WDATA_W  = N_DEV*48;
localparam integer W           = BASE_W + CW_MASK_W + CW_ADDR_W + CW_WDATA_W;

wire [W-1:0] din_pack;
assign din_pack[135:76] = in_std;      // 60
assign din_pack[75:28]  = in_wdata;    // 48
assign din_pack[27:15]  = in_low13;    // 13
assign din_pack[14:5]   = in_addr;     // 10
assign din_pack[4:3]    = 2'b00;       // pad
assign din_pack[2:0]    = in_op;       // 3
assign din_pack[BASE_W + CW_MASK_W - 1 : BASE_W]                                  = in_cw_mask;
assign din_pack[BASE_W + CW_MASK_W + CW_ADDR_W - 1 : BASE_W + CW_MASK_W]          = in_cw_addr;
assign din_pack[BASE_W + CW_MASK_W + CW_ADDR_W + CW_WDATA_W - 1 :
                BASE_W + CW_MASK_W + CW_ADDR_W]                                   = in_cw_wdata;

wire [W-1:0] dout_pack;
assign out_std      = dout_pack[135:76];
assign out_wdata    = dout_pack[75:28];
assign out_low13    = dout_pack[27:15];
assign out_addr     = dout_pack[14:5];
assign out_op       = dout_pack[2:0];
assign out_cw_mask  = dout_pack[BASE_W + CW_MASK_W - 1 : BASE_W];
assign out_cw_addr  = dout_pack[BASE_W + CW_MASK_W + CW_ADDR_W - 1 :
                                BASE_W + CW_MASK_W];
assign out_cw_wdata = dout_pack[BASE_W + CW_MASK_W + CW_ADDR_W + CW_WDATA_W - 1 :
                                BASE_W + CW_MASK_W + CW_ADDR_W];

// simple distributed FIFO
function integer CLOG2; input integer v; integer i; begin CLOG2=0; for(i=v-1;i>0;i=i>>1) CLOG2=CLOG2+1; end endfunction
localparam integer AW = (DEPTH<=2)?1 : (DEPTH<=4)?2 : (DEPTH<=8)?3 :
                        (DEPTH<=16)?4: 5;

(* ram_style="distributed" *) reg [W-1:0] mem [0:DEPTH-1];
reg [AW:0] wptr, rptr;
wire [AW-1:0] waddr = wptr[AW-1:0];
wire [AW-1:0] raddr = rptr[AW-1:0];

wire empty = (wptr==rptr);
wire full  = (wptr[AW]!=rptr[AW]) && (waddr==raddr);

assign in_ready  = ~full;
assign out_valid = ~empty;
assign dout_pack = mem[raddr];

integer ii;
always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    wptr <= 0; rptr <= 0;
    for (ii=0; ii<DEPTH; ii=ii+1) mem[ii] <= {W{1'b0}};
  end else begin
    if (in_push && ~full) begin
      mem[waddr] <= din_pack;
      wptr <= wptr + 1'b1;
    end
    if (out_valid && out_ready) begin
      rptr <= rptr + 1'b1;
    end
  end
end
endmodule
