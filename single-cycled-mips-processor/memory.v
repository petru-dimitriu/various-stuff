module memory(clk,address,wen,din,dout);
input clk;
input [31:0] address;
input wen;
input [31:0] din;
output [31:0] dout;

reg [31:0] registers[255:0];

initial
begin
	$readmemh("mem_code_hex.mem",registers,0);
end

always @(posedge clk)
begin
    if (wen)
        registers[address] <= din;
end

assign dout = wen ? din : registers[address];

endmodule
