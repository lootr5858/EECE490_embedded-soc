module ten_eight
(
	input wire [9:0] data_o,
	input wire [9:0] bit_cnto,
	
	output wire [7:0] rx_data
);

reg [3:0] four_msb;
reg [5:0] six_lsb;

reg [2:0] three_msb;
reg [4:0] five_lsb;



always @ *
begin

	casex({bit_cnto})
	
		10'd11:
			begin
				
				six_lsb[0] = data_o[0];
				six_lsb[1] = data_o[1];
				six_lsb[2] = data_o[2];
				six_lsb[3] = data_o[3];
				six_lsb[4] = data_o[4];
				six_lsb[5] = data_o[5];

				four_msb[0] = data_o[6];
				four_msb[1] = data_o[7];
				four_msb[2] = data_o[8];
				four_msb[3] = data_o[9];
				
			end
			
		endcase

	casex({bit_cnto, six_lsb})
	
		{10'd11, 6'b100111}: five_lsb = 5'b00000;
		{10'd11, 6'b011000}: five_lsb = 5'b00000;
		
		{10'd11, 6'b011101}: five_lsb = 5'b00001;
		{10'd11, 6'b100010}: five_lsb = 5'b00001;
		
		{10'd11, 6'b101101}: five_lsb = 5'b00010;
		{10'd11, 6'b010010}: five_lsb = 5'b00010;
		
		{10'd11, 6'b110001}: five_lsb = 5'b00011;
		
		{10'd11, 6'b110101}: five_lsb = 5'b00100;
		{10'd11, 6'b001010}: five_lsb = 5'b00100;
		
		{10'd11, 6'b101001}: five_lsb = 5'b00101;
		
		{10'd11, 6'b011001}: five_lsb = 5'b00110;
		
		{10'd11, 6'b111000}: five_lsb = 5'b00111;
		{10'd11, 6'b000111}: five_lsb = 5'b00111;
		
		{10'd11, 6'b111001}: five_lsb = 5'b01000;
		{10'd11, 6'b000110}: five_lsb = 5'b01000;
		
		{10'd11, 6'b100101}: five_lsb = 5'b01001;
		
		{10'd11, 6'b010101}: five_lsb = 5'b01010;
		
		{10'd11, 6'b110100}: five_lsb = 5'b01011;
		
		{10'd11, 6'b001101}: five_lsb = 5'b01100;
		
		{10'd11, 6'b101100}: five_lsb = 5'b01101;
		
		{10'd11, 6'b011100}: five_lsb = 5'b01110;
		
		{10'd11, 6'b010111}: five_lsb = 5'b01111;
		{10'd11, 6'b101000}: five_lsb = 5'b01111;
		
		{10'd11, 6'b011011}: five_lsb = 5'b10000;
		{10'd11, 6'b100100}: five_lsb = 5'b10000;
		
		{10'd11, 6'b100011}: five_lsb = 5'b10001;
		
		{10'd11, 6'b010011}: five_lsb = 5'b10010;
		
		{10'd11, 6'b110010}: five_lsb = 5'b10011;
		
		{10'd11, 6'b001011}: five_lsb = 5'b10100;
		
		{10'd11, 6'b101010}: five_lsb = 5'b10101;
		
		{10'd11, 6'b011010}: five_lsb = 5'b10110;
		
		{10'd11, 6'b111010}: five_lsb = 5'b10111;
		{10'd11, 6'b000101}: five_lsb = 5'b10111;
		
		{10'd11, 6'b110011}: five_lsb = 5'b11000;
		{10'd11, 6'b001100}: five_lsb = 5'b11000;
		
		{10'd11, 6'b100110}: five_lsb = 5'b11001;
		
		{10'd11, 6'b010110}: five_lsb = 5'b11010;
		
		{10'd11, 6'b110110}: five_lsb = 5'b11011;
		{10'd11, 6'b001001}: five_lsb = 5'b11011;
		
		{10'd11, 6'b001110}: five_lsb = 5'b11100;
		
		{10'd11, 6'b101110}: five_lsb = 5'b11101;
		{10'd11, 6'b010001}: five_lsb = 5'b11101;
		
		{10'd11, 6'b011110}: five_lsb = 5'b11110;
		{10'd11, 6'b100001}: five_lsb = 5'b11110;
		
		{10'd11, 6'b101001}: five_lsb = 5'b11111;
		{10'd11, 6'b010100}: five_lsb = 5'b11111;
		
	endcase

	casex({bit_cnto, four_msb})
	
		{10'd11, 4'b0100}: three_msb = 3'b000;
		{10'd11, 4'b1011}: three_msb = 3'b000;
		
		{10'd11, 4'b1001}: three_msb = 3'b001;
		
		{10'd11, 4'b0101}: three_msb = 3'b010;
		
		{10'd11, 4'b0011}: three_msb = 3'b011;
		{10'd11, 4'b1100}: three_msb = 3'b011;
		
		{10'd11, 4'b0010}: three_msb = 3'b100;
		{10'd11, 4'b1101}: three_msb = 3'b100;
		
		{10'd11, 4'b1010}: three_msb = 3'b101;
		
		{10'd11, 4'b0110}: three_msb = 3'b110;
		
		{10'd11, 4'b0001}: three_msb = 3'b111;
		{10'd11, 4'b1110}: three_msb = 3'b111;
		{10'd11, 4'b1000}: three_msb = 3'b111;
		{10'd11, 4'b0111}: three_msb = 3'b111;
		
	endcase
	
end

assign rx_data = {three_msb, five_lsb};

endmodule
	