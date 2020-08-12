`timescale 1ns / 1ps
`include "carry_bypass_adder_defines.v"
module carry_bypass_adder_base (
	  input [`BLOCK_LEN-1:0] a
	 ,input [`BLOCK_LEN-1:0] b
	 ,input  cin
	 ,output reg [`BLOCK_LEN-1:0]sum
	 ,output reg cout
);
reg[`BLOCK_LEN-1:0]propagate;
reg[`BLOCK_LEN-1:0]gen;
reg[`BLOCK_LEN-1:0]cout_p;

integer i;
always @ (*)
begin
	for (i = 0; i <= `BLOCK_LEN-1; i = i + 1)
	begin
 	    propagate[i]=a[i]|b[i];
 	    gen[i]=a[i]&b[i];
	end // for
	cout_p[0]=(propagate[0]&cin)|gen[0];
	for (i = 1; i <= `BLOCK_LEN-1; i = i + 1)
	begin
 	    cout_p[i]=(propagate[i]&cout_p[i-1])|gen[i];
	end // for
end
always @ (*)
begin
	cout=((~gen&propagate)==(2**(`BLOCK_LEN)-1))?cin:cout_p[`BLOCK_LEN-1];
end // always
always @ (*)
begin
		sum[0]=(a[0]&b[0]&cin)|(a[0]&~b[0]&~cin)|(~a[0]&b[0]&~cin)|(~a[0]&~b[0]&cin);
		for (i = 1; i <= `BLOCK_LEN-1; i = i + 1) begin
 	    sum[i]=(a[i]&b[i]&cout_p[i-1])|(a[i]&~b[i]&~cout_p[i-1])|(~a[i]&b[i]&~cout_p[i-1])|(~a[i]&~b[i]&cout_p[i-1]);
	end // for
end // always

endmodule