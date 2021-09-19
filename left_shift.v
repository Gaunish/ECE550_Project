module left_shift(input[31:0] in,
			  input[4:0] shift, 
			  output[31:0] out);
			
// Mux gate naming conventions : M -> Mux, L -> Layer
// For ex: M2_L3 : Mux2_Layer3
// i_L1 : iterative_Layer1
// B_L3 : base_Layer3
			
	// buffer for storing bit 0;
	wire zero_bit = 1'b0;
	
	
			
/* Layer 1			
/------------------------------------------------------------------------------------------------------------------------
*/
	
	// buffer wire to store layer 1 output
	wire[31:0] L1_op;

	// base case, 1 mux with zero_bit (0th input)
	mux_2 M1_L1(in[0], zero_bit, shift[0], L1_op[0]);
	
	//iterative cases with rest of input
	generate
		genvar i_L1;
		//starting from bit 1 due to base case
		for(i_L1 = 1; i_L1 < 32; i_L1 = i_L1 + 1) begin : description_L1
			
			//input in[i] & in[i - 1] to get the layer 1 output
			mux_2 M2_L1(in[i_L1], in[i_L1 - 1], shift[0], L1_op[i_L1]);
		
		end
	endgenerate
			
//------------------------------------------------------------------------------------------------------------------------




/* Layer 2			
/------------------------------------------------------------------------------------------------------------------------
*/
	// Here, the inputs of second layer => outputs of the first layer(L1_op)

	//buffer wire to store layer 2 output
	wire[31:0] L2_op;
	
	//base case, 2 mux with zero_bit (0th, 1st input)
	mux_2 M1_L2(L1_op[0], zero_bit, shift[1], L2_op[0]);
	mux_2 M2_L2(L1_op[1], zero_bit, shift[1], L2_op[1]);
	
	//iterative cases with rest of input
	generate
		genvar i_L2;
		//starting from bit 2 due to base case(in0, in1)
		for(i_L2 = 2; i_L2 < 32; i_L2 = i_L2 + 1) begin : description_L2
			
			//input in[i] & in[i - 2] to get the layer 2 output
			mux_2 M3_L2(L1_op[i_L2], L1_op[i_L2 - 2], shift[1], L2_op[i_L2]);
		
		end
	endgenerate 

//------------------------------------------------------------------------------------------------------------------------



/* Layer 3			
/------------------------------------------------------------------------------------------------------------------------
*/
	// Here, the inputs of third layer => outputs of the second layer(L2_op)

	//buffer wire to store layer 3 output
	wire[31:0] L3_op;
	
	//base case, 4 mux with zero_bit & bit(0-3) (4 bits)
	generate
		genvar B_L3;
	
		for(B_L3 = 0; B_L3 < 4; B_L3 = B_L3 + 1) begin : description_B3
			
			//input in[i] & zero_bit to get the layer 3 output
			mux_2 M1_L3(L2_op[B_L3], zero_bit, shift[2], L3_op[B_L3]);
		
		end
	endgenerate 

	
	
	//iterative cases with rest of input
	generate
		genvar i_L3;
		//starting from bit 4 due to base case in(0-3)
		for(i_L3 = 4; i_L3 < 32; i_L3 = i_L3 + 1) begin : description_L3
			
			//input in[i] & in[i - 4] to get the layer 3 output
			mux_2 M2_L3(L2_op[i_L3], L2_op[i_L3 - 4], shift[2], L3_op[i_L3]);
		
		end
	endgenerate 

//------------------------------------------------------------------------------------------------------------------------



/* Layer 4			
/------------------------------------------------------------------------------------------------------------------------
*/
	// Here, the inputs of fourth layer => outputs of the third layer(L3_op)

	//buffer wire to store layer 4 output
	wire[31:0] L4_op;
	
	//base case, 8 mux with zero_bit & bit(0-7) (8 bits)
	generate
		genvar B_L4;
	
		for(B_L4 = 0; B_L4 < 8; B_L4 = B_L4 + 1) begin : description_B4
			
			//input in[i] & zero_bit to get the layer 4 output
			mux_2 M1_L4(L3_op[B_L4], zero_bit, shift[3], L4_op[B_L4]);
		
		end
	endgenerate 

	
	
	//iterative cases with rest of input
	generate
		genvar i_L4;
		//starting from bit 8 due to base case in(0-7)
		for(i_L4 = 8; i_L4 < 32; i_L4 = i_L4 + 1) begin : description_L4
			
			//input in[i] & in[i - 8] to get the layer 4 output
			mux_2 M2_L4(L3_op[i_L4], L3_op[i_L4 - 8], shift[3], L4_op[i_L4]);
		
		end
	endgenerate 

//------------------------------------------------------------------------------------------------------------------------



/* Layer 5		
/------------------------------------------------------------------------------------------------------------------------
*/
	// Here, the inputs of fifth layer => outputs of the fourth layer(L4_op)

	//Actual fan-out wire, out is used
	
	//base case, 16 mux with zero_bit & bit(0-15) (16 bits)
	generate
		genvar B_L5;
	
		for(B_L5 = 0; B_L5 < 16; B_L5 = B_L5 + 1) begin : description_B5
			
			//input in[i] & zero_bit to get the layer 4 output
			mux_2 M1_L5(L4_op[B_L5], zero_bit, shift[4], out[B_L5]);
		
		end
	endgenerate 

	
	
	//iterative cases with rest of input
	generate
		genvar i_L5;
		//starting from bit 16 due to base case in(0-15)
		for(i_L5 = 16; i_L5 < 32; i_L5 = i_L5 + 1) begin : description_L5
			
			//input in[i] & in[i - 16] to get the actual output
			mux_2 M2_L5(L4_op[i_L5], L4_op[i_L5 - 16], shift[4], out[i_L5]);
		
		end
	endgenerate 

//------------------------------------------------------------------------------------------------------------------------


endmodule