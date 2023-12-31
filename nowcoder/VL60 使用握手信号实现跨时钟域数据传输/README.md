## 描述

分别编写一个数据发送模块和一个数据接收模块，模块的时钟信号分别为clk_a，clk_b。两个时钟的频率不相同。数据发送模块循环发送0-7，在每个数据传输完成之后，间隔5个时钟，发送下一个数据。请在两个模块之间添加必要的握手信号，保证数据传输不丢失。
  模块的接口信号图如下：
![img](https://uploadfiles.nowcoder.com/images/20220321/110_1647830377928/4788D72910F61578727970078C82C92F)
data_req和data_ack的作用说明：
data_req表示数据请求接受信号。当data_out发出时，该信号拉高，在确认数据被成功接收之前，保持为高，期间data应该保持不变，等待接收端接收数据。
当数据接收端检测到data_req为高，表示该时刻的信号data有效，保存数据，并拉高data_ack。
当数据发送端检测到data_ack，表示上一个发送的数据已经被接收。撤销data_req，然后可以改变数据data。等到下次发送时，再一次拉高data_req。

### 输入描述：

clk_a：发送端时钟信号

clk_b：接收端时钟信号

rst_n：复位信号，低电平有效

data_ack：数据接收确认信号

### 输出描述：

data：发送的数据

data_req：请求接收数据
