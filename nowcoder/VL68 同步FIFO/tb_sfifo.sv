
`timescale 1ns/1ps
module tb_sfifo (); 

	// clock
	logic clk;
	initial begin
		clk = '0;
		forever #(0.5) clk = ~clk;
	end

	// asynchronous reset
	logic rst_n;
	initial begin
		rst_n <= '0;
		#10
		rst_n <= '1;
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

	sfifo #(
			.WIDTH(WIDTH),
			.DEPTH(DEPTH),
			.ADDR_WIDTH(ADDR_WIDTH)
		) inst_sfifo (
			.clk    (clk),
			.rst_n  (rst_n),
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
			@(posedge clk);
		end
	endtask

	task read(int iter);
		for(int it = 0; it < iter; it++) begin
			winc  <= '0;
			rinc  <= '1;
			wdata <= '0;
			@(posedge clk);
		end
	endtask

	initial begin
		// do something

		init();
		repeat(10)@(posedge clk);

		write(20);

		read(20) ;

		repeat(10)@(posedge clk);
		$finish;
	end
	// dump wave
	initial begin
		$display("random seed : %0d", $unsigned($get_initial_random_seed()));
		if ( $test$plusargs("fsdb") ) begin
			$fsdbDumpfile("tb_sfifo.fsdb");
			$fsdbDumpvars(0, "tb_sfifo");
			$fsdbDumpMDA();
		end
	end
endmodule
