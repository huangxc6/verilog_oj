较难 通过率：14.42%

## 描述

实现4bit无符号数流水线乘法器设计。

 电路的接口如下图所示。

![img](https://dev-private-public.oss-cn-hangzhou.aliyuncs.com/images/20220222/110_1645532119945/C00B57557743E709B8B96933432E0DFA)



### 输入描述：

  input             clk     ,  
  input             rst_n    ,
  input  [size-1:0]      mul_a    ,
  input  [size-1:0]      mul_b    

### 输出描述：

   output  reg  [size*2-1:0]  mul_out 