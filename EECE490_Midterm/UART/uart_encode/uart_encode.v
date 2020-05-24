module uart_encode
(
	input wire			clk,
	input wire			rst,
	input wire			sel,			// select device
	input wire			enable,		// enable operations
	input wire [11:2] addr,			// retrieve register position
	input wire [31:0] data_out,	// data from uart to peripherals
	input wire			rx_in,
	
	output wire [31:0] data_in,	// data from peripherals to uart
	output wire			 ready,
	output wire			 tx_out,
	output wire			 tx_en,
	output wire	[9:0]	 bit_cnt,
	output wire [9:0]  rx_d,
	output wire [9:0]  tx_d
);

wire sel_tr;
wire sel_ctrl;
wire sel_baud;

uart_encode_cp uart_encode_cp
(
	.rst	  (rst),
	.sel	  (sel),
	.enable (enable),
	.addr	  (addr),
	
	.sel_tr	 (sel_tr),
	.sel_ctrl (sel_ctrl),
	.sel_baud (sel_baud),
	.ready	 (ready)
);

uart_encode_dp uart_encode_dp
(
	.clk		 (clk),
	.rst		 (rst),
	.sel_tr   (sel_tr),
	.sel_ctrl (sel_ctrl),
	.sel_baud (sel_baud),
	.enable	 (enable),
	.data_out (data_out),
	.rx_in	 (rx_in),
	
	.data_in (data_in),
	.tx_en	(tx_en),
	.tx_out	(tx_out),
	.bit_cnt (bit_cnt),
	.rx_d		(rx_d),
	.tx_d		(tx_d)
);

endmodule	