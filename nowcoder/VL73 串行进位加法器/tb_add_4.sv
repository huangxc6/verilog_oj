
`timescale 1ns/1ps
module tb_add_4 (); 

	// clock
	logic clk;
	initial begin
		clk = '0;
		forever #(0.5) clk = ~clk;
	end

	// synchronous reset
	logic srstb;
	initial begin
		srstb <= '0;
		repeat(10)@(posedge clk);
		srstb <= '1;
	end

	// (*NOTE*) replace reset, clock, others
	logic [3:0] A;
	logic [3:0] B;
	logic [3:0] S;
	logic  Ci ;
	logic  Co ;

	add_4 inst_add_4 (
		.A(A), 
		.B(B),
		.Ci(Ci), 
		.S(S), 
		.Co(Co)
		);

	task init();
		A <= '0;
		B <= '0;
		Ci <= '0 ;
	endtask

	task drive(c);
		Ci <= c ; 
		for(int it = 0; it < 16; it++) begin
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

		drive(0);
		drive(1);

		repeat(10)@(posedge clk);
		$finish;
	end
	// dump wave
	initial begin
		$display("random seed : %0d", $unsigned($get_initial_random_seed()));
		if ( $test$plusargs("fsdb") ) begin
			$fsdbDumpfile("tb_add_4.fsdb");
			$fsdbDumpvars(0, "tb_add_4");
		end
	end
endmodule
