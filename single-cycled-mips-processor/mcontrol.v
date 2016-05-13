module mcontrol(Op,RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUOp1,ALUOp0);

input[5:0] Op;
output reg RegDst;
output reg ALUSrc;
output reg MemtoReg;
output reg RegWrite;
output reg MemRead;
output reg MemWrite;
output reg Branch;
output reg ALUOp1;
output reg ALUOp0;

always @(Op)
casex (Op)
	6'b000000: {RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp0} = 9'b100100010; 
	6'b100011: {RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp0} = 9'b011110000;
	6'b101011: {RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp0} = 9'b010001000; // bx1x001000
	6'b000100: {RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp0} = 9'b000000101; // bx0x000101
	default: $display("Nu ar trebui sa ajung aici!");
endcase

endmodule
