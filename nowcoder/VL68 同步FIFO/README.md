中等 通过率：10.10%

## 描述

请设计带有空满信号的同步FIFO，FIFO的深度和宽度可配置。双口RAM的参考代码和接口信号已给出，请在答案中添加并例化此部分代码。
电路的接口如下图所示。端口说明如下表。

接口电路图如下：

![img](https://uploadfiles.nowcoder.com/images/20220320/110_1647788273474/D8FBF83D49E8E8964CA250A70C4F6D7F)

双口RAM端口说明：

| **端口名** | **I/O** | **描述**   |
| ---------- | ------- | ---------- |
| **wclk**   | input   | 写数据时钟 |
| **wenc**   | input   | 写使能     |
| **waddr**  | input   | 写地址     |
| **wdata**  | input   | 输入数据   |
| **rclk**   | input   | 读数据时钟 |
| **renc**   | input   | 读使能     |
| **raddr**  | input   | 读地址     |
| **rdata**  | output  | 输出数据   |

同步FIFO端口说明：

| **端口名** | **I/O** | **描述** |
| ---------- | ------- | -------- |
| **clk**    | input   | 时钟     |
| **rst_n**  | input   | 异步复位 |
| **winc**   | input   | 写使能   |
| **rinc**   | input   | 读使能   |
| **wdata**  | input   | 写数据   |
| **wfull**  | output  | 写满信号 |
| **rempty** | output  | 读空信号 |
| **rdata**  | output  | 读数据   |

参考代码如下：

```c
module dual_port_RAM #(parameter DEPTH = 16,
                       parameter WIDTH = 8)(
     input wclk
    ,input wenc
    ,input [$clog2(DEPTH)-1:0] waddr  
    ,input [WIDTH-1:0] wdata        
    ,input rclk
    ,input renc
    ,input [$clog2(DEPTH)-1:0] raddr  
    ,output reg [WIDTH-1:0] rdata       
);

reg [WIDTH-1:0] RAM_MEM [0:DEPTH-1];

always @(posedge wclk) begin
    if(wenc)
        RAM_MEM[waddr] <= wdata;
end 

always @(posedge rclk) begin
    if(renc)
        rdata <= RAM_MEM[raddr];
end 

endmodule 
```





### 输入描述：

input clk , 

input rst_n ,

input winc ,

input rinc ,

input          wdata ,



### 输出描述：

  output reg        wfull  ,
  output reg        rempty  ,
  output wire        rdata