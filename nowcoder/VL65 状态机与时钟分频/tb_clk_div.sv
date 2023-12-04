
`timescale 1ns/1ps
module tb_clk_div ();

	// clock
	logic clk;
	initial begin
		clk = '0;
		forever #(0.5) clk = ~clk;
	end

	// asynchronous reset
	logic rst;
	initial begin
		rst <= '0;
		#10
		rst <= '1;
	end

	// synchronous reset
	logic srstb;
	initial begin
		srstb <= '0;
		repeat(10)@(posedge clk);
		srstb <= '1;
	end

	// (*NOTE*) replace reset, clock, others
	parameter IDLE = 3'b000;
	parameter   S1 = 3'b001;
	parameter   S2 = 3'b010;
	parameter   S3 = 3'b100;

	logic  clk_out;

	clk_div #(
			.IDLE(IDLE),
			.S1(S1),
			.S2(S2),
			.S3(S3)
		) inst_clk_div (
			.clk     (clk),
			.rst     (rst),
			.clk_out (clk_out)
		);

	task init();
	endtask

	task drive(int iter);
		for(int it = 0; it < iter; it++) begin
			@(posedge clk);
		end
	endtask

	initial begin
		// do something

		init();
		repeat(10)@(posedge clk);

		drive(100);

		repeat(10)@(posedge clk);
		$finish;
	end
	// dump wave
	initial begin
		$display("random seed : %0d", $unsigned($get_initial_random_seed()));
		if ( $test$plusargs("fsdb") ) begin
			$fsdbDumpfile("tb_clk_div.fsdb");
			$fsdbDumpvars(0, "tb_clk_div");
		end
	end
endmodule
