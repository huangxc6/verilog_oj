
`timescale 1ns/1ps
module tb_clk_switch ();

	// clock
	logic clk0;
	initial begin
		clk0 = '0;
		forever #(1) clk0 = ~clk0;
	end

	logic clk1;
	initial begin
		clk1 = '0;
		forever #(0.5) clk1 = ~clk1;
	end

	// asynchronous reset
	logic rst_n;
	initial begin
		rst_n <= '0;
		#10
		rst_n <= '1;
	end

	// (*NOTE*) replace reset, clock, others
	logic  sel;
	logic  clk_out;

	clk_switch inst_clk_switch (.clk0(clk0), .clk1(clk1), .rst(rst_n), .sel(sel), .clk_out(clk_out));

	task init();
		sel  <= '0;
	endtask

	initial begin
		// do something

		init();

		#20
		sel = 1'b1 ;
		#20
		sel = 1'b0 ;
		#20

		$finish;
	end
	// dump wave
	initial begin
		$display("random seed : %0d", $unsigned($get_initial_random_seed()));
		if ( $test$plusargs("fsdb") ) begin
			$fsdbDumpfile("tb_clk_switch.fsdb");
			$fsdbDumpvars(0, "tb_clk_switch");
		end
	end
endmodule
