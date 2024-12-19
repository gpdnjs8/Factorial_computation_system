//tb_BUS
`timescale 1ns/100ps
module tb_BUS;  //testbench module

	//reg, wire
	reg tb_clk, tb_reset_n;
	reg tb_m_req, tb_m_wr;
	reg [15:0] tb_m_addr;
	reg [63:0] tb_m_dout;
	reg [63:0] tb_s0_dout, tb_s1_dout;
	
	wire tb_m_grant;
	wire [63:0] tb_m_din;
	wire tb_s0_sel, tb_s1_sel;
	wire  tb_s_wr;
	wire  [15:0] tb_s_addr;
	wire  [63:0] tb_s_din;
	
	//instance
	BUS b0(tb_clk, tb_reset_n, tb_m_req, tb_m_wr, tb_m_addr, tb_m_dout, tb_s0_dout, tb_s1_dout,
				tb_m_grant, tb_m_din, tb_s0_sel, tb_s1_sel, tb_s_addr, tb_s_wr, tb_s_din);
				
	parameter STEP = 10;
	//clock 
	always #(STEP/2) tb_clk = ~tb_clk;
	
	//test
	initial 
	begin
		tb_clk = 0; tb_reset_n = 0; 
		tb_m_req = 0; tb_m_wr = 0; tb_m_addr = 8'h0; tb_m_dout = 32'h0;
		tb_s0_dout = 32'h0; tb_s1_dout = 32'h0;
		#8; tb_reset_n = 1; tb_s0_dout = 32'h0; tb_s1_dout = 32'h1;
		#8; tb_m_req = 1; tb_m_wr = 1; tb_m_addr = 8'h11; tb_m_dout = 32'h00000011;
		#10; tb_m_addr = 8'h33; tb_m_dout = 32'h00000033;
		#10; tb_s0_dout = 32'h6; tb_s1_dout = 32'h7;
		#10; tb_m_req = 0; tb_m_wr = 0; 
		#10; tb_s0_dout = 32'h8; tb_s1_dout = 32'h9;
		#10; 
		#10; $stop;
	end	
endmodule
