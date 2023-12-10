module clk_div_odd_or #(
	parameter DIV_CLK = 9
	)(
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low
	output wire clk_div9
);
	 reg [3 : 0] cnt ;
	 always @(posedge clk or negedge rst_n) begin
	 	if (rst_n == 1'b0) begin
	 		cnt <= 4'b0000 ;
	 	end
	 	else if (cnt == DIV_CLK-1) begin
	 		cnt <= 4'b0000 ;
	 	end else begin
	 		cnt <= cnt + 1'b1 ;
	 	end
	 end

	 reg clkp_div9_r;
	 always @(posedge clk or negedge rst_n) begin
	 	if (rst_n == 1'b0) begin
	 		clkp_div9_r <= 1'b0 ;
	 	end
	 	else if (cnt == (DIV_CLK/2-1)) begin
	 		clkp_div9_r <= 1'b1 ; // counter is 4-8,output 0
	 	end else if (cnt == DIV_CLK-2) begin
	 		clkp_div9_r <= 1'b0 ; // counter is 0-3,output 1
	 	end
	 end

	 reg clkn_div9_r ;
	 always @(negedge clk or negedge rst_n) begin
	 	if (rst_n == 1'b0) begin
	 		clkn_div9_r <= 1'b0 ;
	 	end
	 	else if (cnt == (DIV_CLK/2)) begin
	 		clkn_div9_r <= 1'b1 ;
	 	end else if (cnt == (DIV_CLK - 1)) begin
	 		clkn_div9_r <= 1'b0 ;
	 	end
	 end

	 // logic or, using clkor cell
	 assign clk_div9 = clkp_div9_r | clkn_div9_r ;
endmodule