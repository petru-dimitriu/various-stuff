module tb_control;

reg clk, res, z;
wire wen;
wire [1:0] wsel;
wire [1:0] osel;
wire [1:0] alusel;
wire [31:0] data;

control mycontrol(clk, res, z, wen, wsel, osel, alusel, data);

always #5 clk = ~clk;

initial begin
	clk = 0; res = 1; z = 0;

	#10 res = 0;

	#100 $finish;
end

endmodule
