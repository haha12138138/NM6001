`timescale 1ns / 1ps

module CLA_sum
#(parameter INPUT_LEN =4)
(
	 input[INPUT_LEN-1:0] a 
	,input[INPUT_LEN-1:0] b 
	,input[INPUT_LEN-1:0]c
	,output reg[INPUT_LEN-1:0]sum
);
integer i;
always @ (*)
begin
		sum[0]=(a[0]&b[0]&c[0])|(a[0]&~b[0]&~c[0])|(~a[0]&b[0]&~c[0])|(~a[0]&~b[0]&c[0]);
		for (i = 1; i <= INPUT_LEN-1; i = i + 1)
		begin
 	    	sum[i]=(a[i]&b[i]&c[i])|(a[i]&~b[i]&~c[i])|(~a[i]&b[i]&~c[i])|(~a[i]&~b[i]&c[i]);
		end // for
end // always
endmodule