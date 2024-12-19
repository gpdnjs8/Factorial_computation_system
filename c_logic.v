//calculate
module c_logic(clk, multiplier, multiplicand, next_state, c_result, op_done);

	//input, output
	input clk;
	input [63:0] multiplicand, multiplier;
	input [1:0] next_state;

	output reg [127:0] c_result;
	output reg op_done;
	
	//reg, wire
	reg [63:0] u, v, x;
	reg x_1;
	wire [63:0] add_result, sub_result;
	wire [1:0] booth = {x[0], x_1};
	
	//state encoding
	parameter INIT = 2'b00;
	parameter MULT = 2'b01;
	parameter DONE	= 2'b10;
	
	//booth multiplication state encoding
	parameter shiftonly = 2'b00;
	parameter shiftonly2 = 2'b11;
	parameter addshift = 2'b01;
	parameter subshift = 2'b10;
	
	wire [63:0] a;
	assign a = multiplicand;
	//add and sub using CLA
	cla64 c0(u, a, 1'b0, add_result, );   //add
	cla64 c1(u, ~a, 1'b1, sub_result, );  //sub
	
	//calculate state
	always @ (posedge clk)
	begin
		case(next_state)
			INIT : begin  //initial
				u = 64'b0;
				v = 64'b0;
				x = multiplier;
				x_1 = 0;
				c_result = 128'b1;
				op_done = 0;
				end
				
			MULT : begin
				case(booth)
				//shift only
				shiftonly, shiftonly2 : begin											
					x_1 = x[0];
					x[62:0]  = x[63:1]; 										
					x[63] = x_1;
					v[62:0] = v[63:1];
					v[63] = u[0];
					u[62:0] = u[63:1];											
					u[63] = u[62];
				end
				
				//add and shift
				addshift : begin											
					u = add_result;
					x_1 = x[0];
					x[62:0]  = x[63:1]; 										
					x[63] = x_1;
					v[62:0] = v[63:1];
					v[63] = u[0];
					u[62:0] = u[63:1];											
					u[63] = u[62];
				end
				
				//subtract and shift
				subshift : begin											
					u = sub_result;
				   x_1 = x[0];
					x[62:0]  = x[63:1]; 										
					x[63] = x_1;
					v[62:0] = v[63:1];
					v[63] = u[0];
					u[62:0] = u[63:1];											
					u[63] = u[62];
				end
				endcase
				op_done = 0;  
			end
				
			DONE : begin
				c_result = ({u, v} == 128'b0) ? 128'b1 : {u, v};
				op_done = 1;  //set op_done = 1
				
			end
			
			//default
			default : begin
				u = 64'bx;
				v = 64'bx;
				x = 64'bx;
				x_1 = 1'bx;
				c_result = 128'b0;
				op_done = 1'bx;
			end
		endcase
	end
endmodule
