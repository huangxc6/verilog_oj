module odo_div_or #(
	parameter N = 7
	)(
	input clk_in , 
	input rst_n  , 

	output wire clk_out7	
);
	reg [3 : 0] cnt ;

	always @(posedge clk_in or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			cnt <= 4'b0000 ;
		end
		else if (cnt == N-1) begin
			cnt <= 4'b0000 ;
		end else begin
			cnt <= cnt + 1'b1 ;
		end
	end

	reg clk_p ;
	always @(posedge clk_in or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			clk_p <= 1'b0 ;
		end
		else if (cnt == (N >> 1)) begin
			clk_p <= 1'b1 ;
		end else if (cnt == N-1) begin
			clk_p <= 1'b0 ;
		end
	end

	reg clk_n ;
	always @(negedge clk_in or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			clk_n <= 1'b0 ;
		end
		else if (cnt == (N>>1)) begin
			clk_n <= 1'b1 ;
		end else if (cnt == N-1) begin
			clk_n <= 1'b0 ;
		end
	end

	assign clk_out7 = clk_p || clk_n ;

endmodule