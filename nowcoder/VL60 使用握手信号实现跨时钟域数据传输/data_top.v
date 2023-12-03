module data_top (
	input clk_a,    
	input clk_b,
	input rst_n
	
);
	wire data_ack ;
	wire data_req ;
	wire [3:0] data ;

	data_driver inst_data_driver
		(
			.clk_a    (clk_a),
			.rst_n    (rst_n),
			.data_ack (data_ack),
			.data     (data),
			.data_req (data_req)
		);

	data_receiver inst_data_receiver
		(
			.clk_b    (clk_b),
			.rst_n    (rst_n),
			.data     (data),
			.data_req (data_req),
			.data_ack (data_ack)
		);


endmodule