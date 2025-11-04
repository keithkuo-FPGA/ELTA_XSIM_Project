
`timescale 1ns/1ps
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
    end
    else if (resp_done) begin
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
        std_ro_load<=1'b0;
        chain_ro_load<=1'b0;
        std_ro_data<=0;
        chain_ro_data<=0;
    end
    else begin
        std_ro_load<=1'b0;
        chain_ro_load<=1'b0;
        if (resp_done_aclk) begin
            std_ro_data[0*W +: W] <= std_rx_shd[31:0];
            std_ro_data[1*W +: W] <= {{(W-(STD_W-32)){1'b0}}, std_rx_shd[STD_W-1:32]};
            for (i=0;i<N_DEV;i=i+1) begin
                chain_ro_data[(i*REGS_PER_DEV+0)*W +: W] <= chain_rx_shd[i*48 +: 32];
                chain_ro_data[(i*REGS_PER_DEV+1)*W +: W] <= {{(W-16){1'b0}}, chain_rx_shd[i*48+32 +: 16]};
            end
            std_ro_load<=1'b1;
            chain_ro_load<=1'b1;
        end
    end
end

endmodule

