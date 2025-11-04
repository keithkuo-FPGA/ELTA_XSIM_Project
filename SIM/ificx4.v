module ificx4 (
	input         rst_n ,
	input         mclk  ,
	input         scl   ,
	input         cs_n  ,
	input         mosi  ,
	output        miso  ,
	output [63:0] wdao_0,
	output        wvld_0,
	output [63:0] wdao_1,
	output        wvld_1,
	output [63:0] wdao_2,
	output        wvld_2,
	output [63:0] wdao_3,
	output        wvld_3
);

wire miso_0;
wire miso_1;
wire miso_2;

spi_slv_ific spi_slv_ific_u0 (
	.rst_n(rst_n ),
	.mclk (mclk  ),
	.scl  (scl   ),
	.cs_n (cs_n  ),
	.mosi (mosi  ),
	.miso (miso_0),
	.wdao (wdao_0),
	.wvld (wvld_0)
);

spi_slv_ific spi_slv_ific_u1 (
	.rst_n(rst_n ),
	.mclk (mclk  ),
	.scl  (scl   ),
	.cs_n (cs_n  ),
	.mosi (miso_0),
	.miso (miso_1),
	.wdao (wdao_1),
	.wvld (wvld_1)
);

spi_slv_ific spi_slv_ific_u2 (
	.rst_n(rst_n ),
	.mclk (mclk  ),
	.scl  (scl   ),
	.cs_n (cs_n  ),
	.mosi (miso_1),
	.miso (miso_2),
	.wdao (wdao_2),
	.wvld (wvld_2)
);

spi_slv_ific spi_slv_ific_u3 (
	.rst_n(rst_n ),
	.mclk (mclk  ),
	.scl  (scl   ),
	.cs_n (cs_n  ),
	.mosi (miso_2),
	.miso (miso  ),
	.wdao (wdao_3),
	.wvld (wvld_3)
);

endmodule