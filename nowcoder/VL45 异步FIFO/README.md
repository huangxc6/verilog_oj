较难 通过率：7.79%

## 描述

请根据题目中给出的双口RAM代码和接口描述，实现异步FIFO，要求FIFO位宽和深度参数化可配置。



电路的接口如下图所示。

![img](https://dev-private-public.oss-cn-hangzhou.aliyuncs.com/images/20220222/110_1645535626909/D642F8C3D2D6C1AB174D170D2DC8ED78)

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

| **端口名** | **I/O** | **描述**         |
| ---------- | ------- | ---------------- |
| **wclk**   | input   | 写时钟           |
| **rclk**   | input   | 读时钟           |
| **wrstn**  | input   | 写时钟域异步复位 |
| **rrstn**  | input   | 读时钟域异步复位 |
| **winc**   | input   | 写使能           |
| **rinc**   | input   | 读使能           |
| **wdata**  | input   | 写数据           |
| **wfull**  | output  | 写满信号         |
| **rempty** | output  | 读空信号         |
| **rdata**  | output  | 读数据           |



双口RAM代码如下，可在本题答案中添加并例化此代码。

```c
module dual_port_RAM #(parameter DEPTH = 16,
   parameter WIDTH = 8)(
 input wclk
,input wenc
,input [$clog2(DEPTH)-1:0] waddr  //深度对2取对数，得到地址的位宽。
,input [WIDTH-1:0] wdata      //数据写入
,input rclk
,input renc
,input [$clog2(DEPTH)-1:0] raddr  //深度对2取对数，得到地址的位宽。
,output reg [WIDTH-1:0] rdata //数据输出
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

  input           wclk  , 
  input           rclk  ,  
  input           wrstn  ,
  input          rrstn  ,
  input           winc  ,
  input           rinc  ,
  input     [WIDTH-1:0]  wdata  

### 输出描述：

  output wire        wfull  ,
  output wire        rempty  ,
  output wire [WIDTH-1:0]  rdata



```verilog
`timescale 1ns/1ns

/***************************************RAM*****************************************/
module dual_port_RAM #(parameter DEPTH = 16,
					   parameter WIDTH = 8)(
	 input wclk
	,input wenc
	,input [$clog2(DEPTH)-1:0] waddr  //深度对2取对数，得到地址的位宽。
	,input [WIDTH-1:0] wdata      	//数据写入
	,input rclk
	,input renc
	,input [$clog2(DEPTH)-1:0] raddr  //深度对2取对数，得到地址的位宽。
	,output reg [WIDTH-1:0] rdata 		//数据输出
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

/***************************************AFIFO*****************************************/
module asyn_fifo#(
	parameter	WIDTH = 8,
	parameter 	DEPTH = 16
)(
	input 					wclk	, 
	input 					rclk	,   
	input 					wrstn	,
	input					rrstn	,
	input 					winc	,
	input 			 		rinc	,
	input 		[WIDTH-1:0]	wdata	,

	output wire				wfull	,
	output wire				rempty	,
	output wire [WIDTH-1:0]	rdata
);
    
endmodule
```

