module datamemory(clk,address,MemWrite,MemRead,din,dout);
input clk;
input [31:0] address;
input MemWrite, MemRead;
input [31:0] din;
output [31:0] dout;

reg [31:0] registers[255:0];

initial begin
$readmemh("data_mem_hex.mem",registers);
end
/*
always @(posedge clk)
begin
	if (MemWrite)
	        registers[address] <= din;
	if (MemRead)
		dout <= registers[address];
    end
*/

always @(posedge clk)
begin
	if (MemWrite)
		registers[address] = din;
end

assign dout = registers[address];

endmodule
