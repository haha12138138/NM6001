`timescale 1ns / 1ps
`include "carry_bypass_adder_defines.v"

module carry_bypass_adder (
	 input [`INPUT_LEN-1:0] a
	,input [`INPUT_LEN-1:0] b
	,input cin
	,output  [`OUTPUT_LEN-1:0]o 
	,output  reg cout 
);
wire[`INPUT_LEN/`BLOCK_LEN-1:0] c_wire;
carry_bypass_adder_base base_1(.a(a[`BLOCK_LEN-1:0]),
							   .b(b[`BLOCK_LEN-1:0]),
							   .cin(cin),
							   .sum(o[`BLOCK_LEN-1:0]),
							   .cout(c_wire[0])
							   );
// carry_bypass_adder_base base_2(.a(a[2*`BLOCK_LEN-1:`BLOCK_LEN]),
// 							   .b(b[2*`BLOCK_LEN-1:`BLOCK_LEN]),
// 							   .cin(c_wire[0]),
// 							   .sum(o[2*`BLOCK_LEN-1:`BLOCK_LEN]),
// 							   .cout(c_wire[1])
// 							   );
// carry_bypass_adder_base base_3(.a(a[3*`BLOCK_LEN-1:2*`BLOCK_LEN]),
// 							   .b(b[3*`BLOCK_LEN-1:2*`BLOCK_LEN]),
// 							   .cin(c_wire[1]),
// 							   .sum(o[(3*`BLOCK_LEN-1):2*`BLOCK_LEN]),
// 							   .cout(c_wire[2])
// 							   );
// carry_bypass_adder_base base_4(.a(a[4*`BLOCK_LEN-1:3*`BLOCK_LEN]),
// 							   .b(b[4*`BLOCK_LEN-1:3*`BLOCK_LEN]),
// 							   .cin(c_wire[2]),
// 							   .sum(o[(4*`BLOCK_LEN-1):3*`BLOCK_LEN]),
// 							   .cout(c_wire[3]));
always @ (*)
begin
	cout=c_wire[3];
end // always

genvar i;
generate

	for(i=1;i<`INPUT_LEN/`BLOCK_LEN;i=i+1)
	begin
		carry_bypass_adder_base base_1(.a(a[(i+1)*`BLOCK_LEN-1:i*`BLOCK_LEN]),
									   .b(b[(i+1)*`BLOCK_LEN-1:i*`BLOCK_LEN]),
									   .cin(c_wire[i-1]),
									   .sum(o[(i+1)*`BLOCK_LEN-1:i*`BLOCK_LEN]),
									   .cout(c_wire[i]));
	end
endgenerate

endmodule
