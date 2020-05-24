`timescale 1ns/1ps

module sg_uart_rx(

  input  wire		CLK,		// clock
  input  wire		RESETn,		// reset (negative active)

  output reg		PSEL,     	// Device select
  output reg	[11:2] 	PADDR,    	// Address
  output reg		PENABLE,  	// Transfer control
  output reg		PWRITE,   	// Write control
  output reg	[31:0]	PWDATA,   	// Write data

  input  wire	[31:0]	PRDATA,		// Read data
  input	 wire		PREADY		// Device ready

);


// index control for the testing sequences 
wire	[9:0]	INDEX_D;
reg	[9:0]	INDEX_Q;
reg		INDEX_INC;
reg		INDEX_DEC;

assign	INDEX_D	= (INDEX_INC) ? INDEX_Q + 10'b1 : 
		  (INDEX_DEC) ? INDEX_Q - 10'b1 : INDEX_Q;

always @ (posedge CLK)
begin
	if(~RESETn)	INDEX_Q <= 10'd0;
	else		INDEX_Q <= INDEX_D;
end

// read data validation
wire	RD_VALID;
assign 	RD_VALID = PRDATA == 32'h0000_0053;

// sequence table

always @ *
begin
	casex({INDEX_Q, PREADY, RD_VALID})

	{10'd0 , 1'bx, 1'bx}:	{PADDR, PWRITE, PSEL, PENABLE, PWDATA, INDEX_INC, INDEX_DEC} <= {10'dx, 1'b0, 1'b0, 1'b0, 32'hxxxx_xxxx, 1'b1, 1'b0};	// Reset 
	{10'd1 , 1'bx, 1'bx}:	{PADDR, PWRITE, PSEL, PENABLE, PWDATA, INDEX_INC, INDEX_DEC} <= {10'd4, 1'b1, 1'b1, 1'b0, 32'h0000_0020, 1'b1, 1'b0};	// Baudrate setting 0
	{10'd2 , 1'b0, 1'bx}:	{PADDR, PWRITE, PSEL, PENABLE, PWDATA, INDEX_INC, INDEX_DEC} <= {10'd4, 1'b1, 1'b1, 1'b1, 32'h0000_0020, 1'b0, 1'b0};	// Baudrate setting 1 (wait)
	{10'd2 , 1'b1, 1'bx}:	{PADDR, PWRITE, PSEL, PENABLE, PWDATA, INDEX_INC, INDEX_DEC} <= {10'd4, 1'b1, 1'b1, 1'b1, 32'h0000_0020, 1'b1, 1'b0};	// Baudrate setting 1 (ready)
	{10'd3 , 1'bx, 1'bx}:	{PADDR, PWRITE, PSEL, PENABLE, PWDATA, INDEX_INC, INDEX_DEC} <= {10'dx, 1'b0, 1'b0, 1'b0, 32'hxxxx_xxxx, 1'b1, 1'b0};	// Dummy cycle
	{10'd4 , 1'bx, 1'bx}:	{PADDR, PWRITE, PSEL, PENABLE, PWDATA, INDEX_INC, INDEX_DEC} <= {10'd2, 1'b1, 1'b1, 1'b0, 32'h0000_0026, 1'b1, 1'b0};	// CTRL setting 0
	{10'd5 , 1'b0, 1'bx}:	{PADDR, PWRITE, PSEL, PENABLE, PWDATA, INDEX_INC, INDEX_DEC} <= {10'd2, 1'b1, 1'b1, 1'b1, 32'h0000_0026, 1'b0, 1'b0};	// CTRL setting 1 (wait)
	{10'd5 , 1'b1, 1'bx}:	{PADDR, PWRITE, PSEL, PENABLE, PWDATA, INDEX_INC, INDEX_DEC} <= {10'd2, 1'b1, 1'b1, 1'b1, 32'h0000_0026, 1'b1, 1'b0};	// CTRL setting 1 (ready)
	{10'd6 , 1'bx, 1'bx}:	{PADDR, PWRITE, PSEL, PENABLE, PWDATA, INDEX_INC, INDEX_DEC} <= {10'dx, 1'b0, 1'b0, 1'b0, 32'hxxxx_xxxx, 1'b1, 1'b0};	// Dummy cycle
	{10'd7 , 1'bx, 1'bx}:	{PADDR, PWRITE, PSEL, PENABLE, PWDATA, INDEX_INC, INDEX_DEC} <= {10'd0, 1'b0, 1'b1, 1'b0, 32'hxxxx_xxxx, 1'b1, 1'b0};	// RX data read 0
	{10'd8 , 1'b0, 1'bx}:	{PADDR, PWRITE, PSEL, PENABLE, PWDATA, INDEX_INC, INDEX_DEC} <= {10'd0, 1'b0, 1'b1, 1'b1, 32'hxxxx_xxxx, 1'b0, 1'b0};	// RX data read 1 (wait)
	{10'd8 , 1'b1, 1'b0}:	{PADDR, PWRITE, PSEL, PENABLE, PWDATA, INDEX_INC, INDEX_DEC} <= {10'd0, 1'b0, 1'b1, 1'b1, 32'hxxxx_xxxx, 1'b0, 1'b1};	// RX data read 1 (ready, invalid)
	{10'd8 , 1'b1, 1'b1}:	{PADDR, PWRITE, PSEL, PENABLE, PWDATA, INDEX_INC, INDEX_DEC} <= {10'd0, 1'b0, 1'b1, 1'b1, 32'hxxxx_xxxx, 1'b1, 1'b0};	// RX data read 1 (ready, valid)
	{10'd13, 1'bx, 1'bx}:	{PADDR, PWRITE, PSEL, PENABLE, PWDATA, INDEX_INC, INDEX_DEC} <= {10'dx, 1'b0, 1'b0, 1'b0, 32'hxxxx_xxxx, 1'b0, 1'b0};	// Finish

	endcase
end

endmodule
