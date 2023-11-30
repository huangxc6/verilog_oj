简单 通过率：27.69%

## 描述

①  请用题目提供的半加器实现全加器电路①

半加器的参考代码如下，可在答案中添加并例化此代码。

```verilog
module add_half(
   input                A   ,
   input                B   ,
 
   output   wire        S   ,
   output   wire        C   
);

assign S = A ^ B;
assign C = A & B;
endmodule
```





### 输入描述：

  input        A  ,
  input        B  ,
  input        Ci , 

### 输出描述：

  output  wire    S  ,
  output  wire    Co  