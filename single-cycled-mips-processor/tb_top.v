module tb_top;

reg clk, res;

top top_DUT(clk, res);

always #5 clk = ~clk;

initial
begin
	#5 clk = 0; res = 1;

	#15 res = 0;

	#1500 $finish;

	
end

endmodule
