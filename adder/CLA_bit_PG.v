`timescale 1ns / 1ps

module CLA_bit_PG #(parameter LENGTH =2)
(
     input [LENGTH-1:0] a
	,input [LENGTH-1:0] b 
	,output [LENGTH-1:0] p 
	,output [LENGTH-1:0] g
);
assign p =a|b ;
assign g =a&b ;
endmodule