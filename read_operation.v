//read operation module
module read_operation (Addr, Data, from_reg0, from_reg1, from_reg2, from_reg3, from_reg4, from_reg5, from_reg6, from_reg7);

	//input, output
	input [63:0] from_reg0, from_reg1, from_reg2, from_reg3, from_reg4, from_reg5, from_reg6, from_reg7;
	input [2:0] Addr;
	output [63:0] Data;

	//instance(using MUX)
	_8_to_1_MUX m0(from_reg0, from_reg1, from_reg2, from_reg3, from_reg4, from_reg5, from_reg6, from_reg7, Addr, Data);
	
endmodule
