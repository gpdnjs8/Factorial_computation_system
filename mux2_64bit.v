module mux2_64bit(d0, d1, s, y);  //32 bits 2:1 MUX

	//input, output
	input [63:0] d0, d1;
	input s;
	output [63:0] y;

	//assign y(conditional operator)
	assign y=(s==0)?d0:d1;
	
endmodule   //end of module