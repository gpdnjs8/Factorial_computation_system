module _8_to_1_MUX(a, b, c, d, e, f, g, h, sel, d_out);  //8-to-1 MUX module

	//input, output reg
	input [63:0] a, b, c, d, e, f, g, h;
	input [2:0] sel;
	output reg [63:0] d_out;
	
	//always
	always@(sel, a, b, c, d, e, f, g, h) 
	begin
		case(sel)
			3'b000 : d_out <= a;
			3'b001 : d_out <= b;
			3'b010 : d_out <= c;
			3'b011 : d_out <= d;
			3'b100 : d_out <= e;
			3'b101 : d_out <= f;
			3'b110 : d_out <= g;
			3'b111 : d_out <= h;
			default : d_out <= 32'hx;
		endcase
	end
	
endmodule
