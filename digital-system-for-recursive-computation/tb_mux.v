module tb_mux;

reg [31:0] ina;
reg [31:0] inb;
reg [31:0] inc;
reg [31:0] ind;
wire [31:0] out;
reg [1:0] sel;

mux mux_DUT(ina, inb, inc, ind, sel, out);

initial begin

	#10 ina = 32'd15;
	inb = 32'd20;
	inc = 32'd25;
	ind = 32'd7;
	sel = 0;

	#10 sel = 1;
	#10 sel = 2;
	#10 sel = 3;

	#100 $finish;

end

endmodule
