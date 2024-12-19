module _register3_r(clk, reset_n, op_clear, d, q);   //d flip-flop 

	//input, output reg
	input clk, reset_n, op_clear;
	input [2:0] d;
	output reg [2:0] q; 
	
	//output q
	always@(posedge clk or negedge reset_n or posedge op_clear)
	begin
		if(reset_n == 0) q <= 3'b0;        //reset_n
		else if(op_clear == 1) q <= 3'b0;  //op_clear
		else q <= d;
	end
	
endmodule
