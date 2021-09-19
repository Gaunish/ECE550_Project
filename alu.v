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
	
	wire[31:0] left_buffer;
	left_shift Left1(data_operandA, ctrl_shiftamt, left_buffer);
	
	wire[31:0] right_buffer;
	right_shift Right1(data_operandA, ctrl_shiftamt, right_buffer);
	
	assign overflow = (ctrl_ALUopcode == 5'b00000) ? overflow_sum_buffer : 1'bZ ;
	assign data_result = (ctrl_ALUopcode == 5'b00000) ? sum_buffer : 32'bZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ; 
	
	assign overflow = (ctrl_ALUopcode == 5'b00001) ? overflow_sum_buffer : 1'bZ ;
	assign data_result = (ctrl_ALUopcode == 5'b00001) ? sum_buffer : 32'bZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ; 
	
	assign data_result = (ctrl_ALUopcode == 5'b00010) ? and_buffer : 32'bZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ; 
	
	assign data_result = (ctrl_ALUopcode == 5'b00011) ? or_buffer : 32'bZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ; 
	
endmodule