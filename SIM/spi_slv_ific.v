module spi_slv_ific (
	input         rst_n, // reset, active at negative
	input         mclk , // main clock
	input         scl  , // spi clock
	input         cs_n , // chip selection, active at negative
	input         mosi , // master out slave in
	output        miso , // master in slave out
	output [63:0] wdao ,
	output        wvld 
);

reg [59:0] rx_data;
reg [59:0] tx_data;
reg [ 1:0] cs_n_d ;
reg        go     ;
reg        done   ;
reg [ 2:0] done_d ;
reg        ren    ;
reg [ 2:0] ren_d  ;
reg        x009001;
reg [59:0] rd_data;
reg [59:0] wr_data;
reg [59:0] reg_000;
reg [59:0] reg_001;
reg [59:0] reg_002;
reg [59:0] reg_003;
reg [59:0] reg_004;
reg [59:0] reg_007;
reg [59:0] reg_009;
reg [59:0] reg_00A;
reg [59:0] reg_01C;
reg [59:0] reg_01D;
reg [59:0] reg_01E;
reg [59:0] reg_01F;
reg [59:0] reg_020;
reg [59:0] reg_021;
reg [59:0] reg_035;
reg [59:0] reg_044;
reg [59:0] reg_045;
reg [59:0] reg_200;
reg [59:0] reg_21F;
reg [59:0] reg_300;
reg [59:0] reg_301;
reg [59:0] reg_305;
reg [59:0] reg_30B;

assign miso = x009001 ? tx_data[59] : rx_data[59];

assign wdao = {4'd0, wr_data};
assign wvld = done_d[2];
 
initial rx_data = 0;
always @ (posedge scl, posedge done_d[2]) begin
	if (done_d[2]) rx_data <= x009001 ? 0 : rx_data;
	else rx_data <= {rx_data[58:0], mosi};
end

initial tx_data = 0;
always @ (posedge scl, posedge ren_d[2]) begin
	if (ren_d[2]) tx_data <= rd_data;
	else tx_data <= {tx_data[58:0], tx_data[59]};
end

always @ (posedge mclk, negedge rst_n) begin
	if (~rst_n) cs_n_d <= 2'b11;
	else cs_n_d <= {cs_n_d[0], cs_n};
end

always @ (posedge mclk, negedge rst_n) begin
	if (~rst_n) go <= 0;
	else go <= cs_n_d == 2'b10 ? 1'b1 : 1'b0;
end

always @ (posedge mclk, negedge rst_n) begin
	if (~rst_n) done <= 0;
	else done <= cs_n_d == 2'b01 ? 1'b1 : 1'b0;
end

always @ (posedge mclk, negedge rst_n) begin
	if (~rst_n) done_d <= 0;
	else done_d <= {done_d[1:0], done};
end

always @ (posedge mclk, negedge rst_n) begin
	if (~rst_n) ren <= 0;
	else ren <= wr_data[57:48] == 10'h009 && done_d[0] ? 1'b1 : 1'b0;
end

always @ (posedge mclk, negedge rst_n) begin
	if (~rst_n) ren_d <= 0;
	else ren_d <= {ren_d[1:0], ren};
end

always @ (posedge mclk, negedge rst_n) begin
	if (~rst_n) x009001 <= 0;
	else x009001 <= wr_data[57:48] == 10'h001 && done_d[2] ? 1'b0 :
	                ren_d[2]                               ? 1'b1 : x009001;
end

always @ (posedge mclk, negedge rst_n) begin
	if (~rst_n) rd_data <= 0;
	else begin
		case (wr_data[9:0])
			10'h000 : rd_data <= ren_d[0] ? reg_000 : rd_data;
			10'h001 : rd_data <= ren_d[0] ? reg_001 : rd_data;
			10'h002 : rd_data <= ren_d[0] ? reg_002 : rd_data;
			10'h003 : rd_data <= ren_d[0] ? reg_003 : rd_data;
			10'h004 : rd_data <= ren_d[0] ? reg_004 : rd_data;
			10'h007 : rd_data <= ren_d[0] ? reg_007 : rd_data;
			10'h009 : rd_data <= ren_d[0] ? reg_009 : rd_data;
			10'h00A : rd_data <= ren_d[0] ? reg_00A : rd_data;
			10'h01C : rd_data <= ren_d[0] ? reg_01C : rd_data;
			10'h01D : rd_data <= ren_d[0] ? reg_01D : rd_data;
			10'h01E : rd_data <= ren_d[0] ? reg_01E : rd_data;
			10'h01F : rd_data <= ren_d[0] ? reg_01F : rd_data;
			10'h020 : rd_data <= ren_d[0] ? reg_020 : rd_data;
			10'h021 : rd_data <= ren_d[0] ? reg_021 : rd_data;
			10'h035 : rd_data <= ren_d[0] ? reg_035 : rd_data;
			10'h044 : rd_data <= ren_d[0] ? reg_044 : rd_data;
			10'h045 : rd_data <= ren_d[0] ? reg_045 : rd_data;
			10'h200 : rd_data <= ren_d[0] ? reg_200 : rd_data;
			10'h21F : rd_data <= ren_d[0] ? reg_21F : rd_data;
			10'h300 : rd_data <= ren_d[0] ? reg_300 : rd_data;
			10'h301 : rd_data <= ren_d[0] ? reg_301 : rd_data;
			10'h305 : rd_data <= ren_d[0] ? reg_305 : rd_data;
			10'h30B : rd_data <= ren_d[0] ? reg_30B : rd_data;
			default : rd_data <= rd_data;
		endcase
	end
end

always @ (posedge mclk, negedge rst_n) begin
	if (~rst_n) wr_data <= 0;
	else wr_data <= done ? rx_data : wr_data;
end

always @ (posedge mclk, negedge rst_n) begin
	if (~rst_n) begin
		reg_000 <= 0;
		reg_001 <= 0;
		reg_002 <= 0;
		reg_003 <= 0;
		reg_004 <= 0;
		reg_007 <= 0;
		reg_009 <= 0;
		reg_00A <= 0;
		reg_01C <= 0;
		reg_01D <= 0;
		reg_01E <= 0;
		reg_01F <= 0;
		reg_020 <= 0;
		reg_021 <= 0;
		reg_035 <= 0;
		reg_044 <= 0;
		reg_045 <= 0;
		reg_200 <= 0;
		reg_21F <= 0;
		reg_300 <= 0;
		reg_301 <= 0;
		reg_305 <= 0;
		reg_30B <= 0;
	end
	else begin
		reg_000 <= wr_data[57:48] == 10'h000 && done_d[0] ? wr_data : reg_000;
		reg_001 <= wr_data[57:48] == 10'h001 && done_d[0] ? wr_data : reg_001;
		reg_002 <= wr_data[57:48] == 10'h002 && done_d[0] ? wr_data : reg_002;
		reg_003 <= wr_data[57:48] == 10'h003 && done_d[0] ? wr_data : reg_003;
		reg_004 <= wr_data[57:48] == 10'h004 && done_d[0] ? wr_data : reg_004;
		reg_007 <= wr_data[57:48] == 10'h007 && done_d[0] ? wr_data : reg_007;
		reg_009 <= wr_data[57:48] == 10'h009 && done_d[0] ? wr_data : reg_009;
		reg_00A <= wr_data[57:48] == 10'h00A && done_d[0] ? wr_data : reg_00A;
		reg_01C <= wr_data[57:48] == 10'h01C && done_d[0] ? wr_data : reg_01C;
		reg_01D <= wr_data[57:48] == 10'h01D && done_d[0] ? wr_data : reg_01D;
		reg_01E <= wr_data[57:48] == 10'h01E && done_d[0] ? wr_data : reg_01E;
		reg_01F <= wr_data[57:48] == 10'h01F && done_d[0] ? wr_data : reg_01F;
		reg_020 <= wr_data[57:48] == 10'h020 && done_d[0] ? wr_data : reg_020;
		reg_021 <= wr_data[57:48] == 10'h021 && done_d[0] ? wr_data : reg_021;
		reg_035 <= wr_data[57:48] == 10'h035 && done_d[0] ? wr_data : reg_035;
		reg_044 <= wr_data[57:48] == 10'h044 && done_d[0] ? wr_data : reg_044;
		reg_045 <= wr_data[57:48] == 10'h045 && done_d[0] ? wr_data : reg_045;
		reg_200 <= wr_data[57:48] == 10'h200 && done_d[0] ? wr_data : reg_200;
		reg_21F <= wr_data[57:48] == 10'h21F && done_d[0] ? wr_data : reg_21F;
		reg_300 <= wr_data[57:48] == 10'h300 && done_d[0] ? wr_data : reg_300;	
		reg_301 <= wr_data[57:48] == 10'h301 && done_d[0] ? wr_data : reg_301;		
		reg_305 <= wr_data[57:48] == 10'h305 && done_d[0] ? wr_data : reg_305;	
		reg_30B <= wr_data[57:48] == 10'h30B && done_d[0] ? wr_data : reg_30B;		
	end
end

endmodule