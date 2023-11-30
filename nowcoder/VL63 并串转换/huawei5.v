`timescale 1ns/1ns
module huawei5(
	input wire clk       ,
	input wire rst       ,
	input wire [3:0]d    ,
	output wire valid_in ,
	output wire dout
	);

//*************code***********//

	reg [3:0] d_reg ;
	reg valid_in_reg;
	reg [1:0] cnt   ;

	always @ (posedge clk or negedge rst) begin
		if (rst == 1'b0) begin
			d_reg 	     <= 4'b0000 ;
			cnt          <= 2'b00   ;
			valid_in_reg <= 1'b0    ;
		end else begin 
			if (cnt == 2'b11) begin
					d_reg 		 <= d 	    ;
					valid_in_reg <= 1'b1 	;
					cnt 		 <= 2'b00   ;
			end else begin
					d_reg    <= {d_reg[2:0], 1'b0};
					valid_in_reg <= 1'b0  	   ;
					cnt 		 <= cnt + 1'b1 ;
				end
		end
	end

	assign dout 	= d_reg[3] 		;
	assign valid_in = valid_in_reg  ;

//*************code***********//

endmodule