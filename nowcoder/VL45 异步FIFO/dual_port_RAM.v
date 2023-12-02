`timescale 1ns/1ns

module dual_port_RAM #(
	parameter DEPTH = 16,
	parameter WIDTH = 8
	)(
	input						wclk,
	input						wenc,
	input	[$clog2(DEPTH)-1:0]	waddr,
	input	[WIDTH-1:0]			wdata ,

	input						rclk,
	input						renc,
	input	[$clog2(DEPTH)-1:0]	raddr,
	output reg	[WIDTH-1:0]		rdata    	
);
	reg [WIDTH - 1 : 0] RAM_MEM [0 : DEPTH - 1] ;

	always @(posedge wclk) begin
		if (wenc) begin
			RAM_MEM[waddr] <= wdata ;
		end
	end

	always @(posedge rclk) begin
		if (renc) begin
			rdata <= RAM_MEM[raddr] ;
		end
	end		

endmodule