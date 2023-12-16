
`timescale 1ns/1ps
module tb_sequence_generator ();

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
	logic  data_cnt  ;
	logic  data_shift;

	sequence_generator_cnt inst_sequence_generator_cnt (.clk(clk), .rst_n(rst_n), .data(data_cnt));
	sequence_generator_shift inst_sequence_generator_shift (.clk(clk), .rst_n(rst_n), .data(data_shift));

	task drive(int iter);
		for(int it = 0; it < iter; it++) begin
			@(posedge clk);
		end
	endtask

	initial begin
		// do something

		repeat(10)@(posedge clk);

		drive(200);

		repeat(10)@(posedge clk);
		$finish;
	end
	// dump wave
	initial begin
		$display("random seed : %0d", $unsigned($get_initial_random_seed()));
		if ( $test$plusargs("fsdb") ) begin
			$fsdbDumpfile("tb_sequence_generator.fsdb");
			$fsdbDumpvars(0, "tb_sequence_generator");
		end
	end
endmodule
