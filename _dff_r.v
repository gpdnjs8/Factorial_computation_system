module _dff_r(clk, reset_n, d, q);   //d flip-flop 

	//input, output reg
	input clk, reset_n; 
	input [1:0] d;
	output reg [1:0] q; 
	
	always@(posedge clk or negedge reset_n)
	begin
		if(reset_n == 0) q <= 0;
		else q <= d;
	end
	
endmodule
