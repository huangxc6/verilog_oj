
`timescale 1ns/1ps
module tb_data_top ();
	// clock
	logic clk_a;
	initial begin
		clk_a = '0;
		forever #(0.5) clk_a = ~clk_a;
	end

	logic clk_b;
	initial begin
		clk_b = '0;
		forever #(1) clk_b = ~clk_b;
	end

	logic rst_n;
	initial begin
		rst_n <= '0;
		#5
		rst_n <= '1;
	end


	data_top inst_data_top (.clk_a(clk_a), .clk_b(clk_b), .rst_n(rst_n));

	initial begin
		// do something

		repeat(150)@(posedge clk_a);

		$finish;
	end
	// dump wave
	initial begin
		$display("random seed : %0d", $unsigned($get_initial_random_seed()));
		if ( $test$plusargs("fsdb") ) begin
			$fsdbDumpfile("tb_data_top.fsdb");
			$fsdbDumpvars(0, "tb_data_top");
		end
	end
endmodule
