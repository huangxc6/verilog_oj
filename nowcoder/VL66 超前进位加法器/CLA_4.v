`timescale 1ns/1ns

module huawei8//四位超前进位加法器
(
	input wire [3:0]A,
	input wire [3:0]B,
	output wire [4:0]OUT
);

//*************code***********//
	wire [3 : 0] G ;
	wire [3 : 0] P ;
	wire [3 : 0] F ;
	wire [4 : 0] C ;
	wire Gm ;
	wire Pm ;

	assign C[0] = 1'b0 ;

	genvar i;
	generate
		for (i = 0; i < 4; i = i + 1) begin: u_add
			Add1 u_add1 (
				  .a(A[i]),
				  .b(B[i]),
				  .C_in(C[i]),
				  .f(F[i]),
				  .g(G[i]),
				  .p(P[i])
				  );			
		end
	endgenerate

	CLA_4 u_CLA_4(
		.P(P),
		.G(G),
		.C_in(C[0]),
		.Ci(C[4:1]),
		.Gm(Gm),
		.Pm(Pm)
		);

	assign OUT = {C[4], F} ;


//*************code***********//
endmodule



//////////////下面是两个子模块////////

module Add1
(
		input a,
		input b,
		input C_in,
		output f,
		output g,
		output p
		);
	assign f = a ^ b ^ C_in ;
	assign g = a & b ;
	assign p = a | b ;

endmodule






module CLA_4(
		input [3:0]P,
		input [3:0]G,
		input C_in,
		output [4:1]Ci,
		output Gm,
		output Pm
	);

	assign Ci[1] = G[0] | P[0] & C_in  ;
	assign Ci[2] = G[1] | P[1] & Ci[1] ;
	assign Ci[3] = G[2] | P[2] & Ci[2] ;
	assign Ci[4] = G[3] | P[3] & Ci[3] ;

	assign Gm = G[3] | P[3]&G[2] | P[3]&P[2]&G[1] | P[3]&P[2]&P[1]&G[0] ;
	assign Pm = P[3]&P[2]&P[1]&P[0] ;
	
endmodule