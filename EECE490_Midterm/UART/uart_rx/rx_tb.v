module rx_tb();

localparam period = 5;
localparam cycle = period * 2;

reg		  clk;
reg		  rst;
reg [19:0] baud;
reg		  rx_en;
reg		  rx_in;
reg		  sel;

wire [7:0] rx_data;

uart_rx uart_rx
(
	.clk		(clk),
	.rst		(rst),
	.sel		(sel),
	.baud		(baud),
	.rx_en	(rx_en),
	.rx_in	(rx_in),
	.rx_data (rx_data)
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

	baud <= 20'd20;	// set baddiv
	sel <= 1'b1;
	rx_in <= 1'b1;
	
	#(cycle * 4)
	
	rx_en <= 1'b1;
	
	rx_in <= 1'b0;	//0
	
	#(cycle * 20)
	
	rx_in <= 1'b1; //1
	
	#(cycle * 20)
	
	rx_in <= 1'b0; //2
	
	#(cycle * 20)
	
	rx_in <= 1'b1; //3
	
	#(cycle * 20)
	
	rx_in <= 1'b0; //4
	
	#(cycle * 20)
	
	rx_in <= 1'b1; //5
	
	#(cycle * 20)
	
	rx_in <= 1'b0; //6
	
	#(cycle * 20)
	
	rx_in <= 1'b1; //7
	
	#(cycle * 20)
	
	rx_in <= 1'b0; //8 01010101
	
	#(cycle * 20)
	
	rx_in <= 1'b1; //9
	
	#(cycle * 20)
	
	rx_en <= 1'b0;
	
	#(cycle * 4)
	
	$finish();
	
end

endmodule	
	