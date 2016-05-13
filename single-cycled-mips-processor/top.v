module top(clk, res);

input clk, res;

wire [31:0] PCin, PCout;
wire [31:0] MemOut;
wire [31:0] ReadData1, ReadData2;
wire [4:0] WriteRegister;
wire [31:0] WriteData;
wire [31:0] SignExtendOut;
wire [3:0] ALUCtrl;
wire [31:0] Mux2Out;
wire [31:0] ALUOut, DataMemoryOut;
wire [31:0] SumatorSusOut;
wire [31:0] Sumator4Out;
wire Zero;

// fire care pornesc de la control
wire RegDst, Branch, MemRead, MemtoReg, ALUOp1, ALUOp0, MemWrite, ALUSrc, RegWrite;
// ------------------------------

// calea de control
mcontrol CONTROL_PATH(MemOut[31:26],RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUOp1,ALUOp0);
// program counter
reg32 PC(clk, res, 1'b1, PCin, PCout);
// instruction memory
memory INSTRUCTION_MEMORY (clk, PCout, 1'b0, 32'b0, MemOut);
// mux-ul dintre instruction memory si bancul de registre
mux #(5) MUX1 (MemOut[20:16],MemOut[15:11], RegDst, WriteRegister);
// bancul de registre
regfile REGISTERS(clk, RegWrite, MemOut[25:21], MemOut[20:16], WriteRegister, WriteData, ReadData1, ReadData2);
// sign extend
signextend SIGN_EXTEND(MemOut[15:0],SignExtendOut);
// ALUcontrol
ALUControl ALU_CONTROL({ALUOp1,ALUOp0},MemOut[5:0], ALUCtrl);
// mux dintre banc si ALU de jos
mux #(32) MUX2 (ReadData2,SignExtendOut,ALUSrc,Mux2Out);
// ALU de jos
ALU ALU1(clk,ReadData1, Mux2Out, ALUCtrl, ALUOut, Zero);
// memoria de date
datamemory DATA_MEMORY(clk,ALUOut,MemWrite,MemRead,ReadData2,DataMemoryOut);
// mux din dreapta jos
mux #(32) MUX3(ALUOut,DataMemoryOut,MemtoReg,WriteData);
// sumator cu 4 din stanga sus
sumator sumator4(PCout,32'b1,Sumator4Out);
// ALU din dreapta sus
sumator SumatorSus(Sumator4Out,SignExtendOut,SumatorSusOut);
// mux din dreapta sus
mux #(32) MUX4(Sumator4Out,SumatorSusOut,Branch & Zero, PCin);

endmodule

