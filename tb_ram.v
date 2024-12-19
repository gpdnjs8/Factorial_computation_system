//ram testbench
module tb_ram;

	reg tb_clk;
	reg tb_cen, tb_wen;
	reg [7:0] tb_s_addr;
	reg [63:0] tb_s_din;
	wire [63:0] tb_s_dout;
	
	ram r0(tb_clk, tb_cen, tb_wen, tb_s_addr, tb_s_din, tb_s_dout);
	
	parameter STEP = 10;
	//clock
	always #(STEP/2) tb_clk = ~tb_clk; 
	
	//test
	initial 
	begin
		tb_clk = 0; tb_cen = 0; tb_wen = 0; tb_s_addr = 5'b00000; tb_s_din = 32'h00001111;
		#11; tb_cen = 1; 
		#11; tb_wen = 1;
		#11; tb_wen = 0;  //read
		#11; tb_wen = 1; tb_s_addr = 5'b00001; tb_s_din = 32'h12345678;
		#11; tb_wen = 0;  //read
		#11; tb_wen = 1; tb_s_addr = 5'b00010; tb_s_din = 32'h10101010;
		#11; tb_wen = 0;  //read
		#11; tb_wen = 1; tb_s_addr = 5'b00100; tb_s_din = 32'h11111111;
		#11; tb_wen = 0;  //read
		#11; tb_cen = 0;  //dout = 0;
		#11; $stop;
	end
endmodule
