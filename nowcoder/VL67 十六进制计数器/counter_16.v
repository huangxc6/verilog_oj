module counter_16 (
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low
	
	output reg [3:0] Q
);
	always @(posedge clk or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			Q <= 4'b0000 ;
		end
		else begin
			Q <= Q + 1'b1 ;
		end
	end

endmodule