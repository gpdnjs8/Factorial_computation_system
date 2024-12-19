module controller(clk, reset_n, mul_op_done, result_h, result_l, opstart, opclear, operand, multiplier, multiplicand, next_opdone, mul_op_start, mul_op_clear);
	
	//input, output
	input clk, reset_n, mul_op_done;
	input [63:0] result_h, result_l, opstart, opclear, operand;
	
	output  reg[63:0] next_opdone;
	output [63:0] multiplier, multiplicand;
	output  mul_op_start, mul_op_clear;
	
	reg [2:0] next_state;
	wire [2:0] state;
	
	reg next_op_start, next_op_clear;
	reg [63:0] next_multiplier, next_multiplicand;
	
	 _dff_r_1 r22(clk, reset_n, next_op_start, mul_op_start); 
	 _dff_r_1 r33(clk, reset_n, next_op_clear, mul_op_clear); 
	 _register64_r r44(clk, reset_n, 1, next_multiplier, multiplier);
	 _register64_r r66(clk, reset_n, 1, next_multiplicand, multiplicand);
	 _register3_r r0(clk, reset_n, 0, next_state, state);
	
	//state encoding
	parameter INIT = 3'b000;
	parameter START = 3'b001;
	parameter FACT = 3'b010;
	parameter CLEAR = 3'b011;
	parameter RESU = 3'b100;
	parameter DONE = 3'b101;
	
	//calculate logic
	always @ (*) begin
		case(state)
			INIT: begin
				next_op_start = 0;
				next_op_clear = 1;
				next_opdone = 0;
				next_multiplier = 0;
				next_multiplicand = 0;
			end
			
			START: begin
				next_multiplier = operand;
				next_multiplicand = operand - 1;
				next_op_start = 0;
				next_op_clear = 0;
				next_opdone = 2;
			end
			
			FACT: begin
				next_multiplier = (result_l == 64'b0) ? result_h : result_l;
				next_multiplicand = multiplicand;
				next_op_start = 1;
				next_op_clear = 0;
				next_opdone = 2;
			end
			
			CLEAR: begin
				next_multiplier = multiplier;
				next_multiplicand = multiplicand;
				next_op_start = 0;
				next_op_clear = 1;
				next_opdone = 2;
			end
			
			RESU: begin
				next_multiplier = (result_l == 64'b0) ? result_h : result_l;
				next_multiplicand = multiplicand - 1;
				next_op_start = 0;
				next_op_clear = 0;
				next_opdone = 2;
			end
			
			
			DONE: begin
				next_multiplier = multiplier;
				next_multiplicand = multiplicand;
				next_op_start = 0;
				next_op_clear = 0;
				next_opdone = 3;
			end
		endcase
	end
	
	//next state logic
	always @ (*) begin
		case(state)
			INIT: begin
				if(opclear[0] == 1) next_state <= INIT;
				else if(opstart[0] == 1 && (operand == 1 || operand == 0)) next_state <= DONE;
				else if(opstart[0] == 1) next_state <= START;
				else next_state <= INIT;
			end
			
			START: begin
				if(opclear[0] == 1) next_state <= INIT;
				else next_state <= FACT;
			end
			
			FACT: begin
				if(opclear[0] == 1) next_state <= INIT;
				else if(mul_op_done == 1 && next_multiplicand == 1) next_state <= DONE;
				else if(mul_op_done == 1) next_state <= CLEAR;
				else next_state <= FACT;
			end
			
			CLEAR: begin
				if(opclear[0] == 1) next_state <= INIT;
				else next_state <= RESU;
			end
			
			RESU: begin
				if(opclear[0] == 1) next_state <= INIT;
				else next_state <= FACT;
			end
			
			DONE: begin
				if(opclear[0] == 1) next_state <= INIT;
				else next_state <= DONE;
			end
		endcase
	end
endmodule
