module sfifo #(
	parameter WIDTH = 8,
	parameter DEPTH = 16
	)(
	input					clk 	,    // Clock
	input					rst_n 	,  // Asynchronous reset active low
	input					winc 	,
	input					rinc 	,
	input	[WIDTH-1:0]		wdata	,

	output reg				wfull 	,
	output reg				rempty 	,
	output wire	[WIDTH-1:0]	rdata    	
);

	wire wenc ;
	wire renc ;
	assign wenc = !wfull && winc ;
	assign renc = !rempty && rinc ;

	parameter ADDR_WIDTH = $clog2(DEPTH) ;

	reg [ADDR_WIDTH : 0] waddr ;
	reg [ADDR_WIDTH : 0] raddr ;

	always @(posedge clk or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			waddr <= 'b0 ;
		end
		else if (wenc) begin
			waddr <= waddr + 1'b1 ;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			raddr <= 'b0 ;
		end
		else if (renc) begin
			raddr <= raddr + 1'b1 ;
		end
	end

	wire full  ;
	wire empty ;

	assign full = (waddr[ADDR_WIDTH] == !raddr[ADDR_WIDTH])
			   && (waddr[ADDR_WIDTH-1:0] == raddr[ADDR_WIDTH-1:0]);
	assign empty = (waddr == raddr) ? 1'b1 : 1'b0 ;

	always @(posedge clk or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			rempty <= 1'b0 ;
			wfull  <= 1'b0 ;
		end
		else begin
			rempty <= empty ;
			wfull  <= full  ;
		end
	end

	dual_port_RAM #(
			.DEPTH(DEPTH),
			.WIDTH(WIDTH)
		) inst_dual_port_RAM (
			.wclk  (clk),
			.wenc  (wenc),
			.waddr (waddr),
			.wdata (wdata),
			.rclk  (clk),
			.renc  (renc),
			.raddr (raddr),
			.rdata (rdata)
		);


endmodule