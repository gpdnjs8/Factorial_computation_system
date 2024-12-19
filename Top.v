//Top
module Top(clk, reset_n, m_req, m_wr, m_addr, m_dout, m_grant, m_din, interrupt);
	
	//input, output
	input clk, reset_n;
	input m_req, m_wr;
	input [15:0] m_addr;
	input [63:0] m_dout;
	output m_grant;
	output [63:0] m_din;
	output interrupt;
	
	wire [63:0] s0_dout, s1_dout, s_din;
	wire s0_sel, s1_sel, s_wr;
	wire [15:0] s_addr;

	//instance(BUS, ram, FactoCore)
	BUS b0(clk, reset_n, m_req, m_wr, m_addr, m_dout, s0_dout, s1_dout,
				m_grant, m_din, s0_sel, s1_sel, s_addr, s_wr, s_din);
				
	ram r0(clk, s0_sel, s_wr, s_addr[10:3], s_din, s0_dout);	
	FactoCore f0(clk, reset_n, s1_sel, s_wr, s_addr, s_din, s1_dout, interrupt);

endmodule
