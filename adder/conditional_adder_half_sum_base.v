`timescale 1ns / 1ps
`include "carry_bypass_adder_defines.v"
module conditional_adder_halfsum_base (
	 input [`BLOCK_LEN-1:0] a
	,input [`BLOCK_LEN-1:0] b
	,output reg[`BLOCK_LEN:0] sum_c_1
	,output reg[`BLOCK_LEN:0] sum_c_2
);
always @ (*)
begin
	sum_c_1=a+b;
	sum_c_2=sum_c_1;
end // always

endmodule