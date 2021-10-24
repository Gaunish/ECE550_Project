module read_port(
input[31:0] dffs,
input[4:0]sel,
output[31:0]result);

wire [31:0] decode;
decoder_5 d(sel[4:0],decode[31:0]);
//assign the output if the decoder output is 1'b
generate
	genvar i;
	for(i = 0;i < 32;i = i+1) begin: description
		assign result[i] = decode[i] ? dffs[i] : 1'bZ; 
	end
endgenerate
	




endmodule