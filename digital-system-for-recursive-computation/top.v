module top(clk, res, din, out, ready);

input [31:0] din;
input res;
input clk;
output wire [31:0] out;
output wire ready;

wire d0, d1, d2, d3;
wire [31:0] a_out;
wire [31:0] b_out;
wire [31:0] n_out;
wire [31:0] last_op_out;
wire [31:0] inc_out;
wire [31:0] sum_out;
wire [31:0] mul14_out;
wire [31:0] operator;
wire [1:0] wsel;
wire [1:0] osel;
wire [1:0] bsel;
wire [1:0] alusel;
wire wen;

dec decodor(wen,wsel,d0,d1,d2,d3);

reg32 rega(.clk(clk), .pl(d0), .din(last_op_out), .dout(a_out), .res(res));
reg32 regb(.clk(clk), .pl(d1), .din(last_op_out), .dout(b_out), .res(res));
reg32 regn(.clk(clk), .pl(d2), .din(last_op_out), .dout(n_out), .res(res));

assign out = a_out;

mux mux1(.ina(a_out), .inb(b_out), .inc(n_out), .ind(0), .sel(osel), .out(operator));
// optimizare!!! fara mux2
//mux mux2(.ina(a_out), .inb(b_out), .inc(n_out), .ind(0), .sel(bsel), .out(b_out));

inc inc1 (.in(operator), .out(inc_out));
sumator sumator1 (.a(operator), .b(b_out), .s(sum_out));
mul14 multiplicator11 (.in(operator), .out(mul14_out));
cmp comparator(.a(b_out),.b(n_out), .eq(ready));

mux op_mux(.ina(inc_out), .inb(sum_out), .inc(mul14_out), .ind(din), .sel(alusel), .out(last_op_out));

control controller(clk, res, ready, wen, wsel, osel, alusel, din);

endmodule
