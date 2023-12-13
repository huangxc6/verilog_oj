module det_moore (
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low
	input din ,

	output reg Y	
);
		// state declaration
		parameter IDLE        = 3'b000  ;
		parameter DETECT_1    = 3'b001  ;
		parameter DETECT_11   = 3'b010  ;
		parameter DETECT_110  = 3'b011  ;
		parameter DETECT_1101 = 3'b100  ;
	
		reg [2:0] current_state, next_state ;
	
		// state transfer
		always @(posedge clk or negedge rst_n) begin
			if(rst_n == 1'b0) begin
				current_state <= IDLE ;
			end else begin
				current_state <= next_state;
			end
		end
	
		// state calculation
		always @(*) begin
			case (current_state)
				IDLE:begin
					 if (din == 1'b1) begin
					 	next_state <= DETECT_1 ;
					end else begin
					 	next_state <= IDLE ;
					end
				end
				DETECT_1:begin
					if (din == 1'b1) begin
					 	next_state <= DETECT_11 ;
					end else begin
					 	next_state <= IDLE ;
					end
				end
				DETECT_11:begin
					if (din == 1'b1) begin
					 	next_state <= DETECT_11  ;
					end else begin
					 	next_state <= DETECT_110 ;
					end
				end
				DETECT_110:begin
					if (din == 1'b1) begin
					 	next_state <= DETECT_1101 ;
					end else begin
					 	next_state <= IDLE ;
					end
				end
				DETECT_1101:begin
					if (din == 1'b1) begin
					 	next_state <= DETECT_1 ;
					end else begin
					 	next_state <= IDLE ;
					end
				end
				default : next_state = IDLE;
			endcase
			
		end
	
		// state output
		always @(posedge clk or negedge rst_n) begin
			if (rst_n == 1'b0) begin
				Y <= 1'b0 ;
			end
			else if (current_state == DETECT_1101) begin
				Y <= 1'b1 ;
			end else begin
				Y <= 1'b0 ;
			end
		end

endmodule	