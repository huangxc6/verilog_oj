module clk_div #(
	parameter DIV_CLK = 10
	)(
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low

	output reg clk_div	
);
	// N/2 counter
	reg [3 : 0] cnt ;
	wire clk_diven  ;

	assign clk_diven = cnt == (DIV_CLK / 2) - 1 ;

	always @(posedge clk or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			cnt <= 4'b0000 ;
		end
		else if(clk_diven) begin
			cnt <= 4'b0000 ;
		end else begin
			cnt <= cnt + 1'b1 ;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			clk_div <= 1'b0 ;
		end
		else if(clk_diven) begin
			clk_div <= !clk_div ;
		end
	end


endmodule