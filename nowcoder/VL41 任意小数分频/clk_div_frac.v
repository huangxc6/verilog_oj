module clk_div_frac #(
	parameter S_NUM = 76,
	parameter D_NUM = 10
	)(
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low

	output reg clk_div    	
);
	// parameter of 7-div, 8-div and error acc
	parameter S_DIV = S_NUM / D_NUM 		;
	parameter D_DIV = S_DIV + 1 			;
	parameter ACC = S_NUM - S_DIV * D_NUM 	;

	reg [3 : 0] cnt_end_r ; //cycles of division
	reg [3 : 0] main_cnt  ; //main counter
	// reg clk_div_r ;	//clk out

	wire diff_cnt_en;
	assign diff_cnt_en = main_cnt == cnt_end_r ;

	always @(posedge clk or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			main_cnt <= 4'b0000 ;
			clk_div  <= 1'b0 	;
		end
		else if (diff_cnt_en) begin
			main_cnt <= 4'b0000 ;
			clk_div  <= 1'b1	;
		end else begin
			main_cnt <= main_cnt + 1'b1 ;
			clk_div  <= 1'b0 	;
		end
	end

	// error acc enable
	reg [4 : 0] diff_cnt_r ; // error accumulate
	wire [4 : 0] diff_cnt ;

	assign diff_cnt = diff_cnt_r >= D_NUM ?
						diff_cnt_r - 10 + ACC :
						diff_cnt_r + ACC	  ;

	always @(posedge clk or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			diff_cnt_r <= 0 ;
		end
		else if (diff_cnt_en) begin
			diff_cnt_r <= diff_cnt ;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			cnt_end_r <= S_DIV - 1 ;
		end
		else if (diff_cnt >= 10) begin
			cnt_end_r <= D_DIV - 1 ;
		end else begin
			cnt_end_r <= S_DIV - 1 ;
		end
	end


endmodule