`timescale 1ns / 1ps
`include "carry_bypass_adder_defines.v"
module  carry_select_sum_base(
	 input [`BLOCK_LEN-1:0] a
	,input [`BLOCK_LEN-1:0] b
	,input [`BLOCK_LEN-1:0] c 
	,output reg [`BLOCK_LEN-1:0]sum
);
integer i ;
always @ (*)
begin
		sum[0]=(a[0]&b[0]&c[0])|(a[0]&~b[0]&~c[0])|(~a[0]&b[0]&~c[0])|(~a[0]&~b[0]&c[0]);
		for (i = 1; i <= `BLOCK_LEN-1; i = i + 1)
		begin
 	    	sum[i]=(a[i]&b[i]&c[i])|(a[i]&~b[i]&~c[i])|(~a[i]&b[i]&~c[i])|(~a[i]&~b[i]&c[i]);
		end // for
end // always
endmodule