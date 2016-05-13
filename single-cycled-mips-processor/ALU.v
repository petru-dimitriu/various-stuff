module ALU(clk,a, b, sel, dout, zero);

input [31:0] a, b;
input [3:0] sel;
input clk;
output [31:0] dout;
output zero;

assign dout = (sel == 4'b0010 ? a + b : a - b);

assign zero = (dout == 0 ? 1 : 0);

endmodule
