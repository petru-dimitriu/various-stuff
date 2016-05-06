module control(clk, res, z, wen, wsel, osel, alusel, data);

input clk;
input res;
input z;
output reg wen;
output reg [1:0] wsel;
output reg [1:0] osel;
output reg [1:0] alusel;
input [31:0] data;

// locals
reg [3:0] state_crt;
reg [3:0] state_next;

always@(posedge clk) begin
		if (res == 1'b1)
		begin
			state_crt <= 4'b1111;
		end
		else
			state_crt <= state_next;
end

// SEMNALELE STARII CURENTE!
always @(state_crt) begin
		case ({state_crt})
		4'b1111: begin	wen = 0; end // starea initiala
		4'b0000: begin // b <- 1
		{wen, wsel, osel, alusel} = 9'b1_01_01_00; end
		4'b0001: begin // n <- N
		{wen, wsel, osel, alusel} = 9'b1_10_00_11; end
		4'b0010: begin // n <- n+1
		{wen, wsel, osel, alusel} = 9'b1_10_10_00; end
		4'b0011: begin // a <- a*14
		{wen, wsel, osel, alusel} = 9'b1_00_00_10; end
		4'b0100: begin // a <- a + b
		{wen, wsel, osel, alusel} = 9'b1_00_00_01; end
		4'b0101: begin // b <- b + 1
		{wen, wsel, osel, alusel} = 9'b1_01_01_00; end
		4'b0110: begin // asteptare pt actualiarea b
		{wen, wsel, osel, alusel} = 9'b0_00_00_01; end
		4'b0111: begin // starea finala
		{wen, wsel, osel, alusel} = 9'b0_00_00_01; end 
		endcase
	end

// STAREA URMATOARE!
always @(state_crt or z) begin
	casex ({state_crt,z}) 
		5'b1111_x : begin state_next = 4'b0000; end
		5'b0000_x : begin state_next = 4'b0001; end 
		5'b0001_x : begin state_next = 4'b0010; end 
		5'b0010_x : begin state_next = 4'b0011; end 
		5'b0011_x : begin state_next = 4'b0100; end 
		5'b0100_x : begin state_next = 4'b0101; end 
		5'b0101_x : begin state_next = 4'b0110; end 
		5'b0110_0 : begin state_next = 4'b0011; end
		5'b0110_1 : begin state_next = 4'b0111; end
		5'b0111_x : begin state_next = state_crt; end
		
		default: begin state_next = 4'bzzzz; end
	endcase
end

endmodule
