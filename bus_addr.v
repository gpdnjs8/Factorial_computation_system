//bus address decoder
module bus_addr(s_addr, s0_sel, s1_sel);
	
	//input, output
	input [15:0] s_addr;
	output reg s0_sel, s1_sel;
	
	wire [4:0] upper_bit0 = s_addr[15:11];
	wire [6:0] upper_bit1 = s_addr[15:9];
	
	always @ (upper_bit0 or upper_bit1) begin
		if(upper_bit0 == 5'b00000) {s0_sel, s1_sel} = 2'b10;
		else if(upper_bit1 == 7'b0111000) {s0_sel, s1_sel} = 2'b01;
		else {s0_sel, s1_sel} = 2'b00;
	end
	
endmodule
