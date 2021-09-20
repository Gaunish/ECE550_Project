Group members :
1) Name : Gaunish Garg, Net ID : gg147
2) Name : Zhou Sijie, Net ID : sz232 


Adder and Subtractor (PROJECT CHECKPOINT 1)
-----------------------------------------------------------------------------------------------------------------------------------------------------

We are selecting Carry lookahead adder for adder/subtractor because:-

1)It's performance is much faster than RCA and a bit faster than CSA.
2) It's area is significantly less than CSA and bit lower than RCA.

Reference : Comparison Between Various Types of Adder Topologies Jasbir Kaur, Lalit Sood IJCST Vol. 6, Issue 1, Jan - March 2015
Link for reference : http://www.ijcst.com/vol61/1/13-Jasbir-Kaur.pdf
----------------------------------------------------------------------------------------------------------------------------------

Implementation :
1) The 32-bit adder is divided into two 16-bit adders, and each 16-bit adder is divided into four 4-bit adder.

2) There are two 16-bit adders connected in the form of Ripple Carry Adder to implement the 32-bit adder.

3) The 4-bit adders are connected in the form of CLA to implement the 16-bit adder.

4) The 16-bit adders are implemented with two-level hierarchical structure to generate the carry bit.

5) The overflow is generated based on the condition: 
   if Carry In == Carry out, overflow = 0
   else, overflow = 1

---------------------------------------------------------------------------------------------------------------------------------------------------------


Implementation of ALU (PROJECT CHECKPOINT 2)
-----------------------------------------------------------------------------------------------------------------------------------------------------

Implemented :- 1) AND
	       2) OR
  	       3) SLL (Logical left shift)
	       4) SRA (Arithmetic Right shifter)
	       5) isNotEqual
	       6) isLessThan
	       
Miscallenous : Equal gate (to compare the opcode), 2:1 Mux (for shifters)


Design Process :-  

1) Implemented all of the ALU operations in different modules (Advantages : reusability, easy maintanence)
	
2) Called all of the ALU operations one-by-one and stored the result in their respective buffers
    (We cannot call the modules conditionally (on basis of opcode) in hardware implementation)
	
3) Implemented an equal gate to select the correct operations buffer and store it in output 
    Using opcode table : 
		ADD 		: 00000
		SUBTRACT 	: 00001
		AND 		: 00010
		OR               	: 00011
		SLL(Left shift)  	: 00100
		SRA(Right shift) 	: 00101	
	
NOTE: overflow is calculated in the add_sub itself and used as output only if it's opcode is fanned-in
----------------------------------------------------------------------------------------------------------------------------------


Implementation :

1) AND : used AND gate structurally to perform AND on the operands and store the result in the output bit-by-bit 

2) OR: used OR gate structurally to perform OR on the operands and store the result in the output bit-by-bit 

	          -------------------------------------------------------------------------------

For both shifters :   a)  Used 5 layers of muxes, one layer for each select bit
	            b)  Each layer consisted of 32 2:1 mux (one for each operand bit)
	            c)  (Arbitary Notation for convenience) Divided the layers into two cases : Base case, Iterative case
	            d)  Output of one layer was used as input for the next layer, with (actual input -> Layer 0) , (Layer 5 -> Actual output) 


3) SLL (Logical Left Shift) :  
 	Base case : Notation for case where '0' is used as an input in the 2:1 mux for a layer
	Iterative case : Notation for all other cases
	For each layer, Used a for loop to implement both base case, iterative case using a 2:1 mux


4) SRA  (Arithemtic Right Shift) :  
 	Base case : Notation for case where In[31] (highest bit of the input) is used as an input in the 2:1 mux for a layer
	Iterative case : Notation for all other cases
	For each layer, Used a for loop to implement both base case, iterative case using a 2:1 mux
	           
	          -------------------------------------------------------------------------------

5) isNotEqual :
	Used Xor gates to compare two operands, then sum up the results by using Or gates to check if there's different bits.

6) isLessThan:
    Compute the isLessThan by Xor the sign-bit of result and the overflow bit.
	Because either there's overflow (positive minus negative) or the result is negative (positvie minus negative or negative minus negative).
	And, if both the sign-bit and the overflow bit are 1, which means it could be a negative number minus a positive number. 
	
----------------------------------------------------------------------------------------------------------------------------------=