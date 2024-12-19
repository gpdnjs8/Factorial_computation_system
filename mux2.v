module mux2(d0, d1, s, y);  //1 bit 2:1 MUX

	//input, output, wire
	input d0, d1;
	input s;
	output y;
	
	//assign y(conditional operator)
	assign y=(s==0)?d0:d1;
	
endmodule  //end of module
