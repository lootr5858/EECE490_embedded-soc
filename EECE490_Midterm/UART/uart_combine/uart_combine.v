module uart_combine
(
	input wire			clk,
	input wire			rst,
	input wire			sel,
	input wire			enable,
	input wire [11:2] addr,
	input wire [31:0] data_out,
	input wire			rx_in,
	
	output wire [31:0] data_in,
	output wire			 ready,
	output wire			 tx_out,
	output wire			 tx_en,
	output wire	[9:0]  bit-cnt,
	output wire [9:0]  rx_d,
	output wire [9:0]  tx_d
);

wire data_ptr;		// Data reg. 			addr: 0x00
wire ctrl_ptr;		// T/R Control reg.  addr: 0x08
wire baud_ptr;		// Bauddiv reg.		addr: 0x10
wire encode_ptr;	// Binary/8b10b reg. addr: 0x14

uart_combine_cp uart_combine_cp
(
	.rst	  (rst),
	.sel	  (sel),
	.enable (enable),
	.addr	  (addr),
	
	.data_ptr	 	(data_ptr),
	.ctrl_ptr 	(ctrl_ptr),
	.baud_ptr 	(baud_ptr),
	.encode_ptr (encode_ptr),
	.ready	 	(ready)
);

uart_combine_dp uart_combine_dp
(
	.clk		 	(clk),
	.rst		 	(rst),
	.data_ptr   	(data_ptr),
	.ctrl_ptr 	(ctrl_ptr),
	.baud_ptr 	(baud_ptr),
	.encode_ptr (encode_ptr),
	.enable	 	(enable),
	.data_out 	(data_out),
	.rx_in	 	(rx_in),
	
	.data_in (data_in),
	.tx_en	(tx_en),
	.tx_out	(tx_out),
	.bit_cnt (bit_cnt),
	.rx_d		(rx_d),
	.tx_d		(tx_d)
);

endmodule
