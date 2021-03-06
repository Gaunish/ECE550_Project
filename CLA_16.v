module CLA_16(
	input [15:0]a,
	input [15:0]b,
	input cin,
	output [15:0]sum,
	output cout,
	output [1:0] overflow
);
//refer to slide p46
//basically the same architecture as CLA_4
//what we can get from 4 CLA_4 is G3-0 P3-0 G7-4 P7-4 G11-8 P11-8 G15-12 P15-12
//which is similar to the input of a single CLA_4 (instead of computing the P's and G's from a's and b's,
//those G3-0 P3-0 G7-4 P7-4 G11-8 P11-8 G15-12 P15-12 are generated from CLA_4 part) 
wire [3:0]G;
wire [3:0]P;
wire [4:0]C;

wire [1:0]G1;
wire [1:0]P1;
wire [1:0]G1_temp;
wire [4:0]C_temp;

wire G2;
wire P2;
wire G2_temp;
	
wire [3:0] dummy;
wire [2:0] buffer;
wire cout_temp;

assign C[0] = cin;
CLA_4 a0(a[3:0],b[3:0],sum[3:0],C[0],dummy[0],G[0],P[0], buffer[0]);
CLA_4 a1(a[7:4],b[7:4],sum[7:4],C[1],dummy[1],G[1],P[1], buffer[1]);
CLA_4 a2(a[11:8],b[11:8],sum[11:8],C[2],dummy[2],G[2],P[2], buffer[2]);
CLA_4 a3(a[15:12],b[15:12],sum[15:12],C[3],dummy[3],G[3],P[3], overflow[0]);

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
assign overflow[1] = cout;
endmodule