//
module hhh(s_addr, addr);
	
	//input, output
	input [15:0] s_addr;
	output reg [2:0] addr;
	
	always @ (s_addr) begin
		addr = s_addr[5:3];
	end
	
	
endmodule

module FactoDecode(s_sel, s_addr, addr);   //Factorial Core address decode module
   input s_sel;
   input [15:0] s_addr;               //input define
   output reg [2:0] addr;            //output define
   
   always @(s_addr, s_sel) begin      //address decode
      if (s_sel == 1'b0) addr = 3'b0;
      else if (16'h7000 <= s_addr && s_addr < 16'h7008) addr = 3'b000;
      else if (16'h7008 <= s_addr && s_addr < 16'h7010) addr = 3'b001;
      else if (16'h7010 <= s_addr && s_addr < 16'h7018) addr = 3'b010;
      else if (16'h7018 <= s_addr && s_addr < 16'h7020) addr = 3'b011;
      else if (16'h7020 <= s_addr && s_addr < 16'h7028) addr = 3'b100;
      else if (16'h7028 <= s_addr && s_addr < 16'h7030) addr = 3'b101;
      else if (16'h7030 <= s_addr && s_addr < 16'h7038) addr = 3'b110;
      else addr = 3'bx;
   end
endmodule
