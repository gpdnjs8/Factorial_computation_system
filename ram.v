//Memory(RAM)
module ram(clk, cen, wen, s_addr, s_din, s_dout);
	
	//input, output
	input clk;
	input cen, wen;
	input [7:0] s_addr;
	input [63:0] s_din;
	output reg [63:0] s_dout;
	
	reg [63:0] mem [0:255];  //256
	integer i;
	
	//memory initialization
	initial begin
	for(i = 0; i < 256 ; i = i + 1)
		mem[i] = 64'b0;
	end
	
	//read, write performance
	always @ (posedge clk)
	begin
		if((cen == 1) && (wen == 1)) begin
			mem[s_addr] <= s_din;
			s_dout = 64'b0;
		end
		else if ((cen == 1) && (wen == 0)) s_dout = mem[s_addr];
		else if (cen == 0) s_dout = 64'b0;
	end
	
endmodule
