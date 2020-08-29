`timescale 1ns / 1ps

module CLA_adder
//#(parameter 4 =4)
(
	 input[4-1:0] a 
	,input[4-1:0] b 
	,input cin
	,output[4-1:0]sum 
	,output cout
);
wire[4-1:0]bit_level_p;
wire[4-1:0]bit_level_g;
wire[4/2-1:0]group_p_level_1;
wire[4/2-1:0]group_g_level_1;
wire[4/4-1:0]group_p_level_2;
wire[4/4-1:0]group_g_level_2;
wire[4-1:0]c_level_1;// To sum
wire[4/2-1:0]c_level_2;// To carry propagation
CLA_bit_PG #(4) bit_PG
						   		 (.a(a)
								  ,.b(b)
								  ,.p(bit_level_p)
								  ,.g(bit_level_g)
								  );

CLA_carry_base carry_L1_1 (.p(bit_level_p[1:0])
						  ,.g(bit_level_g[1:0])
						  ,.c0(cin)
						  ,.cout(c_level_1[1:0])
						  ,.g_out(group_g_level_1[0])
						  ,.p_out(group_p_level_1[0])
						  );

CLA_carry_base carry_L1_2 (.p(bit_level_p[3:2])
						  ,.g(bit_level_g[3:2])
						  ,.c0(c_level_2[0])
						  ,.cout(c_level_1[3:2])
						  ,.g_out(group_g_level_1[1])
						  ,.p_out(group_p_level_1[1])
						  );
CLA_carry_base carry_L2_1(.p(group_p_level_1[1:0])
						  ,.g(group_g_level_1[1:0])
						  ,.c0(cin)
						  ,.cout(c_level_2)
						  ,.g_out(group_g_level_2[0])
						  ,.p_out(group_p_level_2[0])
						 );
assign cout =c_level_2[1] ;

CLA_sum sum_1(.a(a)
			 ,.b(b)
			 ,.c({c_level_1[2:0],cin})
			 ,.sum(sum)
			);

endmodule