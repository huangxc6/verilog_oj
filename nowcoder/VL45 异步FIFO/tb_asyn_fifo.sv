
`timescale 1ns/1ps
module tb_asyn_fifo ();
	// clock
	logic wclk;
	initial begin
		wclk = '0;
		forever #(0.5) wclk = ~wclk;
	end

	logic rclk;
	initial begin
		rclk = '0;
		#0.5
		forever #(1.0) rclk = ~rclk;
	end

	// asynchronous reset
	logic wrstn;
	initial begin
		wrstn <= '0;
		#10
		wrstn <= '1;
	end

	logic rrstn;
	initial begin
		rrstn <= '0;
		#10
		rrstn <= '1;
	end


	// (*NOTE*) replace reset, clock, others
	parameter      WIDTH = 8;
	parameter      DEPTH = 16;
	parameter ADDR_WIDTH = $clog2(DEPTH);

	logic             winc;
	logic             rinc;
	logic [WIDTH-1:0] wdata;
	logic             wfull;
	logic             rempty;
	logic [WIDTH-1:0] rdata;

	asyn_fifo #(
			.WIDTH(WIDTH),
			.DEPTH(DEPTH),
			.ADDR_WIDTH(ADDR_WIDTH)
		) inst_asyn_fifo (
			.wclk   (wclk),
			.rclk   (rclk),
			.wrstn  (wrstn),
			.rrstn  (rrstn),
			.winc   (winc),
			.rinc   (rinc),
			.wdata  (wdata),
			.wfull  (wfull),
			.rempty (rempty),
			.rdata  (rdata)
		);

	task init();
		winc  <= '0;
		rinc  <= '0;
		wdata <= '0;
	endtask

	task write(int iter);
		for(int it = 0; it < iter; it++) begin
			winc  <= '1;
			rinc  <= '0;
			wdata <= $random();
			@(posedge wclk);
		end
	endtask

	task read(int iter);
		for(int it = 0; it < iter; it++) begin
			winc  <= '0;
			rinc  <= '1;
			wdata <= '0;
			@(posedge rclk);
		end
	endtask

	initial begin
		// do something

		init();
		repeat(20)@(posedge wclk);

		write(15) ;
		read (20) ;

		repeat(10)@(posedge wclk);
		$finish;
	end
	// dump wave
	initial begin
		$display("random seed : %0d", $unsigned($get_initial_random_seed()));
		if ( $test$plusargs("fsdb") ) begin
			$fsdbDumpfile("tb_asyn_fifo.fsdb");
			$fsdbDumpvars(0, "tb_asyn_fifo");
			$fsdbDumpMDA();
		end
	end
endmodule
