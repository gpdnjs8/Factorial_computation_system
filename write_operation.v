module write_operation(Addr, we, wEn);  //write operation module

	//input, output, wire
	input we;
	input [2:0] Addr;
	output [6:0] wEn;
	wire [6:0] w_a;
	
	//instance(using decoder and 2-input AND gate)
	_3_to_8_decoder d0(Addr, w_a);
	_and2 a0(we, w_a[0], wEn[0]);
	_and2 a1(we, w_a[1], wEn[1]);
	_and2 a2(we, w_a[2], wEn[2]);
	_and2 a3(we, w_a[3], wEn[3]);
	_and2 a4(we, w_a[4], wEn[4]);
	_and2 a5(we, w_a[5], wEn[5]);
	_and2 a6(we, w_a[6], wEn[6]);
endmodule
