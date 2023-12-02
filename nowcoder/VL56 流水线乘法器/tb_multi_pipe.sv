
`timescale 1ns/1ps
module tb_multi_pipe ();

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
	parameter size = 4;
	parameter    N = 2 * size;

	logic     [size-1:0] mul_a;
	logic     [size-1:0] mul_b;
	logic [2*size-1 : 0] mul_out;

	multi_pipe #(
			.size(size),
			.N(N)
		) inst_multi_pipe (
			.clk     (clk),
			.rst_n   (rst_n),
			.mul_a   (mul_a),
			.mul_b   (mul_b),
			.mul_out (mul_out)
		);

	task init();
		mul_a <= '0;
		mul_b <= '0;
	endtask

	task drive(int iter);
		for(int it = 0; it < iter; it++) begin
			for (int i = 0; i < 16; i++) begin
				mul_a <= it;
				mul_b <= i;
			@(posedge clk);
			end
		end
	endtask

	initial begin
		// do something

		init();
		repeat(10)@(posedge clk);

		drive(16);

		repeat(10)@(posedge clk);
		$finish;
	end
	// dump wave
	initial begin
		$display("random seed : %0d", $unsigned($get_initial_random_seed()));
		if ( $test$plusargs("fsdb") ) begin
			$fsdbDumpfile("tb_multi_pipe.fsdb");
			$fsdbDumpvars(0, "tb_multi_pipe");
			$fsdbDumpMDA();
		end
	end
endmodule
