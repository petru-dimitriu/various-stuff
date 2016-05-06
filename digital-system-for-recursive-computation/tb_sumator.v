module tb_sumator;

reg [31:0] a;
reg [31:0] b;
wire [31:0] s;

sumator sumator_DUT(a, b, s);

initial begin

	#10 a = 32'b11000; b = 32'b10;

	#40 a = 32'b1; b = 32'b1;

	#60 $finish;
end
endmodule
