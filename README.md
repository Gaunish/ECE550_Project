# addsub-base

Group members :

1) Name : Gaunish Garg, Net ID : gg147
2) Name : Zhou Sijie, Net ID : sz232 

------------------------------------------------------------------------------------------------
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