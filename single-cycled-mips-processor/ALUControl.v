module ALUControl(ALUOp, ALUFn, ALUCtrl);

input [1:0] ALUOp;
input [5:0] ALUFn;

output reg [3:0] ALUCtrl;

always@(ALUOp or ALUFn)
	casex({ALUOp, ALUFn})
		8'b00_xxxxxx : ALUCtrl = 4'b0010; // lw, sw -> add
		8'b01_xxxxxx : ALUCtrl = 4'b0110; // beq -> sub
		8'b10_100000 : ALUCtrl = 4'b0010; // add -> add
		8'b10_100010 : ALUCtrl = 4'b0110; // sub -> sub
		8'b10_100100 : ALUCtrl = 4'b0000; // and -> and
		8'b10_100101 : ALUCtrl = 4'b0001; // or -> or
		8'b10_101010 : ALUCtrl = 4'b0111; // slt -> slt
	endcase
endmodule
