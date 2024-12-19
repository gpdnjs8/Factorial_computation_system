//bus arbiter
module bus_arbit(clk, reset_n, m_req, m_grant);
	
	//input, output
	input clk, reset_n, m_req;
	output reg m_grant;

	always @ (posedge clk or negedge reset_n) begin
		if(!reset_n) begin
			m_grant <= 0;
		end
		else if(m_req == 1) m_grant <= 1;
		else if(m_req == 0) m_grant <= 0;
	end
endmodule
