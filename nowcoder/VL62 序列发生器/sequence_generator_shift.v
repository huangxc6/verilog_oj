module sequence_generator_shift (
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low
	
	output reg data
);
	reg [5 : 0] data_reg ;

	always @(posedge clk or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			data_reg <= 6'b00_1011 ;
		end
		else if (data_reg == 6'b10_0000) begin
			data_reg <= 6'b00_1011 ;
		end else begin
			data_reg <= (data_reg << 1) ;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			data <= 1'b0 ;
		end
		else begin
			data <= data_reg[5] ;
		end
	end

endmodule