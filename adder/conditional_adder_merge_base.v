`timescale 1ns / 1ps
`include "carry_bypass_adder_defines.v"
module conditional_adder_merge_base 
#(parameter MERGE_LEN = `BLOCK_LEN)
(
	 input [MERGE_LEN:0] a1
	,input [MERGE_LEN:0] a2
	,input [MERGE_LEN-1:0] b1
	,input [MERGE_LEN-1:0] b2
	,input c_b1
	,input c_b2
	,output reg[2*MERGE_LEN-1:0] sum_1
	,output reg[2*MERGE_LEN-1:0] sum_2
	,output reg cout_1
	,output reg cout_2
);
always @ (*)
begin
	if(c_b1==0)
	begin
		{cout_1,sum_1}={a1,b1};
	end
	else
	begin
		{cout_1,sum_1}={a2,b1};
	end
end // always
always @ (*)
begin
	if(c_b2==0)
	begin
		{cout_2,sum_2}={a1,b2};
	end
	else
	begin
		{cout_2,sum_2}={a2,b2};
	end
end // always
endmodule