module tb_mul14;

reg [31:0] in;
wire [31:0] out;

mul14 mul14_DUT(in,out);

initial begin

	#10 in = 32'b1011;

	#30 in = 32'b101;

	#50 in = 32'b1;

	#90 $finish;

end

endmodule
