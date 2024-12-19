//c_Fac
module c_Fac(clk, reset_n, s_wr, s_addr, state, s_din, s_dout, opstart, opclear, opdone, interrupt, result_h, result_l); 
	
	//input, output
	input clk, reset_n;
	input s_wr;
	input [15:0] s_addr;
	input [63:0] s_din;
	input [1:0] state;
	
	output reg [63:0] s_dout;
	output reg interrupt;
	output reg [63:0] opstart, opclear, opdone;
	output reg [63:0] result_h, result_l;
	
	reg [63:0] intrEn, operand; 
	reg [63:0] copyoperand, multi, multiplicand;
	reg [2:0] offset;   
	wire [127:0] result;  //result
	reg [127:0] result_copy;
	
	reg [1:0] next_state2;
	wire [1:0] state2;
	
	//state encoding
	parameter INIT = 2'b00;
	parameter OFFS = 2'b01;
	parameter FACT = 2'b10;
	parameter DONE = 2'b11;
	
	//state encoding
	parameter INIT2 = 2'b00;
	parameter FACT2 = 2'b01;
	parameter DONE2 = 2'b10;
	
	
	reg op_start_m, op_clear_m;
	wire op_done_m;
	
	//multiplier instance
	multiplier m0(clk, reset_n, multi, multiplicand, op_start_m, op_clear_m, op_done_m, result);
	_register2_r r0(clk, reset_n, , next_state2, state2);
	
	always @ (state, s_wr, s_addr, state2, copyoperand, op_done_m, operand)
	begin
		
		if(!reset_n) begin
			opstart <= 64'd0;
			opclear <= 64'd0;
			opdone <= 64'd0;
			intrEn<= 64'd0;
			operand <= 64'd0;
			result_h <= 64'd0;
			result_l <= 64'd1;
		end
		else begin
			case(state)
				INIT: begin
					opstart <= 64'd0;
					//opclear <= 64'd0;
					opdone <= 64'd0;
					//intrEn<= 64'd0;
					//operand <= 64'd0;
					result_h <= 64'd0;
					result_l <= 64'd1;
					next_state2 <= 2'b00;
				end
				
				OFFS: begin  //mod order
						offset = s_addr[5:3];   //mod
						if(s_wr == 1'b1) begin 
							if(offset == 3'b000) opstart <= s_din;
							else if(offset == 3'b001) opclear <= s_din;
							else if(offset == 3'b011) intrEn <= s_din;
							else if(offset == 3'b100) operand <= s_din;
						end
						else begin
							if(offset == 3'b010) s_dout <= opdone;
							else if(offset == 3'b101) s_dout <= result_h;
							else if(offset == 3'b110) s_dout <= result_l;
						end
				end
				
				//tnwjd
				FACT: begin  //copy -> operand
					case(state2)
						INIT2: begin
							if(operand == 64'h0) begin  //0!, 1!  //|| operand == 64'd1
								
								result_h = 64'd0;
								result_l = 64'd1;
								opdone[1:0] = 2'b11;
								//next_state2 <= DONE2;
							end
							else begin
								opdone[1] = 1;
								result_l = 64'd1;
							
								multi = result_l;
								multiplicand = operand;
								next_state2 <= FACT2;
							end
						end
						
						FACT2: begin
							
							if(operand > 1) begin
								op_clear_m = 1'b0;
								op_start_m = 1'b0;
								
								if(result_l == 64'd0) begin  //예외처리
									multi = result_h;
								end
								else begin
									multi = result_l;
								end
								
								multiplicand = operand;
								op_start_m = 1'b1;
							
								if(op_done_m == 1) begin
									result_copy = result;
									result_h = result_copy[127:64];
									result_l = result_copy[63:0];
									op_start_m = 0;
									operand = operand - 1;	
									op_clear_m = 1;
									
									next_state2 <= FACT2;
								end
							
							end
							
							else begin
								next_state2 = DONE2;
							end
							
						end
						
						
						DONE2: begin
							opdone[0] = 1;
						end
					endcase
				end
				
				DONE: begin  //interrupt
					opstart = 64'd0; //mod
					
					if(intrEn[0] == 1) interrupt <= 1;    //&&opdone[0] == 1 
					else if(intrEn[0] == 0) interrupt <= 0;
				end
			endcase
			end
		end
	
endmodule
