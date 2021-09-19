module right_shift(input[31:0] in, 
			  input[4:0] shift, 
			  output[31:0] out);
			  
// Mux gate naming conventions : M -> Mux, L -> Layer
// For ex: M2_L3 : Mux2_Layer3
// i_L1 : iterative_Layer1
// B_L3 : base_Layer3
			
	// buffer for storing the highest input bit;
	wire shift_bit = in[31];
	

/* Layer 1			
/------------------------------------------------------------------------------------------------------------------------
*/
	
	// buffer wire to store layer 1 output
	wire[31:0] L1_op;

	// base case, 1 mux with shift_bit (31st input)
	mux_2 M1_L1(in[31], shift_bit, shift[0], L1_op[31]);
	
	//iterative cases with rest of input
	generate
		genvar i_L1;
		//starting from bit 30 due to base case
		for(i_L1 = 30; i_L1 >= 0; i_L1 = i_L1 - 1) begin : description_L1
			
			//input in[i] & in[i + 1] to get the layer 1 output
			mux_2 M2_L1(in[i_L1], in[i_L1 + 1], shift[0], L1_op[i_L1]);
		
		end
	endgenerate
			
//------------------------------------------------------------------------------------------------------------------------


/* Layer 2			
/------------------------------------------------------------------------------------------------------------------------
*/
	// Here, the inputs of second layer => outputs of the first layer(L1_op)

	//buffer wire to store layer 2 output
	wire[31:0] L2_op;
	
	//base case, 2 mux with shift_bit (31st, 30th input)
	mux_2 M1_L2(L1_op[31], shift_bit, shift[1], L2_op[31]);
	mux_2 M2_L2(L1_op[30], shift_bit, shift[1], L2_op[30]);
	
	//iterative cases with rest of input
	generate
		genvar i_L2;
		//starting from bit 29 due to base case(in30, in31)
		for(i_L2 = 29; i_L2 >= 0; i_L2 = i_L2 - 1) begin : description_L2
			
			//input in[i] & in[i + 2] to get the layer 2 output
			mux_2 M3_L2(L1_op[i_L2], L1_op[i_L2 + 2], shift[1], L2_op[i_L2]);
		
		end
	endgenerate 

//------------------------------------------------------------------------------------------------------------------------

/* Layer 3			
/------------------------------------------------------------------------------------------------------------------------
*/
	// Here, the inputs of third layer => outputs of the second layer(L2_op)

	//buffer wire to store layer 3 output
	wire[31:0] L3_op;
	
	//base case, 4 mux with zero_bit & bit(31-28) (4 bits)
	generate
		genvar B_L3;
	
		for(B_L3 = 31; B_L3 >= 28; B_L3 = B_L3 - 1) begin : description_B3
			
			//input in[i] & shift_bit to get the layer 3 output
			mux_2 M1_L3(L2_op[B_L3], shift_bit, shift[2], L3_op[B_L3]);
		
		end
	endgenerate 

	
	
	//iterative cases with rest of input
	generate
		genvar i_L3;
		//starting from bit 27 due to base case in(31-28)
		for(i_L3 = 27; i_L3 >= 0; i_L3 = i_L3 - 1) begin : description_L3
			
			//input in[i] & in[i + 4] to get the layer 3 output
			mux_2 M2_L3(L2_op[i_L3], L2_op[i_L3 + 4], shift[2], L3_op[i_L3]);
		
		end
	endgenerate 

//------------------------------------------------------------------------------------------------------------------------


/* Layer 4			
/------------------------------------------------------------------------------------------------------------------------
*/
	// Here, the inputs of fourth layer => outputs of the third layer(L3_op)

	//buffer wire to store layer 4 output
	wire[31:0] L4_op;
	
	//base case, 8 mux with zero_bit & bit(31-24) (8 bits)
	generate
		genvar B_L4;
	
		for(B_L4 = 31; B_L4 >= 24; B_L4 = B_L4 - 1) begin : description_B4
			
			//input in[i] & shift_bit to get the layer 4 output
			mux_2 M1_L4(L3_op[B_L4], shift_bit, shift[3], L4_op[B_L4]);
		
		end
	endgenerate 

	
	
	//iterative cases with rest of input
	generate
		genvar i_L4;
		//starting from bit 23 due to base case in(31-24)
		for(i_L4 = 23; i_L4 >= 0; i_L4 = i_L4 - 1) begin : description_L4
			
			//input in[i] & in[i + 8] to get the layer 4 output
			mux_2 M2_L4(L3_op[i_L4], L3_op[i_L4 + 8], shift[3], L4_op[i_L4]);
		
		end
	endgenerate 

//------------------------------------------------------------------------------------------------------------------------



/* Layer 5		
/------------------------------------------------------------------------------------------------------------------------
*/
	// Here, the inputs of fifth layer => outputs of the fourth layer(L4_op)

	//Actual fan-out wire, out is used
	
	//base case, 16 mux with zero_bit & bit(31-16) (16 bits)
	generate
		genvar B_L5;
	
		for(B_L5 = 31; B_L5 >= 16; B_L5 = B_L5 - 1) begin : description_B5
			
			//input in[i] & shift_bit to get the layer 4 output
			mux_2 M1_L5(L4_op[B_L5], shift_bit, shift[4], out[B_L5]);
		
		end
	endgenerate 

	
	
	//iterative cases with rest of input
	generate
		genvar i_L5;
		//starting from bit 15 due to base case in(31-16)
		for(i_L5 = 15; i_L5 >= 0; i_L5 = i_L5 - 1) begin : description_L5
			
			//input in[i] & in[i + 16] to get the actual output
			mux_2 M2_L5(L4_op[i_L5], L4_op[i_L5 + 16], shift[4], out[i_L5]);
		
		end
	endgenerate 

//------------------------------------------------------------------------------------------------------------------------


endmodule
			  
