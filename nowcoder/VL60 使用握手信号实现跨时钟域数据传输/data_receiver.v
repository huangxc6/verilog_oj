module data_receiver (
	input clk_b,  
	input rst_n,  
	input [3:0] data,
	input data_req ,

	output reg data_ack
);
	reg [3 : 0] data_in_reg ;
	reg data_req_dly1 ;
	reg data_req_dly2 ;

	always @(posedge clk_b or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			data_req_dly1 <= '0 ;
			data_req_dly2 <= '0 ;
		end
		else begin
			data_req_dly1 <= data_req ;
			data_req_dly2 <= data_req_dly1 ;
		end
	end

	always @(posedge clk_b or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			data_ack <= 1'b0 ;
		end
		else if (data_req_dly1) begin
			data_ack <= 1'b1 ;
		end else begin
			data_ack <= 1'b0 ;
		end
	end

	always @(posedge clk_b or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			data_in_reg <= '0 ;
		end
		else if (data_req_dly1 && ~data_req_dly2) begin
			data_in_reg <= data ;
		end else begin
			data_in_reg <= data_in_reg ;
		end
	end

endmodule