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

wire c_1;
wire c_2;
wire sum_1;

add_half add_half_1(
   .A   (A),
   .B   (B),
         
   .S   (sum_1),
   .C   (c_1)  
);
add_half add_half_2(
   .A   (sum_1),
   .B   (Ci),
         
   .S   (S),
   .C   (c_2)  
);

assign Co = c_1 | c_2;
endmodule

module add_4(
   input         [3:0]  A   ,
   input         [3:0]  B   ,
   input                Ci  , 

   output	wire [3:0]  S   ,
   output   wire        Co   
);
    wire [4:0] c_tmp     ;

    assign     c_tmp[0] = Ci ;
    assign     Co = c_tmp[4] ;

    genvar i;
    generate
        for (i = 0 ; i < 4 ; i = i + 1) begin
            add_full u_add_full(
                .A  (A[i]       ),
                .B  (B[i]       ),
                .Ci (c_tmp[i]   ),
                .S  (S[i]       ),
                .Co (c_tmp[i+1] )
            );
        end
    endgenerate

endmodule