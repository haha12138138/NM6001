`timescale 1ns / 1ps
module carry_bypass_adder_base_tb;
`include "carry_bypass_adder_defines.v"
reg [`INPUT_LEN-1:0] a;
reg [`INPUT_LEN-1:0] b;
reg c;
wire [`INPUT_LEN-1:0] sum;
wire cout;
reg clk;
carry_bypass_adder adder(a,b,c,sum,cout);
initial begin
	#0 clk = 0;
	   a=0;
	   b=0;
	   c=0;
	forever begin
	   #10 clk =~clk ;
	end // forever 
end // initial
integer i;
always @(posedge clk) begin
	a=$ramdom%2**(`INPUT_LEN);
	b=$ramdom%2**(`INPUT_LEN);
	c=$random%2;
	i=i+1;
	if(i==20)
	begin
		$stop;
	end
end
always @(posedge clk)
begin
	$display("a=%d,b=%d,cin=%d,sum=%d,cout=%d",a,b,c,sum,cout);
end
endmodule