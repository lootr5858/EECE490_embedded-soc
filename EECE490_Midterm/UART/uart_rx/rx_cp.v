module rx_cp
(
	input wire			rst,
	input wire			sel,
	input wire			rx_en,
	input wire			baud_clk,
	input wire [9:0]  bit_cnto,
	
	output reg [9:0] bit_cntn
);

always @ *
begin

	casex ({rst, sel, rx_en, baud_clk, bit_cnto})
	
	{1'b1, 1'bx, 1'bx, 1'bx, 10'dx}: bit_cntn <= 10'd0;	// reset control
	
	{1'b0, 1'b0, 1'bx, 1'bx, 10'dx}: bit_cntn <= 10'd0;	// standby
	
	{1'b0, 1'b1, 1'b0, 1'bx, 10'dx}: bit_cntn <= 10'd0;	// idling
	
	{1'b0, 1'b1, 1'b1, 1'b0, 10'd0}: bit_cntn <= 10'd0;	// rx start bit
	{1'b0, 1'b1, 1'b1, 1'b1, 10'd0}: bit_cntn <= 10'd1;
	
	{1'b0, 1'b1, 1'b1, 1'b0, 10'd1}: bit_cntn <= 10'd1;	// rx bit 1
	{1'b0, 1'b1, 1'b1, 1'b1, 10'd1}: bit_cntn <= 10'd2;
	
	{1'b0, 1'b1, 1'b1, 1'b0, 10'd2}: bit_cntn <= 10'd2;	// rx bit 2
	{1'b0, 1'b1, 1'b1, 1'b1, 10'd2}: bit_cntn <= 10'd3;
	
	{1'b0, 1'b1, 1'b1, 1'b0, 10'd3}: bit_cntn <= 10'd3;	// rx bit 3
	{1'b0, 1'b1, 1'b1, 1'b1, 10'd3}: bit_cntn <= 10'd4;
	
	{1'b0, 1'b1, 1'b1, 1'b0, 10'd4}: bit_cntn <= 10'd4;	// rx bit 4
	{1'b0, 1'b1, 1'b1, 1'b1, 10'd4}: bit_cntn <= 10'd5;
	
	{1'b0, 1'b1, 1'b1, 1'b0, 10'd5}: bit_cntn <= 10'd5;	// rx bit 5
	{1'b0, 1'b1, 1'b1, 1'b1, 10'd5}: bit_cntn <= 10'd6;
	
	{1'b0, 1'b1, 1'b1, 1'b0, 10'd6}: bit_cntn <= 10'd6;	// rx bit 6
	{1'b0, 1'b1, 1'b1, 1'b1, 10'd6}: bit_cntn <= 10'd7;
	
	{1'b0, 1'b1, 1'b1, 1'b0, 10'd7}: bit_cntn <= 10'd7;	// rx bit 7
	{1'b0, 1'b1, 1'b1, 1'b1, 10'd7}: bit_cntn <= 10'd8;
	
	{1'b0, 1'b1, 1'b1, 1'b0, 10'd8}: bit_cntn <= 10'd8;	// rx bit 8
	{1'b0, 1'b1, 1'b1, 1'b1, 10'd8}: bit_cntn <= 10'd9;
	
	{1'b0, 1'b1, 1'b1, 1'b0, 10'd9}: bit_cntn <= 10'd9;	// rx stop bit
	{1'b0, 1'b1, 1'b1, 1'b1, 10'd9}: bit_cntn <= 10'd10;
	
	{1'b0, 1'b1, 1'b1, 1'bx, 10'd10}: bit_cntn <= 10'd10;
	
	endcase
	
end

endmodule
