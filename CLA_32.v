module CLA_32(
	input[31:0]a,
	input[31:0]b,
	input cin,
	output [31:0]sum,
	output [1:0]overflow
);
	wire cout_low, cout_high;
	wire[1:0] buffer;
	 
	CLA_16 CLA_16_low(a[15:0],b[15:0],cin,sum[15:0],cout_low,buffer[1:0]);
	CLA_16 CLA_16_high(a[31:16],b[31:16],cout_low,sum[31:16],cout_high,overflow[1:0]);
	
	
endmodule