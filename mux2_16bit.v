module mux2_16bit(d0, d1, s, y);  //8 bit 2:1 MUX

	//input, output
	input [15:0] d0, d1;
	input s;
	output [15:0] y;
	
	//assign y(conditional operator)
	assign y=(s==0)?d0:d1;
	
endmodule   //end of module