module tb_inc;

reg [31:0] in;
wire [31:0] out;

inc inc_DUT(in,out);

initial begin

	#10 in = 1'b1;
	#10 in = 2'b11;
	#10 in = 3'b101;

	#50 $finish;

end

endmodule
