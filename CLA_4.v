module CLA_4(
	input [3:0]a,
	input [3:0]b,
	output [3:0]sum,
	input cin,
	output cout,
	output G2,//representing G3-0 because G2 & P2 are needed in CLA_16, so they are set as output
	output P2,//represengting P3-0
	output overflow_bit
);
//all the variable with temp suffix means it is an intermediate variable
	wire [3:0]G;//G0,G1,G2,G3
	wire [3:0]P;//P0,P1,P2,P3
	wire [3:0]C;//C0,C1,C2,C3 where C0 is the cin. C4 is not included as it is refered to cout
	wire [4:0]C_temp;
	
	//variable of the first-level
	wire [1:0]G1;//G1-0 = G1[0] and G3-2 = G1[1] 
	wire [1:0]P1;//P1-0 and P3-2
	wire [1:0]G1_temp;
	
	wire G2_temp;
	
	wire cout_temp;
	wire [3:0]sum_temp;
	
	assign C[0] = cin;


	//can be replaced by the for loop
	and(G[0],a[0],b[0]);
	and(G[1],a[1],b[1]);
	and(G[2],a[2],b[2]);
	and(G[3],a[3],b[3]);
	or(P[0],a[0],b[0]);
	or(P[1],a[1],b[1]);
	or(P[2],a[2],b[2]);
	or(P[3],a[3],b[3]);
	
	and(P1[0],P[0],P[1]);
	and(P1[1],P[3],P[2]);
	and(G1_temp[0],P[1],G[0]);
	or(G1[0],G1_temp[0],G[1]);
	and(G1_temp[1],P[3],G[2]);
	or(G1[1],G1_temp[1],G[3]);
	and(C_temp[1],P[0],C[0]);
	or(C[1],C_temp[1],G[0]);
	
	and(P2,P1[1],P1[0]);
	and(G2_temp,P1[1],G1[0]);
	or(G2,G2_temp,G1[1]);
	and(C_temp[2],P1[0],C[0]);
	or(C[2],C_temp[2],G1[0]);
	
	and(C_temp[3],P[2],C[2]);
	or(C[3],C_temp[3],G[2]);
	and(cout_temp,P2,C[0]);
	or(cout,cout_temp,G2);
	
	xor(sum_temp[0],a[0],b[0]);
	xor(sum[0],sum_temp[0],C[0]);
		xor(sum_temp[1],a[1],b[1]);
	xor(sum[1],sum_temp[1],C[1]);
		xor(sum_temp[2],a[2],b[2]);
	xor(sum[2],sum_temp[2],C[2]);
		xor(sum_temp[3],a[3],b[3]);
	xor(sum[3],sum_temp[3],C[3]);
	
	assign overflow_bit = C[3];
	
endmodule
