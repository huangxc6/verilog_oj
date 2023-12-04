module clk_div (
	input clk,    // Clock
	input rst,  // Asynchronous reset active low

	output reg clk_out	
);
	// state declaration
	parameter IDLE  = 3'b000  ;
	parameter S1    = 3'b001  ;
	parameter S2    = 3'b010  ;
	parameter S3 	= 3'b100;

	reg [2:0] current_state, next_state ;

	// state transfer
	always @(posedge clk or negedge rst) begin
		if(rst == 1'b0) begin
			current_state <= IDLE ;
		end else begin
			current_state <= next_state;
		end
	end

	// state calculation
	always @(*) begin
		case (current_state)
			IDLE: 	next_state <= S1 ;
			S1  :	next_state <= S2 ;
			S2  : 	next_state <= S3 ;
			S3  : 	next_state <= IDLE ;
			default : next_state = IDLE;
		endcase
	end

	// state output
	always @(posedge clk or negedge rst) begin
		if (rst == 1'b0) begin
			clk_out <= 1'b0 ;
		end else begin
			if (next_state == S1) begin
				clk_out <= 1'b1 ;
			end else begin
				clk_out <= 1'b0 ;
			end
		end
	end



endmodule