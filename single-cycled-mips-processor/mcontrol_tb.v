module mcontrol_tb;

reg [5:0] Op;
reg RegDst;
reg ALUSrc;
reg MemtoReg;
reg RegWrite;
reg MemRead;
reg MemWrite;
reg Branch;
reg ALUOp1;
 reg ALUOp0;

mcontrol mcontrol_DUT(Op,RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUOp1,ALUOp0);

initial
begin
end

endmodule
