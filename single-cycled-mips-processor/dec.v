module dec(en, in, out0, out1, out2, out3);
input [1:0] in;
input en;
output out0;
output out1;
output out2;
output out3;

assign out0 = (en && (in == 2'b0));
assign out1 = (en && (in == 2'b1));
assign out2 = (en && (in == 2'b10));
assign out3 = (en && (in == 2'b11));

endmodule
