module even_div_cnt (
	input clk_in,  // input clock
	input rst_n ,  // Asynchronous reset active low
	
	output wire clk_out2 ,
	output wire clk_out4 ,
	output wire clk_out8 
);
	reg [2:0] cnt ;

	always @(posedge clk_in or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			cnt <= 3'b011 ;
		end
		else begin
			cnt <= cnt + 1'b1 ;
		end
	end

	assign clk_out2 = ~cnt[0] ;
	assign clk_out4 = ~cnt[1] ;
	assign clk_out8 =  cnt[2] ;
	
endmodule