module clk_divider #(
	parameter dividor = 5
	)(
	input clk_in ,    // Clock
	input rst_n  ,    // Asynchronous reset active low

	output clk_out    	
);

	parameter CNT_WIDTH = $clog2(dividor-1) ;

	reg clk_p_r ;
	reg clk_n_r ;
	reg [CNT_WIDTH:0] cnt ;

	always @(posedge clk_in or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			cnt <= '0 ;
		end
		else if (cnt == dividor-1) begin
			cnt <= 0 ;
		end else begin
			cnt <= cnt + 1'b1 ;
		end
	end

	always @(posedge clk_in or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			clk_p_r <= '0 ;
		end
		else if (cnt == (dividor-1 >> 1)) begin
			clk_p_r <= ~clk_p_r ;
		end else if (cnt == dividor-1) begin
			clk_p_r <= ~clk_p_r ;
		end
	end

	always @(negedge clk_in or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			clk_n_r <= '0 ;
		end
		else if (cnt == (dividor-1 >> 1)) begin
			clk_n_r <= ~clk_n_r ;
		end else if (cnt == dividor-1) begin
			clk_n_r <= ~clk_n_r ;
		end
	end

	assign clk_out = clk_p_r || clk_n_r ;

endmodule