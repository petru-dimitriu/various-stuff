module tb_cmp;

reg [31:0] a;
reg [31:0] b;
wire r;

cmp cmp_DUT(a, b, r);

initial begin
	#10 a = 5;
	#20 b = 5;

	#30 a = 6;
	#40 b = 5;

	#60 $finish;
end

endmodule
