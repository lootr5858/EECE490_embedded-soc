module tx_eight_ten_dp
(
	input wire			rst,
	input wire			tx_en,
	input wire [9:0]  tx_d,
	input wire [9:0]  bit_cnto,

	output reg tx_out
);

always @ *
begin

	casex ({rst, tx_en, bit_cnto})
	
	{1'b1, 1'bx, 10'dx}: tx_out = 1'b1;	// reset control
	
	{1'b0, 1'b0, 10'dx}: tx_out = 1'b1;	// No tx
	
	{1'b0, 1'b1, 10'd0}:  tx_out = 1'b0;		// TX start
	{1'b0, 1'b1, 10'd1}:  tx_out = tx_d[0];
	{1'b0, 1'b1, 10'd2}:  tx_out = tx_d[1];
	{1'b0, 1'b1, 10'd3}:  tx_out = tx_d[2];
	{1'b0, 1'b1, 10'd4}:  tx_out = tx_d[3];
	{1'b0, 1'b1, 10'd5}:  tx_out = tx_d[4];
	{1'b0, 1'b1, 10'd6}:  tx_out = tx_d[5];
	{1'b0, 1'b1, 10'd7}:  tx_out = tx_d[6];
	{1'b0, 1'b1, 10'd8}:  tx_out = tx_d[7];
	{1'b0, 1'b1, 10'd9}:  tx_out = tx_d[8];
	{1'b0, 1'b1, 10'd10}: tx_out = tx_d[9];
	{1'b0, 1'b1, 10'd11}: tx_out = 1'b1;		// TX end
	
	endcase
end

endmodule
	