module asyn_fifo #(
	parameter WIDTH = 8,
	parameter DEPTH = 16			
	)(
	input					wclk,    
	input					rclk,
	input					wrstn,  
	input					rrstn,
	input					winc,
	input					rinc, 
	input	[WIDTH-1:0]		wdata,

	output wire				wfull,
	output wire				rempty,
	output wire	[WIDTH-1:0]	rdata 	    	
);
	parameter ADDR_WIDTH = $clog2(DEPTH);

	// generate addr bin
	reg [ADDR_WIDTH : 0] waddr_bin ;
	reg [ADDR_WIDTH : 0] raddr_bin ;

	always @(posedge wclk or negedge wrstn) begin
		if (wrstn == 1'b0) begin
			waddr_bin <= 'd0 ;
		end
		else if (!wfull && winc) begin
			waddr_bin <= waddr_bin + 1'd1 ;
		end
	end
	
	always @(posedge rclk or negedge rrstn) begin
		if (rrstn == 1'b0) begin
			raddr_bin <= 'd0 ;
		end
		else if (!rempty && rinc) begin
			raddr_bin <= raddr_bin + 1'd1 ;
		end
	end

	// generate addr gray
	wire [ADDR_WIDTH : 0] waddr_gray ;
	wire [ADDR_WIDTH : 0] raddr_gray ;

	reg [ADDR_WIDTH : 0] wptr ;
	reg [ADDR_WIDTH : 0] rptr ;

	assign waddr_gray = waddr_bin ^ (waddr_bin >> 1) ;
	assign raddr_gray = raddr_bin ^ (raddr_bin >> 1) ;

	always @(posedge wclk or negedge wrstn) begin
		if (wrstn == 1'b0) begin
			wptr <= 'd0 ;
		end
		else begin
			wptr <= waddr_gray ;
		end
	end

	always @(posedge rclk or negedge rrstn) begin
		if (rrstn == 1'b0) begin
			rptr <= 'd0 ;
		end
		else begin
			rptr <= raddr_gray ;
		end
	end

	// sync addr gray
	reg [ADDR_WIDTH : 0] wptr_dly1 ;
	reg [ADDR_WIDTH : 0] wptr_dly2 ;
	reg [ADDR_WIDTH : 0] rptr_dly1 ;
	reg [ADDR_WIDTH : 0] rptr_dly2 ;

	always @(posedge wclk or negedge wrstn) begin
		if (wrstn == 1'b0) begin
			rptr_dly1 <= 'd0 ;
			rptr_dly2 <= 'd0 ;
		end
		else begin
			rptr_dly1 <= rptr      ;
			rptr_dly2 <= rptr_dly1 ;
		end
	end

	always @(posedge rclk or negedge rrstn) begin
		if (rrstn == 1'b0) begin
			wptr_dly1 <= 'd0 ;
			wptr_dly2 <= 'd0 ;
		end
		else begin
			wptr_dly1 <= wptr      ;
			wptr_dly2 <= wptr_dly1 ;
		end
	end

	// generate full & empty signal
	assign wfull  = (wptr == {~rptr_dly2[ADDR_WIDTH:ADDR_WIDTH-1], rptr_dly2[ADDR_WIDTH-2:0]}) ;
	assign rempty = (rptr == wptr_dly2) ;

	// RAM
	wire wenc ;
	wire renc ;
	wire [ADDR_WIDTH-1 : 0] waddr ;
	wire [ADDR_WIDTH-1 : 0] raddr ;

	assign wenc = winc & !wfull ;
	assign renc = rinc & !rempty;
	assign waddr = waddr_bin[ADDR_WIDTH-1:0] ;
	assign raddr = raddr_bin[ADDR_WIDTH-1:0] ;

	dual_port_RAM #(
			.DEPTH(DEPTH),
			.WIDTH(WIDTH)
		) inst_dual_port_RAM (
			.wclk  (wclk),
			.wenc  (wenc),
			.waddr (waddr),
			.wdata (wdata),
			.rclk  (rclk),
			.renc  (renc),
			.raddr (raddr),
			.rdata (rdata)
		);


endmodule