简单 通过率：18.55%

## 描述

②  请用全加器电路①实现串行进位的4位全加器电路

1位全加器参考代码如下：

```verilog
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
```





### 输入描述：

  input     [3:0] A  ,
  input     [3:0] B  ,
  input        Ci , 

### 输出描述：

  output  wire [3:0] S  ,
  output  wire    Co  