`timescale 1ns/1ns

module multi_pipe #(
	parameter size = 4
	)(
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low
	input [size-1:0] mul_a,
	input [size-1:0] mul_b,

	output reg [2*size-1 : 0] mul_out
);
	parameter N = 2 * size;

	wire [N-1 : 0] temp [0:3] ;

	reg [N-1 : 0] adder_0 ;
	reg [N-1 : 0] adder_1 ;


	genvar i;
	generate
		for (i = 0; i < 4; i++) begin
			assign temp[i] = mul_b[i] ? mul_a << i : 'd0 ;
		end
	endgenerate

	always @(posedge clk or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			adder_0 <= 'd0 ;
		end
		else begin
			adder_0 <= temp[0] + temp[1] ;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			adder_1 <= 'd0 ;
		end
		else begin
			adder_1 <= temp[2] + temp[3] ;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			mul_out <= 'd0 ;
		end
		else begin
			mul_out <= adder_0 + adder_1 ;
		end
	end

endmodule
