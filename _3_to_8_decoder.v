module _3_to_8_decoder(d, q); //decoder module

	//input, output reg
	input [2:0] d;
	output reg [6:0] q;
	
	//always
	always@(d) begin
		case(d)
			3'b000: q = 7'b00000001;
			3'b001: q = 7'b00000010;
			3'b010: q = 7'b00000100;
			3'b011: q = 7'b00001000;
			3'b100: q = 7'b00010000;
			3'b101: q = 7'b00100000;
			3'b110: q = 7'b01000000;
			default : q = 8'hx;
		endcase
	end
	
endmodule
