`timescale 1 ns/ 1 ns
module ali16_tb();

	reg clk;
	initial begin
		clk = '0;
		forever #(5) clk = ~clk;
	end

	reg rst_n ;
	reg d 	  ;
	reg dout  ;

	ali16 inst_ali16 (.clk(clk), .rst_n(rst_n), .d(d), .dout(dout));

	initial begin
		rst_n = 1'b1 ;
		repeat(10)@(posedge clk) ;
		rst_n = 1'b0 ;
		# 45
		rst_n = 1'b1 ;
		repeat(5)@(posedge clk) ;
		rst_n = 1'b0 ;
		# 45
		rst_n = 1'b1 ;
		repeat(10)@(posedge clk) ;
		$stop ;

	end

	initial begin
		d = 1'b0 ;
		repeat(11)@(posedge clk) ;
		d = 1'b1 ;
		repeat(11)@(posedge clk) ;
		d = 1'b0 ;
		repeat(11)@(posedge clk) ;
		d = 1'b1 ;
	end
	                                            
	
	initial begin
	    $dumpfile("ali16_tb.vcd");
	    $dumpvars(0, ali16_tb);    //tb模块名称
	end
	
	// initial $monitor($time,"-> \t now state of gray_data is : %b",data);
	initial $monitor($time, dout);
endmodule
