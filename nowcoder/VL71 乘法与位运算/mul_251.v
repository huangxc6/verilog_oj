module mul_251 (
	input [7:0] A ,
	
	output wire [15:0] B 
);
	// 1111_1011 = 1_0000_0000 - 1 - 0100
	assign B = (A << 8) - (A << 2) - A;
	
endmodule