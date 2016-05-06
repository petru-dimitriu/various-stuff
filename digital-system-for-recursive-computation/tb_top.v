module tb_top;

reg clk;
reg [31:0] in;
wire [31:0] out;
reg res;
wire ready;

always #5 clk = ~clk;

top top_DUT(clk,res,in,out,ready);

initial begin
	clk = 0;

	#10 res = 1 ; in = 4'b0100;
	#20 res = 0 ; 
	
	#600 $finish;
end

endmodule
