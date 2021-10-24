module decoder_5(
	input[4:0] a,
	output[31:0]b);
//lower bits connected to a 2-4 decoder.
//higher bits connected to a 3-8 decoder.

	wire[7:0] decode_3;
	wire[3:0] decode_2;
	decoder_2 d2 (a[1:0],decode_2[3:0]);
	decoder_3 d3 (a[4:2],decode_3[7:0]);
	and and31(b[31],decode_2[3],decode_3[7]);
	and and30(b[30],decode_2[2],decode_3[7]);
	and and29(b[29],decode_2[1],decode_3[7]);
	and and28(b[28],decode_2[0],decode_3[7]);
	
	and and27(b[27],decode_2[3],decode_3[6]);
	and and26(b[26],decode_2[2],decode_3[6]);
	and and25(b[25],decode_2[1],decode_3[6]);
	and and24(b[24],decode_2[0],decode_3[6]);
	
	and and23(b[23],decode_2[3],decode_3[5]);
	and and22(b[22],decode_2[2],decode_3[5]);
	and and21(b[21],decode_2[1],decode_3[5]);
	and and20(b[20],decode_2[0],decode_3[5]);
	
	and and19(b[19],decode_2[3],decode_3[4]);
	and and18(b[18],decode_2[2],decode_3[4]);
	and and17(b[17],decode_2[1],decode_3[4]);
	and and16(b[16],decode_2[0],decode_3[4]);
	
	and and15(b[15],decode_2[3],decode_3[3]);
	and and14(b[14],decode_2[2],decode_3[3]);
	and and13(b[13],decode_2[1],decode_3[3]);
	and and12(b[12],decode_2[0],decode_3[3]);
	
	and and11(b[11],decode_2[3],decode_3[2]);
	and and10(b[10],decode_2[2],decode_3[2]);
	and and09(b[9],decode_2[1],decode_3[2]);
	and and08(b[8],decode_2[0],decode_3[2]);
	
	and and07(b[7],decode_2[3],decode_3[1]);
	and and06(b[6],decode_2[2],decode_3[1]);
	and and05(b[5],decode_2[1],decode_3[1]);
	and and04(b[4],decode_2[0],decode_3[1]);
	
	and and03(b[3],decode_2[3],decode_3[0]);
	and and02(b[2],decode_2[2],decode_3[0]);
	and and01(b[1],decode_2[1],decode_3[0]);
	and and00(b[0],decode_2[0],decode_3[0]);
	

endmodule