
`timescale 1ns/1ps
module tb_odo_div_or (); 

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
	parameter N = 7;

	logic  clk_out7;

	odo_div_or #(.N(N)) inst_odo_div_or (.clk_in(clk_in), .rst_n(rst_n), .clk_out7(clk_out7));

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
			$fsdbDumpfile("tb_odo_div_or.fsdb");
			$fsdbDumpvars(0, "tb_odo_div_or");
		end
	end
endmodule
