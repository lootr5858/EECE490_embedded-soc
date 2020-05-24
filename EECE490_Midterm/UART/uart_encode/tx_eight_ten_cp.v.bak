module tx_eight_ten_cp
(
	input wire 			rst,
	input wire			sel,
	input wire 			set,
	input wire 			baud_clk,
	input wire [9:0]  bit_cnto,
	
	output reg [9:0]  bit_cntn,
	output reg 			tx_en
);

always @ *
begin

	casex ({rst, sel, set, baud_clk, bit_cnto})
	
	{1'b1, 1'bx, 1'bx, 1'bx, 10'dx}: {tx_en, bit_cntn} = {1'b0, 10'd0}; // reset control
	
	{1'b0, 1'b0, 1'bx, 1'bx, 10'dx}: {tx_en, bit_cntn} = {1'b0, 10'd0}; // standby
	
	{1'b0, 1'b1, 1'b0, 1'bx, 10'dx}: {tx_en, bit_cntn} = {1'b0, 10'd0}; // idling
	
	{1'b0, 1'b1, 1'b1, 1'b0, 10'd0}: {tx_en, bit_cntn} = {1'b1, 10'd0};   // Start bit
	{1'b0, 1'b1, 1'b1, 1'b1, 10'd0}: {tx_en, bit_cntn} = {1'b1, 10'd1};
	
	{1'b0, 1'b1, 1'b1, 1'b0, 10'd1}: {tx_en, bit_cntn} = {1'b1, 10'd1};   // din[0]
	{1'b0, 1'b1, 1'b1, 1'b1, 10'd1}: {tx_en, bit_cntn} = {1'b1, 10'd2};
	
	{1'b0, 1'b1, 1'b1, 1'b0, 10'd2}: {tx_en, bit_cntn} = {1'b1, 10'd2};   // din[1]
	{1'b0, 1'b1, 1'b1, 1'b1, 10'd2}: {tx_en, bit_cntn} = {1'b1, 10'd3};
	
	{1'b0, 1'b1, 1'b1, 1'b0, 10'd3}: {tx_en, bit_cntn} = {1'b1, 10'd3};   // din[2]
	{1'b0, 1'b1, 1'b1, 1'b1, 10'd3}: {tx_en, bit_cntn} = {1'b1, 10'd4};
	
	{1'b0, 1'b1, 1'b1, 1'b0, 10'd4}: {tx_en, bit_cntn} = {1'b1, 10'd4};   // din[3]
	{1'b0, 1'b1, 1'b1, 1'b1, 10'd4}: {tx_en, bit_cntn} = {1'b1, 10'd5};
	
	{1'b0, 1'b1, 1'b1, 1'b0, 10'd5}: {tx_en, bit_cntn} = {1'b1, 10'd5};   // din[4]
	{1'b0, 1'b1, 1'b1, 1'b1, 10'd5}: {tx_en, bit_cntn} = {1'b1, 10'd6};
	
	{1'b0, 1'b1, 1'b1, 1'b0, 10'd6}: {tx_en, bit_cntn} = {1'b1, 10'd6};   // din[5]
	{1'b0, 1'b1, 1'b1, 1'b1, 10'd6}: {tx_en, bit_cntn} = {1'b1, 10'd7};
	
	{1'b0, 1'b1, 1'b1, 1'b0, 10'd7}: {tx_en, bit_cntn} = {1'b1, 10'd7};   // din[6]
	{1'b0, 1'b1, 1'b1, 1'b1, 10'd7}: {tx_en, bit_cntn} = {1'b1, 10'd8};
	
	{1'b0, 1'b1, 1'b1, 1'b0, 10'd8}: {tx_en, bit_cntn} = {1'b1, 10'd8};   // din[7]
	{1'b0, 1'b1, 1'b1, 1'b1, 10'd8}: {tx_en, bit_cntn} = {1'b1, 10'd9};
	
	{1'b0, 1'b1, 1'b1, 1'b0, 10'd9}: {tx_en, bit_cntn} = {1'b1, 10'd9}; 	 // din[8]
	{1'b0, 1'b1, 1'b1, 1'b1, 10'd9}: {tx_en, bit_cntn} = {1'b1, 10'd10};
	
	{1'b0, 1'b1, 1'b1, 1'b0, 10'd10}: {tx_en, bit_cntn} = {1'b1, 10'd10}; // din[9]
	{1'b0, 1'b1, 1'b1, 1'b1, 10'd10}: {tx_en, bit_cntn} = {1'b1, 10'd11};
	
	{1'b0, 1'b1, 1'b1, 1'b0, 10'd11}: {tx_en, bit_cntn} = {1'b1, 10'd11}; // stop bit
	{1'b0, 1'b1, 1'b1, 1'b1, 10'd11}: {tx_en, bit_cntn} = {1'b1, 10'd12};	
	
	{1'b0, 1'b1, 1'b1, 1'bx, 10'd12}: {tx_en, bit_cntn} = {1'b0, 10'd12}; // end tx
	
	endcase
end

endmodule
	