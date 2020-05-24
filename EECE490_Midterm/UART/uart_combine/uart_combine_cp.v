module uart_combine_cp
(
	input wire			rst,
	input wire			sel,
	input wire			enable,
	input wire [11:2] addr,
	
	output reg data_ptr,		// Data reg. 			addr: 0x00
	output reg ctrl_ptr,		// T/R Control reg.  addr: 0x08
	output reg baud_ptr,		// Bauddiv reg.		addr: 0x10
	output reg encode_ptr,	// Binary/8b10b reg. addr: 0x14
	output reg ready	
);

always @ *
begin
	
	casex ( { rst, sel, enable, addr } )
	
	// RESET Control
	{ 1'b1, 1'bx, 1'bx, 10'bx }:
	begin
		
		data_ptr   <= 1'b0;
		ctrl_ptr   <= 1'b0;
		baud_ptr   <= 1'b0;
		encode_ptr <= 1'b0;
		ready		  <= 1'b0;
		
	end
	
	// UART in standby mode
	{ 1'b0, 1'b0, 1'bx, 10'bx}:
	begin
		
		data_ptr   <= 1'b0;
		ctrl_ptr   <= 1'b0;
		baud_ptr   <= 1'b0;
		encode_ptr <= 1'b0;
		ready		  <= 1'b1;
		
	end
	
	// DATA mode (for tx/rx)
	{ 1'b0, 1'b1, 1'b0, 10'h0}: data_ptr <= 1'b1;
		
	// T/R CONTROL mode
	{ 1'b0, 1'b1, 1'b0, 10'h8}: ctrl_ptr <= 1'b1;
		
	// set BAUDDIV mode
	{ 1'b0, 1'b1, 1'b0, 10'h10}: baud_ptr <= 1'b1;
		
	// Binary/8b10b mode
	{ 1'b0, 1'b1, 1'b0, 10'h14}: baud_ptr <= 1'b1;
	
	// Enable mode settings
	{ 1'b0, 1'b1, 1'b1, 10'bx}: ready <= 1'b0;
		
		