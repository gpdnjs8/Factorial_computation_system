`timescale 1ns/100ps
module tb_FactoCore;  //testbench module

	//reg, wire
   reg tb_clk, tb_reset_n, tb_s_sel, tb_s_wr;
   reg [15:0] tb_s_addr;
   reg [63:0] tb_s_din;              
   
   wire [63:0] tb_s_dout;
   wire tb_interrupt;              
   
	//instance
   FactoCore f0(tb_clk, tb_reset_n, tb_s_sel, tb_s_wr, tb_s_addr, tb_s_din, tb_s_dout, tb_interrupt);  
   
	//clock
   always begin                 
      tb_clk = 1; #5; tb_clk = 0; #5;
   end
   
	//test
   initial begin
     tb_reset_n = 0; tb_s_sel = 1; tb_s_wr = 1; tb_s_addr = 16'h7020; tb_s_din = 64'd72;
     #5;  tb_reset_n = 1;
     #10; tb_s_addr = 16'h7000; tb_s_din = 1;
     #10; tb_s_addr = 16'h7018;
     #10; tb_s_wr = 0; tb_s_addr = 16'h7030;
     #50000; $stop;
   end
	
endmodule
