module shiftleft2(din, dout);

input [31:0] din;
output [31:0] dout;

assign dout = {din[29:0],2'b00};

endmodule
