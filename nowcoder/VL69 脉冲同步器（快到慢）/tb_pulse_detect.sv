
`timescale 1ns/1ps
module tb_pulse_detect ();

	// clock
	parameter PERIED_A = 3.33333 ;
	parameter PERIED_B = 10 	 ;

	logic clka;
	initial begin
		clka = '0;
		forever #(PERIED_A / 2) clka = ~clka;
	end

	logic clkb;
	initial begin
		clkb = '1;
		forever #(PERIED_B / 2) clkb = ~clkb;
	end

	// asynchronous reset
	logic rst_n;
	initial begin
		rst_n <= '0;
		#10
		rst_n <= '1;
	end


	// (*NOTE*) replace reset, clock, others
	logic  sig_a;
	logic  sig_b;

	pulse_detect inst_pulse_detect (.clka(clka), .clkb(clkb), .rst_n(rst_n), .sig_a(sig_a), .sig_b(sig_b));

	task init();
		sig_a <= '0 ;
	endtask : init

	task drive(int iter);
		for(int it = 0; it < iter; it++) begin
			sig_a <= 1;
			@(posedge clka);
			sig_a <= 0;
			repeat($urandom_range(10,50))@(posedge clka);
		end
	endtask

	initial begin
		// do something

		init();
		repeat(10)@(posedge clka);

		drive(20);

		repeat(10)@(posedge clka);
		$finish;
	end
	// dump wave
	initial begin
		$display("random seed : %0d", $unsigned($get_initial_random_seed()));
		if ( $test$plusargs("fsdb") ) begin
			$fsdbDumpfile("tb_pulse_detect.fsdb");
			$fsdbDumpvars(0, "tb_pulse_detect");
		end
	end
endmodule
