module tx_eight_ten
(
	input wire			clk,
	input wire			rst,
	input wire			sel,
	input wire			set,
	input wire [7:0]  din,
	input wire [19:0] baud,
	
	output wire 		tx_en,
	output wire 		tx_out,
	output wire [9:0] tx_d
);

wire [9:0] 	bit_cnto;
wire [9:0] 	bit_cntn;
wire [19:0] baud_cnto;
wire [19:0] baud_cntn;
wire			baud_clk;

tx_eight_ten_cp tx_eight_ten_cp
(
	.rst		 (rst),
	.sel		 (sel),
	.set		 (set),
	.baud_clk (baud_clk),
	.bit_cnto (bit_cnto),
	
	.bit_cntn (bit_cntn),
	.tx_en	 (tx_en)
);

tx_eight_ten_dp tx_eight_ten_dp
(
	.rst		 (rst),
	.tx_en	 (tx_en),
	.tx_d		 (tx_d),
	.bit_cnto (bit_cnto),
	
	.tx_out	 (tx_out)
);

eight_ten eight_ten
(
	.din	(din),
	
	.tx_d (tx_d)
);

baud_counter baud_counter
(
	.rst		  (rst),
	.en		  (tx_en),
	.baud 	  (baud),
	.baud_cnto (baud_cnto),
	.baud_cntn (baud_cntn),
	.baud_clk  (baud_clk)
);

PipeReg #(10) bit_cnt
(
	.CLK (clk),
	.RST (rst),
	.EN  (1'b1),
	.D	  (bit_cntn),
	.Q	  (bit_cnto)
);

PipeReg #(20) baud_cnt
(
	.CLK (clk),
	.RST (rst),
	.EN  (1'b1),
	.D	  (baud_cntn),
	.Q	  (baud_cnto)
);

endmodule
