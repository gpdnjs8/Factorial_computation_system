module _dff_r_1(clk, reset_n, d, q);   //d flip-flop 

	//input, output reg
	input clk, reset_n; 
	input  d;
	output reg  q; 
	
	always@(posedge clk or negedge reset_n)
	begin
		if(reset_n == 0) q <= 0;
		else q <= d;
	end
	
endmodule
