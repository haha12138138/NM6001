`include "carry_bypass_adder_defines.v"
module carry_select_carry_base
#(parameter BLOCK_LEN =`BLOCK_LEN)
(
	  input [BLOCK_LEN-1:0] a
	 ,input [BLOCK_LEN-1:0] b
	 ,input  cin
	 ,output reg cout
	 ,output [BLOCK_LEN-1:0] sum
);
reg[BLOCK_LEN-1:0]propagate;
reg[BLOCK_LEN-1:0]gen;
reg[BLOCK_LEN-1:0]cout_p;
reg[BLOCK_LEN-1:0]propagate1;
reg[BLOCK_LEN-1:0]gen1;
reg[BLOCK_LEN-1:0]cout_p1;
reg[BLOCK_LEN-1:0]c_to_sum;
integer i,j;
always @ (*)
begin
	for (i = 0; i <= BLOCK_LEN-1; i = i + 1)
	begin
 	    propagate[i]=a[i]|b[i];
 	    gen[i]=a[i]&b[i];
	end // for
end // always

always @ (*)
begin
	
	cout_p[0]=(propagate[0]&1'b0)|gen[0];
	for (i = 1; i <= BLOCK_LEN-1; i = i + 1)
	begin
 	    cout_p[i]=(propagate[i]&cout_p[i-1])|gen[i];
	end // for
end

always @ (*)
begin

	cout_p1[0]=(propagate[0]&1'b1)|gen[0];
	for (j = 1; j <= BLOCK_LEN-1; j = j + 1)
	begin
 	    cout_p1[j]=(propagate[j]&cout_p1[j-1])|gen[j];
	end // for
end

always @ (*)
begin
	cout=(cin)?cout_p1[BLOCK_LEN-1]:cout_p[BLOCK_LEN-1];
	c_to_sum={(cin)?cout_p1[BLOCK_LEN-2:0]:cout_p[BLOCK_LEN-2:0],cin};
end // always

carry_select_sum_base sum1(.a(a),.b(b),.c(c_to_sum),.sum(sum));
endmodule