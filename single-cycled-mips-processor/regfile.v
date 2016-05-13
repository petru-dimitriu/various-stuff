module regfile(clk, RegWrite, rr1, rr2, wr, wd, rd1, rd2);

input clk;
input [4:0] rr1;
input [4:0] rr2;
input [4:0] wr;
input [31:0] wd; // write data
input RegWrite;
output [31:0] rd1;
output [31:0] rd2;
reg [31:0] registers [31:0];

initial begin
	$readmemh("reg_mem.mem",registers);
end

always @(posedge clk)
begin
if (RegWrite && wr != 0)
	registers[wr] <= wd;
end

assign rd1 = registers[rr1];
assign rd2 = registers[rr2];

endmodule
