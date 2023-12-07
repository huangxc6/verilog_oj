
`timescale 1ns/1ps
module tb_clk_div ();

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
	parameter DIV_CLK = 10;

	logic  clk_div;

	clk_div #(.DIV_CLK(DIV_CLK)) inst_clk_div (.clk(clk), .rst_n(rst_n), .clk_div(clk_div));

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

		drive(200);

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
