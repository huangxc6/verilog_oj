`timescale 1ns/1ns

module add_half(
   input                A   ,
   input                B   ,
 
   output	wire        S   ,
   output   wire        C   
);

assign S = A ^ B;
assign C = A & B;
endmodule

/***************************************************************/
module add_full(
   input                A   ,
   input                B   ,
   input                Ci  , 

   output	wire        S   ,
   output   wire        Co   
);
    wire S_tmp  ; // A ^ B
    wire C_tmp1 ; // A & B
    wire C_tmp2 ; // (A ^ B) & Ci

    add_half u1_add_half (
        .A(A)       ,
        .B(B)       ,
        .S(S_tmp)   ,
        .C(C_tmp1)
    );

    add_half u2_add_half (
        .A(S_tmp)   ,
        .B(Ci)      ,
        .S(S)       ,
        .C(C_tmp2)
    );

    assign Co = C_tmp1 || C_tmp2 ;

endmodule