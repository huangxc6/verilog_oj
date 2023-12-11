
`timescale 1ns/1ps
module tb_div_M_N ();

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
	parameter   M_N = 8'd87;
	parameter   c89 = 8'd24;
	parameter div_e = 5'd8;
	parameter div_o = 5'd9;

	logic  clk_out;

	div_M_N #(
			.M_N(M_N),
			.c89(c89),
			.div_e(div_e),
			.div_o(div_o)
		) inst_div_M_N (
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
			$fsdbDumpfile("tb_div_M_N.fsdb");
			$fsdbDumpvars(0, "tb_div_M_N");
		end
	end
endmodule
