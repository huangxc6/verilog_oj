module rtl (
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low
	input data_in ,

	output reg data_out
);
	reg data_in_reg ;

	always @(posedge clk or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			data_in_reg <= 1'b0 ;
		end
		else begin
			data_in_reg <= data_in ;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			data_out <= 1'b0 ;
		end
		else begin
			data_out <= data_in && !data_in_reg ;
		end
	end

endmodule