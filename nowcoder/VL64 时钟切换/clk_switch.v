module clk_switch (
	input clk0	,    // Clock
	input clk1  ,
	input rst	,  // Asynchronous reset active low
	input sel   ,

	output reg clk_out
);
	wire d0 ;
	wire d1 ;
	reg q0_neg_r ;
	reg q1_neg_r ;

	assign d0 = ~sel && ~q1_neg_r ;
	assign d1 =  sel && ~q0_neg_r ;

	always @(negedge clk0 or negedge rst) begin
		if (rst == 1'b0) begin
			q0_neg_r <= 1'b0 ;
		end
		else begin
			q0_neg_r <= d0 ;
		end
	end

	always @(negedge clk1 or negedge rst) begin
		if (rst == 1'b0) begin
			q1_neg_r <= 1'b0 ;
		end
		else begin
			q1_neg_r <= d1 ;
		end
	end

	always @(*) begin
		clk_out = q0_neg_r && clk0 || q1_neg_r && clk1 ;
	end

endmodule