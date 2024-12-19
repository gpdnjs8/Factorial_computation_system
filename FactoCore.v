//Factorial core
module FactoCore(clk, reset_n, s_sel, s_wr, s_addr, s_din, s_dout, interrupt);

	//input, output
	input clk, reset_n;
	input s_sel, s_wr;
	input	[15:0] s_addr;
	input [63:0] s_din;
	
	output [63:0] s_dout;
	output  interrupt;
	
	//register
	wire [63:0] opstart, opclear, opdone;
	wire [63:0] next_opdone;
	wire [63:0] intrEn, operand;
	wire [63:0] result_h, result_l;
	wire [63:0] next_result_h, next_result_l;
	wire [6:0] en;
	wire [2:0] addr;
	
	wire [63:0] multiplier, multiplicand;
	wire mul_op_start, mul_op_clear, mul_op_done;
	wire enable0;
	wire [63:0] sdin0, sdin1, sdin2;
	
	//instance
	_register64_r rr0(clk, reset_n, enable0, sdin0, opstart); 
	_register64_r rr1(clk, reset_n, en[1], s_din, opclear);
	_register64_r rr2(clk, reset_n, 1, next_opdone, opdone);	
	_register64_r rr3(clk, reset_n, 1, sdin1, result_h);
	_register64_result_l rr4(clk, reset_n, 1, sdin2, result_l);
	_register64_r rr5(clk, reset_n, en[4], s_din, operand);
	_register64_r rr6(clk, reset_n, en[3], s_din, intrEn);
	
	//decode
	assign addr = (s_sel == 0) ? 0 : s_addr[5:3];
	write_operation w0(addr, s_wr, en);
	read_operation r0(addr, s_dout, opstart, opclear, opdone, intrEn, operand, result_h, result_l);
	
	//fac
	controller c0(clk, reset_n, mul_op_done, result_h, result_l, opstart, opclear, operand, multiplier, multiplicand, next_opdone, mul_op_start, mul_op_clear);
	multiplier m0(clk, reset_n, multiplier, multiplicand, mul_op_start, mul_op_clear, mul_op_done, {next_result_h, next_result_l});
	
	mux2 mm0(en[0], 1, opclear[0], enable0);
	mux2_64bit mmm0(s_din, 64'b0, opclear[0], sdin0);
	
	mux2_64bit mmm1(next_result_h, 64'b0, opclear[0], sdin1);
	mux2_64bit mmm2(next_result_l, 64'b1, opclear[0], sdin2);
	
	
	assign interrupt = intrEn[0] & opdone[0];
	
endmodule
