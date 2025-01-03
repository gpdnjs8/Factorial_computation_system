module cla4(a, b, ci, s, co);  //4 bits carry lookahead adder

	//input, output, wire
	input [3:0] a, b;
	input ci;
	output [3:0] s;
	output co;
	wire [3:0] c;
	
	//instance
	//using fa_v2 and clb4
	fa_v2 U0_fa_v2(.a(a[0]), .b(b[0]), .ci(ci), .s(s[0]));
	fa_v2 U1_fa_v2(.a(a[1]), .b(b[1]), .ci(c[0]), .s(s[1]));
	fa_v2 U2_fa_v2(.a(a[2]), .b(b[2]), .ci(c[1]), .s(s[2]));
	fa_v2 U3_fa_v2(.a(a[3]), .b(b[3]), .ci(c[2]), .s(s[3]));
	clb4 U4_clb(.a(a), .b(b), .ci(ci), .c1(c[0]), .c2(c[1]), .c3(c[2]), .co(co));

endmodule  //end of module
