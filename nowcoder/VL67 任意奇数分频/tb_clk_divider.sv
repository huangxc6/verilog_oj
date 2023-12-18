
`timescale 1ns/1ps
module tb_clk_divider (); 

	// clock
	logic clk_in;
	initial begin
		clk_in = '0;
		forever #(0.5) clk_in = ~clk_in;
	end

	// asynchronous reset
	logic rst_n;
	initial begin
		rst_n <= '0;
		#10
		rst_n <= '1;
	end

	// (*NOTE*) replace reset, clock, others
	parameter   dividor = 5;
	parameter CNT_WIDTH = $clog2(dividor-1);

	logic  clk_out;

	clk_divider #(
			.dividor(dividor),
			.CNT_WIDTH(CNT_WIDTH)
		) inst_clk_divider (
			.clk_in  (clk_in),
			.rst_n   (rst_n),
			.clk_out (clk_out)
		);

	task init();
	endtask

	task drive(int iter);
		for(int it = 0; it < iter; it++) begin
			@(posedge clk_in);
		end
	endtask

	initial begin
		// do something

		init();
		repeat(10)@(posedge clk_in);

		drive(200);

		repeat(10)@(posedge clk_in);
		$finish;
	end
	// dump wave
	initial begin
		$display("random seed : %0d", $unsigned($get_initial_random_seed()));
		if ( $test$plusargs("fsdb") ) begin
			$fsdbDumpfile("tb_clk_divider.fsdb");
			$fsdbDumpvars(0, "tb_clk_divider");
		end
	end
endmodule
