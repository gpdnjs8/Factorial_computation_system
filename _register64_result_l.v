module _register64_result_l(clk, reset_n, en, d, q);   //d flip-flop 

	//input, output reg
	input clk, reset_n, en;
	input [63:0] d;
	output reg [63:0] q; 
	
	//output q
	always@(posedge clk or negedge reset_n) begin
		if(reset_n == 0) q <= 64'b1;        //reset_n
		else if(en == 0) q <= q;  //op_clear
		else q <= d;
	end
	
endmodule