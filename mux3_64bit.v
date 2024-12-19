module mux3_64bit(d0, d1, d2, s, y);  //64 bit 3:1 MUX

	//input, output
	input [63:0] d0, d1, d2;
	input [1:0] s;
	output [63:0] y;
	
	//assign y(conditional operator)
	assign y=(s==2'b00)?d0: ((s==2'b01)?d1:d2);
	
endmodule   //end of module