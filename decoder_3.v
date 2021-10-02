module decoder_3(
	input[2:0] a,
	output[7:0]b);
//3-8 decoder. lower bits conneted to a 2-4 decoder.
	wire not_2;
	wire[3:0] decode_2;
	not(not_2,a[2]);
	decoder_2 d (a[1:0],decode_2[3:0]);
	and and7(b[7],decode_2[3],a[2]);
	and and6(b[6],decode_2[2],a[2]);
	and and5(b[5],decode_2[1],a[2]);
	and and4(b[4],decode_2[0],a[2]);
	and and3(b[3],decode_2[3],not_2);
	and and2(b[2],decode_2[2],not_2);
	and and1(b[1],decode_2[1],not_2);
	and and0(b[0],decode_2[0],not_2);
endmodule