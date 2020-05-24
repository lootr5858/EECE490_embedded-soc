module uart_binary
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
	output wire	[9:0]	 bit_cnt
);

wire sel_tr;
wire sel_ctrl;
wire sel_baud;

uart_b_cp uart_cp
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

uart_b_dp uart_dp
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
	.bit_cnt (bit_cnt)
);

endmodule	