`timescale 1ns/1ns

module ali16(
input clk,
input rst_n,
input d,
output reg dout
 );

//*************code***********//
    reg rst_n_sync_pre  ;
    reg rst_n_sync      ;

    always @ (posedge clk or negedge rst_n) begin
        if (rst_n == 1'b0) begin
            rst_n_sync_pre <= 1'b0 ;
            rst_n_sync     <= 1'b0 ;
        end else begin
            rst_n_sync_pre  <= 1'b1 ;
            rst_n_sync      <= rst_n_sync_pre ;
        end
    end

    always @ (posedge clk or negedge rst_n_sync) begin
        if (rst_n_sync == 1'b0) begin
            dout <= 1'b0 ;
        end else begin
            dout <= d    ;
        end
    end

//*************code***********//
endmodule