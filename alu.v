module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;
		
	wire [31:0] sum_buffer;
	wire overflow_sum_buffer;
	add_sub Add_Sub1(data_operandA, data_operandB, ctrl_ALUopcode, sum_buffer, overflow_sum_buffer,isNotEqual,isLessThan);
	
	wire[31:0] and_buffer;
	and_op And_op1(data_operandA, data_operandB, and_buffer);
	
	wire[31:0] or_buffer;
	or_op Or_op1(data_operandA, data_operandB, or_buffer);
		
	wire[5:0] select_buffer;
	
	equal E1(ctrl_ALUopcode, 5'b00000, select_buffer[0]);
	assign overflow = select_buffer[0] ? overflow_sum_buffer : 1'bZ ;
	assign data_result = select_buffer[0] ? sum_buffer : 32'bZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ; 
	
	equal E2(ctrl_ALUopcode, 5'b00001, select_buffer[1]);
	assign overflow = select_buffer[1] ? overflow_sum_buffer : 1'bZ ;
	assign data_result = select_buffer[1] ? sum_buffer : 32'bZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ; 
	
	equal E3(ctrl_ALUopcode, 5'b00010, select_buffer[2]);
	assign data_result = select_buffer[2] ? and_buffer : 32'bZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ; 
	
	equal E4(ctrl_ALUopcode, 5'b00011, select_buffer[3]);
	assign data_result = select_buffer[3] ? or_buffer : 32'bZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ; 
	
endmodule