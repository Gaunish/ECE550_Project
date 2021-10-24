module decoder_2(
	input[1:0] a,
	output[3:0] b
);
	wire not_0;
	wire not_1;
	
	not not0(not_0,a[0]);
	not not1(not_1,a[1]);
	and and3(b[3],a[0],a[1]);
	and and2(b[2],not_0,a[1]);
	and and1(b[1],not_1,a[0]);
	and and0(b[0],not_0,not_1);

endmodule