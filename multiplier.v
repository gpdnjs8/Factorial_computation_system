
module multiplier(clk, reset_n, multiplier, multiplicand, op_start, op_clear, op_done, result);

	//input, output
	input clk, reset_n, op_start, op_clear;
	input [63:0] multiplier, multiplicand;
	output  op_done;
	output [127:0] result;
	
	//wire
	wire [1:0] next_st, curr_st;
	wire [63:0] st_count, en_count;
	wire [127:0] c_result;
	
	//instance
	_register2_r r0(clk, reset_n, op_clear, next_st, curr_st);     //state
	_register64_r_cl r1(clk, reset_n, op_clear, en_count, st_count);  //count
	ns_logic n0(st_count, en_count, op_start, op_clear, curr_st, next_st);  //next state logic
	c_logic c0(clk, multiplier, multiplicand, next_st, c_result, op_done);	//calculate

	assign result = c_result;  //result

endmodule
