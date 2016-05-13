module ALUControl_tb;

reg[1:0] ALUOp;
reg[5:0] ALUFn;
wire[3:0] ALUCtrl;

ALUControl ALUControl_DUT(ALUOp,ALUFn,ALUCtrl);

initial begin
	
	#10 ALUOp = 2'b00;
	ALUFn = 6'b00;

	#20 ALUOp = 2'b01;
	 ALUFn = 6'b01;

	#30 ALUOp = 2'b10;
	ALUFn = 6'b100000;

	#40 ALUOp = 2'b10;
	ALUFn = 6'b100010;

	#50 ALUOp = 2'b10;
	ALUFn = 6'b100101;

	#100 $finish;
end

endmodule
