
module _register64_r(clk, reset_n, en, d, q);   //d flip-flop 

	//input, output reg
	input clk, reset_n, en;
	input [63:0] d;
	output reg [63:0] q; 
	
	//output q
	always@(posedge clk or negedge reset_n) begin
		if(reset_n == 0) q <= 64'b0;        //reset_n
		else if(en == 0) q <= q;  //en
		else q <= d;
	end
	
endmodule


module _register64_r_cl(clk, reset_n, clear, d, q);   //d flip-flop 

	//input, output reg
	input clk, reset_n, clear;
	input [63:0] d;
	output reg [63:0] q; 
	
	//output q
	always@(posedge clk or negedge reset_n) begin
		if(reset_n == 0) q <= 64'b0;        //reset_n
		else if(clear == 1) q <= 64'b0;  //clear
		else q <= d;
	end
	
endmodule
