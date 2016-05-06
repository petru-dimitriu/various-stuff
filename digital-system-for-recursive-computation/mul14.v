module mul14(in,out);
input [31:0] in;
output [31:0] out;

reg state_crt;
reg state_next;

assign out = (in << 1) + (in << 2) + (in << 3);

endmodule
