
`timescale 1ns/1ps
module tb_even_div (); 

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
	logic  clk_out2_cnt;
	logic  clk_out4_cnt;
	logic  clk_out8_cnt;

	logic  clk_out2_dff;
	logic  clk_out4_dff;
	logic  clk_out8_dff;

	even_div_cnt inst_even_div_cnt
		(
			.clk_in   (clk_in),
			.rst_n    (rst_n),
			.clk_out2 (clk_out2_cnt),
			.clk_out4 (clk_out4_cnt),
			.clk_out8 (clk_out8_cnt)
		);


	even_div_dff inst_even_div_dff
		(
			.clk_in   (clk_in),
			.rst_n    (rst_n),
			.clk_out2 (clk_out2_dff),
			.clk_out4 (clk_out4_dff),
			.clk_out8 (clk_out8_dff)
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
			$fsdbDumpfile("tb_even_div.fsdb");
			$fsdbDumpvars(0, "tb_even_div");
		end
	end
endmodule
