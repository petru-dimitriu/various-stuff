module tb_reg32;

reg clk;
reg res;
reg pl;
reg [31:0] din;
wire [31:0] dout;

reg32 reg32_DUT(clk, res, pl, din, dout);

always #5 clk = ~clk;

initial begin
	res = 1; clk = 0;
	
	#10 res = 0; pl = 1; din = 32'd777;

	#50 $finish;

end

endmodule
