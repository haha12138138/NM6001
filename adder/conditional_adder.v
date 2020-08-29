`timescale 1ns / 1ps
//`include "carry_bypass_adder_defines.v"
`define INPUT_LEN 8
`define BLOCK_LEN 4
`define OUTPUT_LEN `INPUT_LEN
module conditional_adder (
	 input [`INPUT_LEN-1:0] a
	,input [`INPUT_LEN-1:0] b
	,output reg [`OUTPUT_LEN-1:0] sum
	,output reg cout
);
wire [`BLOCK_LEN:0]sum_level_1[3:0];
wire [2*`BLOCK_LEN-1:0]merge_level_1[1:0];
wire [1:0]cout_temp;
conditional_adder_halfsum_base halfsum1(.a(a[`BLOCK_LEN-1:0]),
								.b(b[`BLOCK_LEN-1:0]),
								.sum_c_1(sum_level_1[0]),
								.sum_c_2(sum_level_1[1])
								);
conditional_adder_sum_base sum2(.a(a[2*`BLOCK_LEN-1:`BLOCK_LEN]),
								.b(b[2*`BLOCK_LEN-1:`BLOCK_LEN]),
								.sum_c_1(sum_level_1[2]),
								.sum_c_2(sum_level_1[3])
								);
conditional_adder_merge_base merge1(//lower bit
									.b1(sum_level_1[0][`BLOCK_LEN-1:0]),
									.b2(sum_level_1[1][`BLOCK_LEN-1:0]),
									.a1(sum_level_1[2]),
									.a2(sum_level_1[3]),
									//carry from the lower side
									.c_b1(sum_level_1[0][`BLOCK_LEN]),
									.c_b2(sum_level_1[1][`BLOCK_LEN]),
									.sum_1(merge_level_1[0]),
									.sum_2(merge_level_1[1]),
									.cout_1(cout_temp[0]),
									.cout_2(cout_temp[1])
									);
always @ (*)
begin
	sum=merge_level_1[1];
	cout=cout_temp[0];
end // always

endmodule