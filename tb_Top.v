`timescale 1ns/100ps
module tb_Top;  //testbench module

	//reg, wire
   reg tb_clk, tb_reset_n, tb_m_req, tb_m_wr;
   reg [15:0] tb_m_addr;
   reg [63:0] tb_m_dout;                     
   wire tb_m_grant, tb_interrupt;
   wire [63:0] tb_m_din;                     
   
	//instance
   Top t0(tb_clk, tb_reset_n, tb_m_req, tb_m_wr, tb_m_addr, tb_m_dout, tb_m_grant, tb_m_din, tb_interrupt);   
   
	//clock
   always begin         
      tb_clk = 1; #5; tb_clk = 0; #5;
   end
   
	//test
   initial begin
     tb_reset_n = 0; tb_m_req = 1; tb_m_wr = 1; tb_m_addr = 16'h7018; tb_m_dout = 64'b1;
     #5;   tb_reset_n = 1;
     #20;   tb_m_addr = 16'h7020;                             
     #10;   tb_m_addr = 16'h7000;
     #10;   tb_m_addr = 16'h7030; tb_m_wr = 0;
     #50;   tb_m_addr = 16'h7020; tb_m_dout = 64'd10; tb_m_wr = 1;   
     #10;   tb_m_addr = 16'h7008; tb_m_dout = 64'b1;
     #10;   tb_m_dout = 64'b0;
     #10;   tb_m_addr = 16'h7000; tb_m_dout = 64'b1;
     #20;   tb_m_addr = 16'h7030; tb_m_wr = 0;
     #1000; tb_m_addr = 16'h7020; tb_m_dout = 64'd50; tb_m_wr = 1;   
     #10;   tb_m_addr = 16'h7008; tb_m_dout = 64'b1;
     #10;   tb_m_dout = 64'b0;
     #10;   tb_m_addr = 16'h7000; tb_m_dout = 64'b1;
     #20;   tb_m_addr = 16'h7030; tb_m_wr = 0;
     #50000; $stop;
   end
   
endmodule
