`timescale 1ns/1ns

module data_driver (
	input clk_a,
	input rst_n,
	input data_ack ,

	output reg [3:0] data,
	output reg data_req
);
	reg data_ack_dly1 ;
	reg data_ack_dly2 ;
	reg [9 : 0] cnt ;

	always @(posedge clk_a or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			data_ack_dly1 <= '0 ;
			data_ack_dly2 <= '0 ;
		end
		else begin
			data_ack_dly1 <= data_ack 		;
			data_ack_dly2 <= data_ack_dly1  ;
		end
	end

	always @(posedge clk_a or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			data <= '0 ;
		end
		else if (data_ack_dly1 && ~data_ack_dly2) begin
			data <= (data == 4'b0111) ? 4'b0000 : data + 1'b1 ;
		end else begin
			data <= data ;
		end
	end

	always @(posedge clk_a or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			cnt <= '0 ;
		end
		else if (data_ack_dly1 && ~data_ack_dly2) begin
			cnt <= 0 ;
		end else if (data_req) begin
			cnt <= cnt ;
		end else
			cnt <= cnt + 1;
	end

	always @(posedge clk_a or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			data_req <= '0 ;
		end
		else if (cnt == 3'd4) begin
			data_req <= 1'b1 ;
		end else if (data_ack_dly1 && ~data_ack_dly2) begin
			data_req <= 1'b0 ;
		end else begin
			data_req <= data_req ;
		end
	end

endmodule