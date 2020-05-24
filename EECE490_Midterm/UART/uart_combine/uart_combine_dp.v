module uart_combine_dp
(
	input wire			clk,
	input wire			rst,
	input wire			data_ptr,		// Data reg. 			addr: 0x00
	input wire			ctrl_ptr,		// T/R Control reg.  addr: 0x08
	input wire			baud_ptr,		// Bauddiv reg.		addr: 0x10
	input wire			encode_ptr,	// Binary/8b10b reg. addr: 0x14
	input wire			enable,
	input wire [31:0] data_out,
	input wire			rx_in,
	
	output reg [31:0] data_in,
	output wire	      tx_en,
	output wire			tx_out,
	output wire	[9:0] bit_cnt,
	output wire [9:0] tx_d,
	output wire [9:0] rx_d
);

reg		 btx_ptr;	// Select Binary TX module
reg		 brx_ptr;	// Select Binary RX module
reg		 etx_ptr;	// Select 8B10B TX module
reg		 erx_ptr;	// Select 8B10B RX module
reg [7:0] din;
reg [6:0] ctrl_reg;
reg [19:0] baud;

wire [7:0] dout;
//wire [9:0] bit_cnt

uart_tx uart_tx
(
	.clk	(clk),
	.rst	(rst),
	.sel	(btx_ptr),
	.set	(enable),
	.din	(din),
	.baud (baud),
	
	.tx_en  (tx_en),
	.tx_out (tx_out)
);

uart_rx uart_rx
(
	.clk	 (clk),
	.rst	 (rst),
	.sel	 (brx_ptr),
	.baud  (baud),
	.rx_en (enable),
	.rx_in (rx_in),
	
	.bit_cnt_out (bit_cnt),
	.rx_data (dout)
);

tx_eight_ten tx_eight_ten
(
	.clk	(clk),
	.rst	(rst),
	.sel	(etx_ptr),
	.set	(enable),
	.din	(din),
	.baud (baud),
	
	.tx_en  (tx_en),
	.tx_out (tx_out),
	.tx_d	  (tx_d)
);

rx_ten_eight rx_ten_eight
(
	.clk	 (clk),
	.rst	 (rst),
	.sel	 (erx_ptr),
	.baud  (baud),
	.rx_en (enable),
	.rx_in (rx_in),
	
	.bit_cnt_out (bit_cnt),
	.rx_data (dout),
	.data_o  (rx_d)
);


always @ *
begin

	casex ( { rst, enable, data_ptr, ctrl_ptr, baud_ptr, encode_ptr, ctrl_reg } )
	
	// RESET Control
	{1'b1, 1'bx, 1'bx, 1'bx, 1'bx, 1'bx, 7'bx }:
	begin
	
		btx_ptr  <= 1'b0;
		brx_ptr  <= 1'b0;
		etx_ptr  <= 1'b0;
		erx_ptr  <= 1'b0;
		din 		<= 8'b0;
		ctrl_reg <= 7'b0;
		baud 		<= 20'bx;
			
	end
	
	// TX Binary DATA
	{1'b0, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 7'b0000_001 }:
	begin
	
		btx_ptr <= 1'b1;
		brx_ptr <= 1'b0;
		etx_ptr  <= 1'b0;
		erx_ptr  <= 1'b0;
		
		din[0] <= data_out[0];
		din[1] <= data_out[1];
		din[2] <= data_out[2];
		din[3] <= data_out[3];
		din[4] <= data_out[4];
		din[5] <= data_out[5];
		din[6] <= data_out[6];
		din[7] <= data_out[7];
		
	end
	
	// RX Binary DATA
	{1'b0, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 7'b0000_010 }:
	begin

		btx_ptr <= 1'b0;
		brx_ptr <= 1'b1;
		etx_ptr <= 1'b0;
		erx_ptr <= 1'b0;
		
		if (bit_cnt == 10'd9)
		begin
		
			data_in	  = 32'b0;
			data_in[0] = dout[0];
			data_in[1] = dout[1];
			data_in[2] = dout[2];
			data_in[3] = dout[3];
			data_in[4] = dout[4];
			data_in[5] = dout[5];
			data_in[6] = dout[6];
			data_in[7] = dout[7];
			
		end
		
	end
	
	
	// TX 8B10B DATA
	{1'b0, 1'b1, 1'b1, 1'b0, 1'b0, 1'b1, 7'b0000_001 }:
	begin
	
		btx_ptr <= 1'b0;
		brx_ptr <= 1'b0;
		etx_ptr <= 1'b1;
		erx_ptr <= 1'b0;
		
		din[0] <= data_out[0];
		din[1] <= data_out[1];
		din[2] <= data_out[2];
		din[3] <= data_out[3];
		din[4] <= data_out[4];
		din[5] <= data_out[5];
		din[6] <= data_out[6];
		din[7] <= data_out[7];
		
	end
	
	// RX Binary DATA
	{1'b0, 1'b1, 1'b1, 1'b0, 1'b0, 1'b1, 7'b0000_010 }:
	begin

		btx_ptr <= 1'b0;
		brx_ptr <= 1'b0;
		etx_ptr <= 1'b0;
		erx_ptr <= 1'b1;
		
		if (bit_cnt == 10'd9)
		begin
		
			data_in	  = 32'b0;
			data_in[0] = dout[0];
			data_in[1] = dout[1];
			data_in[2] = dout[2];
			data_in[3] = dout[3];
			data_in[4] = dout[4];
			data_in[5] = dout[5];
			data_in[6] = dout[6];
			data_in[7] = dout[7];
			
		end
		
	end