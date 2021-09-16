module add_sub(input[31:0]data_operandA, 
					input[31:0]data_operandB, 
					input[4:0]ctrl_ALUopcode, 
					output[31:0] data_result, 
					output overflow);	
	
	//intermediate wires,
	// Overflow_buffer : buffer to store carry_in and carry_out to check the overflow
	// buffer_B: buffer for data_operandB used for implementing adder/subtracter
	// select: used to select between adder/subtractor 
	// buffer_B_2 : for storing inverted operand B
	wire [1:0] overflow_buffer;
	wire[31:0] buffer_B, buffer_B_2;
	wire select;
	
	// Here we are given, 10000 : adder & 10001 : subtracter
	// used the 0th bit to differentiate between both of them
	assign select = ctrl_ALUopcode[0];
	
	//Inverting the data_operandB storing it in buffer_B_2 bitwise
	generate
		genvar i;
		for(i = 0; i < 32; i = i + 1) begin: description
			not N1(buffer_B_2[i], data_operandB[i]);
		end
	endgenerate
	
	//select the value for second operand based on select opcode
	assign buffer_B = select ? buffer_B_2 : data_operandB;
	
	//Add/subtract the two 32-bit input data based on the opcode
	//Note : select is fanned-in as carry-in to implement the function of 2s complement for subtractor
	CLA_32 CLA_32_test(data_operandA[31:0], buffer_B[31:0],select, data_result[31:0], overflow_buffer[1:0]);
	
	//Compute the overflow based on condition:
	// overflow = 0 : carry-in == carry-out & vice-versa
	xor X1(overflow, overflow_buffer[1], overflow_buffer[0]);
	
endmodule