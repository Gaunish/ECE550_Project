module or_op(input[31:0] operandA,
				  input[31:0] operandB,
				  output[31:0] result);
			
		//Running a loop to store (operandA & operandB) in result bit by bit
		generate
			genvar i;
			for(i = 0; i < 32; i = i + 1) begin:description
				or OR1(result[i], operandA[i], operandB[i]);
			end
		endgenerate
endmodule