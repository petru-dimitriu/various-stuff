module mux(ina, inb, inc, ind, sel, out);

	input [31:0] ina;
	input [31:0] inb;
	input [31:0] inc;
	input [31:0] ind;
	input [1:0] sel;

	output [31:0] out;
	
	assign out = (sel == 2'b00) ? ina : (sel == 2'b01) ? inb : (sel == 2'b10) ? inc : ind;
				
endmodule
 
