module tb_dec;

reg [1:0] in;
reg en;
wire out0, out1, out2, out3;

dec dec_DUT(en,in,out0,out1,out2,out3);

initial begin
	en = 1;
	#10 in = 2'b0;
	#10 in = 2'b1;
	#10 in = 2'b10;
	#10 in = 2'b11;
	#50 $finish;
end

endmodule
