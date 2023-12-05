module pulse_detect (
	input clka,
	input clkb,    
	input rst_n,  // Asynchronous reset active low
	input sig_a,

	output sig_b
);
	reg sig_a_reg ;
	always @(posedge clka or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			sig_a_reg <= 1'b0 ;
		end
		else begin
			sig_a_reg <= sig_a_reg ^ sig_a ;
		end
	end

	reg q_slow 		;
	reg q_slow_dly1 ;
	reg q_slow_dly2 ;

	always @(posedge clkb or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			q_slow <= 1'b0 ;
			q_slow_dly1 <= 1'b0 ;
			q_slow_dly2 <= 1'b0 ;
		end
		else begin
			q_slow 		<= sig_a_reg   ;
			q_slow_dly1 <= q_slow 	   ;
			q_slow_dly2 <= q_slow_dly1 ;
		end
	end

	assign sig_b = q_slow_dly1 ^ q_slow_dly2 ;

endmodule