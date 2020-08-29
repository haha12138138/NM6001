`timescale 1ns / 1ps

module CLA_carry_base
#(parameter LENGTH =2)
(
     input [LENGTH-1:0] p 
	,input [LENGTH-1:0] g
	,input c0
    ,output reg[LENGTH-1:0]cout
    ,output reg g_out
    ,output reg p_out
);
reg [LENGTH-1:0] gen;
reg [LENGTH-1:0] propagate;
integer j;

/*
// function automatic P;
// 	input [1:0] i;
// 	integer k;
// 	reg result;
// 	begin
// 		if (i==0)
// 		begin
// 			P=p[0];
// 		end
// 		else
// 		begin
// 			P=p[i]&(P(i-1);
// 		end
// 		result=0;
// 		for(k=0;k<=i;k=k+1)
// 		begin
// 			result=result&p[k];
// 		end
// 		P=result;
// 	end
// endfunction
*/
always @ (*)
begin
	// for(j=0;j<LENGTH;j=j+1)
	// begin
	// 	propagate[j]=P(j);
	// end
	propagate[0]=p[0];
	propagate[1]=p[0]&p[1];
	p_out=propagate[LENGTH-1];
end // always
always @ (*)
begin
	// for(j=0;j<LENGTH;j=j+1)
	// begin
	// 	gen[j]=G(j);
	// end
	gen[0]=g[0];
	gen[1]=g[1]|(p[1]&g[0]);
	g_out=gen[LENGTH-1];
end // always

always @ (*)
begin
	for(j=0;j<LENGTH;j=j+1)
	begin
		cout[j]=gen[j]|(propagate[j]&c0);
	end
end // always



endmodule



// `timescale 1ns / 1ps

// module a (
// 	 input [31:0]x
// 	,output [31:0]f
// );

// function automatic [31:0] factorial;
//  input [31:0] fac_of;
 
//  factorial=(fac_of == 1)? 1:factorial(fac_of - 1)*fac_of;
// endfunction
// assign f = factorial(x) ;
// endmodule