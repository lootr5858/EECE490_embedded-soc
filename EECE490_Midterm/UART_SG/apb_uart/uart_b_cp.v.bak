module uart_b_cp
(
	input wire			rst,
	input wire			sel,
	input wire			enable,
	input wire [11:2] addr,
	
	output reg sel_tr,
	output reg sel_ctrl,
	output reg sel_baud,
	output reg ready
);

always @ *
begin

	casex ({rst, sel, enable, addr})
	
	{1'b1, 1'bx, 1'bx, 10'dx}: {sel_tr, sel_ctrl, sel_baud, ready} <= {1'b0, 1'b0, 1'b0, 1'b0};	// reset control
	
	{1'b0, 1'b0, 1'bx, 10'dx}: {sel_tr, sel_ctrl, sel_baud, ready} <= {1'b0, 1'b0, 1'b0, 1'b1};	// idling
	
	// addr = 0x00. sel_tr = 1: READ/WRITE DATA
	{1'b0, 1'b1, 1'b0, 10'd0}: {sel_tr, sel_ctrl, sel_baud, ready} <= {1'b1, 1'b0, 1'b0, 1'b1};	// waiting to transmit/receive
	{1'b0, 1'b1, 1'b1, 10'd0}: {sel_tr, sel_ctrl, sel_baud, ready} <= {1'b1, 1'b0, 1'b0, 1'b0};	// transmit/receive
	
	// addr = 0x08. sel_ctrl = 1: ENABLE TX MODE
	{1'b0, 1'b1, 1'b0, 10'd2}: {sel_tr, sel_ctrl, sel_baud, ready} <= {1'b0, 1'b1, 1'b0, 1'b1};	// waiting to modify CTRL reg
	{1'b0, 1'b1, 1'b1, 10'd2}: {sel_tr, sel_ctrl, sel_baud, ready} <= {1'b0, 1'b1, 1'b0, 1'b0};	// modifying CTRL reg
	
	// addr = 0x10. sel_baud = 1: BAUDRATE SETTING
	{1'b0, 1'b1, 1'b0, 10'd4}: {sel_tr, sel_ctrl, sel_baud, ready} <= {1'b0, 1'b0, 1'b1, 1'b1};	// waiting to set bauddiv
	{1'b0, 1'b1, 1'b1, 10'd4}: {sel_tr, sel_ctrl, sel_baud, ready} <= {1'b0, 1'b0, 1'b1, 1'b0};	// setting bauddiv
	
	endcase

end

endmodule
	