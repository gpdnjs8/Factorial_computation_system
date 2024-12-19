//ns_Fac
module ns_Fac(clk, reset_n, s_sel, opstart, opclear, opdone, state, next_state);
	
	//input, output
	input clk, reset_n, s_sel;
	input [63:0] opstart, opclear, opdone;
	input [1:0] state;
	output reg [1:0]next_state;
	
	//state encoding
	parameter INIT = 2'b00;
	parameter OFFS = 2'b01;  //offset calculate
	parameter FACT = 2'b10;  //factorial
	parameter DONE = 2'b11;
	
	//state transition
	always @ (state or opstart or opclear or opdone)
	begin
		case(state)
			INIT: begin
				if(opclear[0] == 1)  next_state <= INIT;   //opclear[0] == 0
				
				else next_state <= OFFS;

			end
			
			OFFS: begin  //
				//if(opclear[0] == 1) next_state <= INIT;
				if(opstart[0] == 1) next_state <= OFFS;
				else next_state <= FACT;
			end
			
			FACT: begin
				if(opdone[0] == 1) next_state <= DONE;
				//else if(opstart[0] == 1) FACT;
				else next_state <= FACT; //recursive
			end
			
			DONE: begin
				if(opclear[0] == 1) next_state <= INIT;  //opclear[0] == 0
			
				else next_state <= OFFS;
			end
			
			default: next_state <= 2'bxx;
		endcase
	end

endmodule
