module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

/* variable declaration
/------------------------------------------------------------------------------------------------------------------------
*/
   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;
	
//------------------------------------------------------------------------------------------------------------------------


/* Design Process :-
		
	1) Implemented all of the ALU operations in different modules (Advantages : reusability, easy maintanence)
	
	2) Called all of the ALU operations one-by-one and stored the result in their respective buffers
		(We cannot call module conditionally (on basis of opcode) in hardware)
	
	3) Implemented  an equal gate to select the correct operations buffer and store it in output
	
	NOTE: overflow is calculated in the add_sub itself and used as output only if it's opcode is fanned-in
*/


/* Implementation (Step 2 -> Calling all the ALU operations and storing the result in their buffers)
/------------------------------------------------------------------------------------------------------------------------
*/

	/* Design for adder/subtractor :-
		1) Add and subtract the two 32-bit input data via same module based on the opcode
		2) Opcode is fanned-in as an input to the module
		3) Based on the opcode, second operand is 2s complemented for the subtraction 
	*/
	
	// Calling the addition/Subtraction module
	// sum_buffer -> storing sum, overflow_sum_buffer -> storing overflow (if any)
	wire [31:0] sum_buffer;
	wire overflow_sum_buffer;
	add_sub Add_Sub1(data_operandA, data_operandB, ctrl_ALUopcode, sum_buffer, overflow_sum_buffer,isNotEqual,isLessThan);

	// Calling the AND module
	// and_buffer -> storing the AND(ed) output
	wire[31:0] and_buffer;
	and_op And_op1(data_operandA, data_operandB, and_buffer);
	
	// Calling the AND module
	// or_buffer -> storing the OR(ed) output
	wire[31:0] or_buffer;
	or_op Or_op1(data_operandA, data_operandB, or_buffer);
	
	// Calling the logical Left shift module
	// left_buffer -> storing the left shifted output
	wire[31:0] left_buffer;
	left_shift Left1(data_operandA, ctrl_shiftamt, left_buffer);

	// Calling the arithmetic Right shift module
	// right_buffer -> storing the right shifted output
	wire[31:0] right_buffer;
	right_shift Right1(data_operandA, ctrl_shiftamt, right_buffer);

//------------------------------------------------------------------------------------------------------------------------



/* Selecting the output on basis of ctrl_ALUopcode (using self-implemented equal gate) (Step 3)
/------------------------------------------------------------------------------------------------------------------------
*/
	/* Opcode Table:
	
		ADD 				  : 00000
		SUBTRACT 		  : 00001
		AND 				  : 00010
		OR               : 00011
		SLL(Left shift)  : 00100
		SRA(Right shift) : 00101
	
	*/
	
	// NOTE: Z -> (High impedance state / undefined bit)
	
	// buffer wire to store the result after comparing the actual opcode to each possible opcode 
	wire[5:0] select_buffer;
	
	// ADD MODULE
	// Checking if the fanned-in opcode is for addition
	equal E1(ctrl_ALUopcode, 5'b00000, select_buffer[0]);
	assign overflow = select_buffer[0] ? overflow_sum_buffer : 1'bZ ;
	assign data_result = select_buffer[0] ? sum_buffer : 32'bZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ; 
	
	// SUBTRACTION MODULE
	// Checking if the fanned-in opcode is for subtraction
	equal E2(ctrl_ALUopcode, 5'b00001, select_buffer[1]);
	assign overflow = select_buffer[1] ? overflow_sum_buffer : 1'bZ ;
	assign data_result = select_buffer[1] ? sum_buffer : 32'bZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ; 
	
	// AND MODULE
	// Checking if the fanned-in opcode is for (and implementation)
	equal E3(ctrl_ALUopcode, 5'b00010, select_buffer[2]);
	assign data_result = select_buffer[2] ? and_buffer : 32'bZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ; 
	
	// OR MODULE
	// Checking if the fanned-in opcode is for (or implementation)
	equal E4(ctrl_ALUopcode, 5'b00011, select_buffer[3]);
	assign data_result = select_buffer[3] ? or_buffer : 32'bZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ; 
	
	// LOGICAL LEFT SHIFT MODULE
	// Checking if the fanned-in opcode is for shifting left logically
	equal E5(ctrl_ALUopcode, 5'b00100, select_buffer[4]);
	assign data_result = select_buffer[4] ? left_buffer : 32'bZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ; 
	
	// ARITHMETIC RIGHT SHIFT MODULE
	// Checking if the fanned-in opcode is for shifting right arithmetically
	equal E6(ctrl_ALUopcode, 5'b00101, select_buffer[5]);
	assign data_result = select_buffer[5] ? right_buffer : 32'bZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ; 

//------------------------------------------------------------------------------------------------------------------------

	
endmodule