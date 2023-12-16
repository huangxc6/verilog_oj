module sequence_generator_cnt (
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low
	
	output reg data
);
	reg [2 : 0] cnt ;

	always @(posedge clk or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			cnt <= 3'b000 ;
		end
		else if (cnt == 3'b101) begin
			cnt <= 3'b000 ;
		end else begin
			cnt <= cnt + 1'b1 ;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			data <= 1'b0 ;
		end
		else begin
			case (cnt)
				3'b000: data <= 1'b0 ;
				3'b001: data <= 1'b0 ;
				3'b010: data <= 1'b1 ;
				3'b011: data <= 1'b0 ;
				3'b100: data <= 1'b1 ;
				3'b101: data <= 1'b1 ;
				default : data <= 1'b0;
			endcase
		end
	end

endmodule