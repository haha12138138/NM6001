`timescale 1ns / 1ps
module carry_bypass_adder_base_tb;
`include "carry_bypass_adder_defines.v"
reg [`BLOCK_LEN-1:0] a;
reg [`BLOCK_LEN-1:0] b;
reg c;
wire [`BLOCK_LEN-1:0] sum;
wire cout;
reg clk;
carry_bypass_adder_base adder_base1(a,b,c,sum,cout);
initial begin
	#0 clk = 0;
	   a=0;
	   b=0;
	   c=0;
	forever begin
	   #10 clk =~clk ;
	end // forever 
end // initial

always @(posedge clk) begin
	if(a==2**(`BLOCK_LEN)-1)
	begin
		a=0;
		if(b==2**(`BLOCK_LEN)-1)
		begin
			b=0;
			if(c==1)
			begin
				$stop;
			end
			c=~c;
		end
		else
		begin
			b=b+1;
		end
	end
	else
	begin
		a=a+1;
	end
end
always @(posedge clk)
begin
	$display("a=%d,b=%d,cin=%d,sum=%d,cout=%d",a,b,c,sum,cout);
end
endmodule