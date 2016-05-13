module mux(ina, inb, sel, out);
	parameter DATA_LENGTH = 8;
	input [DATA_LENGTH-1:0] ina;
	input [DATA_LENGTH-1:0] inb;
	input sel;

	output [DATA_LENGTH-1:0] out;
	
	assign out = (sel == 00 ? ina : inb);
				
endmodule
 
