中等 通过率：15.82%

## 描述

sig_a 是 clka（300M）时钟域的一个单时钟脉冲信号（高电平持续一个时钟clka周期），请设计脉冲同步电路，将sig_a信号同步到时钟域 clkb（100M）中，产生sig_b单时钟脉冲信号（高电平持续一个时钟clkb周期）输出。请用 Verilog 代码描述。
clka时钟域脉冲之间的间隔很大，无需考虑脉冲间隔太小的问题。
电路的接口如下图所示：

![img](https://uploadfiles.nowcoder.com/images/20220320/110_1647789046174/9D64CA275FF218899A001A7066DEA4D0)

### 输入描述：

  input         clka  , 
  input         clkb  ,  
  input         rst_n    ,
  input        sig_a    ,

### 输出描述：

  output        sig_b