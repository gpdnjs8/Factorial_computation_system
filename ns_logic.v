//next state logic
module ns_logic(count, next_count, op_start, op_clear, state, next_state);

	//input, output
	input [63:0] count;
	output reg [63:0] next_count;
	input op_start, op_clear;
	input [1:0] state;
	output reg [1:0] next_state;
	
	//state encoding
	parameter INIT = 2'b00;
	parameter MULT = 2'b01;
	parameter DONE = 2'b10;
	
	//state transition
	always @ (count or op_start or op_clear or state)
	begin
		case(state)
			INIT: begin  //initial state
				next_count = 64'b0;
				if((op_start == 1) && (op_clear == 0)) begin
					next_count = 64'b1;  //count up
					next_state = MULT;
				end
				else next_state = INIT;
			end
			
			MULT: begin  //calculate state
				if(op_clear == 1) next_state = INIT;
				else if(count[63] == 1) next_state = DONE;
				else next_state = MULT;
				//count shift
				next_count = {count[62:0], count[63]};
			end
			
			DONE: begin   //done state
				if(op_clear == 1) next_state = INIT;
				else next_state = DONE;
				next_count = 64'b0;
			end
			
			//default
			default: begin
				next_count = 64'bx;
				next_state = 2'bxx; 
			end
		endcase
	end
	
endmodule
