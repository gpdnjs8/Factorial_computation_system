//BUS
module BUS(clk, reset_n, m_req, m_wr, m_addr, m_dout, s0_dout, s1_dout,
				m_grant, m_din, s0_sel, s1_sel, s_addr, s_wr, s_din);

	//input, output
	input clk, reset_n;
	input m_req, m_wr;
	input [15:0] m_addr;
	input [63:0] m_dout;
	input [63:0] s0_dout, s1_dout;
	
	output m_grant;
	output [63:0] m_din;
	output s0_sel, s1_sel;
	output  s_wr;
	output  [15:0] s_addr;
	output  [63:0] s_din;
	
	wire [1:0] ff_out;
	
	//instance
	_dff_r_1 d0(clk, reset_n, m_req, m_grant);
	mux2 U1(1'b0, m_wr, m_grant, s_wr);
	mux2_16bit U2(16'b0, m_addr, m_grant, s_addr);
	mux2_64bit U3(64'b0, m_dout, m_grant, s_din);
	

	//slave select
	bus_addr b1(s_addr, s0_sel, s1_sel);
	_dff_r f0(clk, reset_n, {s1_sel, s0_sel}, ff_out);
	mux3_64bit m3(64'h0, s0_dout, s1_dout, ff_out, m_din);   //
	
endmodule
