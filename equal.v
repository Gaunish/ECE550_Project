module equal(input[4:0] operand_A, 
					input[4:0] operand_B, 
					output out);
				

	//Compare the two operands bit-by-bit,
	// if not equal put out_buffer = 1 and break out of the loop
	// return out = 0
	// else, return out = 1
	
	// out_buffer is used as buffer for output
	// bit_buffer is used as buffer for the output of bits XOR(ed)
	wire[4:0] out_buffer;
	wire[4:0] bit_buffer;
	
	//initial case
	xor X0_equal(bit_buffer[0], operand_A[0], operand_B[0]);
	assign out_buffer[0] = bit_buffer[0] ? 1'b1 : 1'b0;
			

	//checking if a bit from op_A == op_B by XOR(ing) them
	// if both are equal, XOR output = 0
	generate
		genvar i;
		for(i = 1; i < 5; i = i + 1)begin : description
			xor X1_equal(bit_buffer[i], operand_A[i], operand_B[i]);
			
			// selection of value of out_buffer on basis of bit_buffer
			// if not equal, out_buffer = 1
			//	else carry forward the previous one
			assign out_buffer[i] = (bit_buffer[i]) ? 1'b1 : out_buffer[i - 1]; 
			
		end
	endgenerate
	
	//inverting the out_buffer
	not N1_equal(out, out_buffer[4]);

endmodule