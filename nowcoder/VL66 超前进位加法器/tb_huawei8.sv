
`timescale 1ns/1ps
module tb_huawei8 (); 
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
	logic [3:0] A;
	logic [3:0] B;
	logic [4:0] OUT;

	huawei8 inst_huawei8 (.A(A), .B(B), .OUT(OUT));

	task init();
		A <= '0;
		B <= '0;
	endtask

	task drive(int iter);
		for(int it = 0; it < iter; it++) begin
			for (int i = 0; i < 16; i++) begin
				A <= it;
				B <= i;
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
			$fsdbDumpfile("tb_huawei8.fsdb");
			$fsdbDumpvars(0, "tb_huawei8");
		end
	end
endmodule
