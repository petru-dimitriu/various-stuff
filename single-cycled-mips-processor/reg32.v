module reg32(clk, res, pl, din, dout);
	input clk, res;
	input [31:0] din;
	input pl;

	output [31:0] dout; 
	reg [31:0] dout;

	always@(posedge clk) begin
		if (res==1'b1)
			dout <= 32'b0;
		else 
			if (pl==1'b1) begin
			dout <= din;
			end
	end
	
endmodule

