module eight_ten
(
	input wire [7:0] din,
	
	output wire [9:0] tx_d
);

wire [2:0] three_msb;
wire [4:0] five_lsb;

reg [3:0] four_msb;
reg [5:0] six_lsb;

assign five_lsb[0] = din[0];
assign five_lsb[1] = din[1];
assign five_lsb[2] = din[2];
assign five_lsb[3] = din[3];
assign five_lsb[4] = din[4];

assign three_msb[0] = din[5];
assign three_msb[1] = din[6];
assign three_msb[2] = din[7];

always @ *
begin
	
	casex (five_lsb)
	
		5'd0: six_lsb = 6'b100_111;
		5'd1: six_lsb = 6'b011_101;
		5'd2: six_lsb = 6'b101_101;
		5'd3: six_lsb = 6'b110_001;
		
		5'd4: six_lsb = 6'b110_101;
		5'd5: six_lsb = 6'b101_001;
		5'd6: six_lsb = 6'b011_001;
		5'd7: six_lsb = 6'b111_000;
		
		5'd8: six_lsb = 6'b111_001;
		5'd9: six_lsb = 6'b100_101;
		5'd10: six_lsb = 6'b010_101;
		5'd11: six_lsb = 6'b110_100;
		
		5'd12: six_lsb = 6'b001_101;
		5'd13: six_lsb = 6'b101_100;
		5'd14: six_lsb = 6'b011_100;
		5'd15: six_lsb = 6'b010_111;
		
		5'd16: six_lsb = 6'b011_011;
		5'd17: six_lsb = 6'b100_001;
		5'd18: six_lsb = 6'b010_011;
		5'd19: six_lsb = 6'b110_010;
		
		5'd20: six_lsb = 6'b001_011;
		5'd21: six_lsb = 6'b101_010;
		5'd22: six_lsb = 6'b011_010;
		5'd23: six_lsb = 6'b111_010;
		
		5'd24: six_lsb = 6'b110_011;
		5'd25: six_lsb = 6'b100_110;
		5'd26: six_lsb = 6'b010_110;
		5'd27: six_lsb = 6'b110_110;
		
		5'd28: six_lsb = 6'b001_110;
		5'd29: six_lsb = 6'b101_110;
		5'd30: six_lsb = 6'b011_110;
		5'd31: six_lsb = 6'b101_011;
		
	endcase
	
	casex (three_msb)
	
		3'd0: four_msb = 4'b0100;
		3'd1: four_msb = 4'b1001;
		3'd2: four_msb = 4'b0101;
		3'd3: four_msb = 4'b0011;
		
		3'd4: four_msb = 4'b0010;
		3'd5: four_msb = 4'b1010;
		3'd6: four_msb = 4'b0110;
		3'd7: four_msb = 4'b0001;
		
	endcase

end

assign tx_d = {four_msb, six_lsb};

endmodule
