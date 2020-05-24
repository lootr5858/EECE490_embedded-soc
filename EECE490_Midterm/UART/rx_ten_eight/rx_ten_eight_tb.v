module rx_ten_eight_tb();

localparam period = 5;
localparam cycle = period * 2;

reg 		  clk;
reg 		  rst;
reg		  sel;
reg [19:0] baud;
reg		  rx_en;
reg		  rx_in;

wire [7:0] rx_data;
wire [9:0] data_o;
wire [9:0] bit_cnt_out;
wire		  baud_clk;

rx_ten_eight rx_ten_eight
(
	.clk	  (clk),
	.rst	  (rst),
	.sel	  (sel),
	.baud   (baud),
	.rx_en  (rx_en),
	.rx_in  (rx_in),
	
	.rx_data (rx_data),
	.data_o  (data_o),
	.bit_cnt_out (bit_cnt_out),
	.baud_clk	 (baud_clk)
);

/* ------ !! ------
	Clock generation
	------ !! ------ */
initial clk <= 1'b1;
always #(period) clk <= ~clk;

/* ------ !! ------
	 Reset COntrol
	------ !! ------ */
initial
begin
	
	rst <= 1'b1;
	
	#(cycle * 2)
	
	rst <= 1'b0;

end

/* ------ !! ------
	 SIMULATION !!!
	------ !! ------ */
initial
begin

	rx_en <= 1'b0;
	sel   <= 1'b1;
	baud  <= 20'd20;
	
	rx_in <= 1'b1;
	
	#(cycle * 4)
	
	// rx: 10'b00101_11011
	
	rx_en <= 1'b1;
	
	rx_in <= 1'b0;		// start bit
	
	#(cycle * 40)
	
	rx_in <= 1'b1;		// bit 0
	
	#(cycle * 20)
	
	rx_in <= 1'b1;		// bit 1
	
	#(cycle * 20)
	
	rx_in <= 1'b0;		// bit 2
	
	#(cycle * 20)
	
	rx_in <= 1'b1;		// bit 3
	
	#(cycle * 20)
	
	rx_in <= 1'b1;		// bit 4
	
	#(cycle * 20)
	
	rx_in <= 1'b1;		// bit 5
	
	#(cycle * 20)
	
	rx_in <= 1'b0;		// bit 6
	
	#(cycle * 20)
	
	rx_in <= 1'b1;		// bit 7
	
	#(cycle * 20)
	
	rx_in <= 1'b0;		// bit 8
	
	#(cycle * 20)
	
	rx_in <= 1'b0;		// bit 9
	
	#(cycle * 20)
	
	rx_in <= 1'b1;		// stop bit
	
	#(cycle * 20)
	
	rx_en <= 1'b0;
	
	#(cycle * 40)
	
	$finish();
	
end
	
endmodule
