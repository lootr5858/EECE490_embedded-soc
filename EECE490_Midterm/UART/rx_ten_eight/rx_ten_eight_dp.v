module rx_ten_eight_dp
(
	input wire			rst,
	input wire			rx_en,
	input wire			rx_in,
	input wire [9:0]  bit_cnto,
	
	output reg	[9:0] data_o
);

reg d0;
reg d1;
reg d2;
reg d3;
reg d4;
reg d5;
reg d6;
reg d7;
reg d8;
reg d9;

always @ *
begin

	casex ({rst, rx_en, bit_cnto})
	
	{1'b1, 1'bx, 10'dx, 1'bx}: {data_o, d0, d1, d2, d3, d4, d5, d6, d7, d8, d9} = {10'dx, 1'dx, 1'dx, 1'dx, 1'dx, 1'dx, 1'dx, 1'dx, 1'dx, 1'dx, 1'dx};
	
	{1'b0, 1'b0, 10'dx}: {d0, d1, d2, d3, d4, d5, d6, d7, d8, d9} = {1'dx, 1'dx, 1'dx, 1'dx, 1'dx, 1'dx, 1'dx, 1'dx, 1'dx, 1'dx};
	
	{1'b0, 1'b1, 10'd0}: {data_o, d0, d1, d2, d3, d4, d5, d6, d7, d8, d9} = {10'dx, 1'dx, 1'dx, 1'dx, 1'dx, 1'dx, 1'dx, 1'dx, 1'dx, 1'dx, 1'dx};
	
	{1'b0, 1'b1, 10'd1}:  d0 <= rx_in;
	{1'b0, 1'b1, 10'd2}:  d1 <= rx_in;
	{1'b0, 1'b1, 10'd3}:  d2 <= rx_in;
	{1'b0, 1'b1, 10'd4}:  d3 <= rx_in;
	{1'b0, 1'b1, 10'd5}:  d4 <= rx_in;
	{1'b0, 1'b1, 10'd6}:  d5 <= rx_in;
	{1'b0, 1'b1, 10'd7}:  d6 <= rx_in;
	{1'b0, 1'b1, 10'd8}:  d7 <= rx_in;
	{1'b0, 1'b1, 10'd9}:  d8 <= rx_in;
	{1'b0, 1'b1, 10'd10}: d9 <= rx_in;
	
	{1'b0, 1'b1, 10'd11}: data_o <= {d9, d8, d7, d6, d5, d4, d3, d2, d1, d0};
	
	endcase
	
end

endmodule
