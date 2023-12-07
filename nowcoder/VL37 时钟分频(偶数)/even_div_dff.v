module even_div_dff (
	input clk_in,  // input clock
	input rst_n ,  // Asynchronous reset active low
	
	output wire clk_out2 ,
	output wire clk_out4 ,
	output wire clk_out8 
);
	reg clk_out2_r ;
	reg clk_out4_r ;
	reg clk_out8_r ;

	always @(posedge clk_in or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			clk_out2_r <= 1'b0 ;
		end
		else begin
			clk_out2_r <= ~clk_out2_r ;
		end
	end

	always @(posedge clk_out2 or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			clk_out4_r <= 1'b0 ;
		end
		else begin
			clk_out4_r <= ~clk_out4_r ;
		end
	end

	always @(posedge clk_out4 or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			clk_out8_r <= 1'b0 ;
		end
		else begin
			clk_out8_r <= ~clk_out8_r ;
		end
	end

	assign clk_out2 = clk_out2_r ;
	assign clk_out4 = clk_out4_r ;
	assign clk_out8 = clk_out8_r ;

endmodule