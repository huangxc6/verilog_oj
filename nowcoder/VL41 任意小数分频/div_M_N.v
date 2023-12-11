module div_M_N (
	input clk_in,    // Clock
	input rst_n ,  // Asynchronous reset active low

	output wire clk_out	
);
	parameter M_N   = 8'd87 ;
	parameter c89   = 8'd24 ;
	parameter div_e = 5'd8  ;
	parameter div_o = 5'd9  ;

	reg [3 : 0] clk_cnt ;
	reg [6 : 0] cyc_cnt ;
	reg div_flag  ;
	reg clk_out_r ;

	always @(posedge clk_in or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			clk_cnt <= 4'b0000 ;
		end
		else if (div_flag == 1'b0) begin
			clk_cnt <= (clk_cnt == (div_e-1)) ? 0 : clk_cnt + 1'b1 ;
		end else begin
			clk_cnt <= (clk_cnt == (div_o-1)) ? 0 : clk_cnt + 1'b1 ;
		end
	end

	always @(posedge clk_in or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			cyc_cnt <= 6'b00_0000 ;
		end
		else begin
			cyc_cnt <= (cyc_cnt == (M_N-1)) ? 0 : cyc_cnt + 1'b1 ;
		end
	end

	always @(posedge clk_in or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			div_flag <= 1'b0 ;
		end
		else begin
			div_flag <= (cyc_cnt == (M_N-1)) || (cyc_cnt == (c89-1)) ? ~div_flag : div_flag ;
		end
	end

	always @(posedge clk_in or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			clk_out_r <= 1'b0 ;
		end
		else if (div_flag == 1'b0) begin
			clk_out_r <= clk_cnt<=((div_e>>2)+1) ;
		end else begin
			clk_out_r <= clk_cnt<=((div_o>>2)+1) ;
		end
	end

	assign clk_out = clk_out_r ;

endmodule