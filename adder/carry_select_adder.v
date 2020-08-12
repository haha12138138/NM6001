`timescale 1ns / 1ps
`include "carry_bypass_adder_defines.v"
module carry_select_adder (
	  input [`INPUT_LEN-1:0] a
	 ,input [`INPUT_LEN-1:0] b
	 ,input  cin
	 ,output reg cout
	 ,output [`INPUT_LEN-1:0] o 
);
wire[`INPUT_LEN/`BLOCK_LEN-1:0] c_wire;
carry_select_carry_base linear_select(.a(a[`BLOCK_LEN-1:0]),
									  .b(b[`BLOCK_LEN-1:0]),
									  .cin(cin),
									  .sum(o[`BLOCK_LEN-1:0]),
									  .cout(c_wire[0]));
genvar i;
generate

	for(i=1;i<`INPUT_LEN/`BLOCK_LEN;i=i+1)
	begin
		carry_select_carry_base linear_select_1(.a(a[(i+1)*`BLOCK_LEN-1:i*`BLOCK_LEN]),
									   		  .b(b[(i+1)*`BLOCK_LEN-1:i*`BLOCK_LEN]),
									   		  .cin(c_wire[i-1]),
									   		  .sum(o[(i+1)*`BLOCK_LEN-1:i*`BLOCK_LEN]),
									   		  .cout(c_wire[i]));
	end
endgenerate
always @ (*)
begin
	cout=c_wire[3];
end // always

endmodule