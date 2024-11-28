//******************* Comparator One Bit ********************--
//***********************************************************--

//**************** Module Inputs and Outputs ****************--
//***********************************************************--
module CNB
#(parameter Nbits = 4) // #Nbits Choose your flavor
 (	
	input [(Nbits-1):0]A_N,B_N,
	
//	output reg AeqB_N, AgrtB_N, AlwrB_N // Use this line in combination with
													// The "always" block
									
	output AeqB_N, AgrtB_N, AlwrB_N 		// Used this line in combination with
													// The "assign" expression

// AeqB_N -> A = B // AgrtB_N -> A > B // AlwrB_N -> A < B
 );

//******************* Auxiliary cables **********************--
//***********************************************************--

wire [(Nbits-1):0]e0,e1,e2;

//***************** Module Instantiation ********************--
//***********************************************************--

// Instantiating each of the Comparators to be used and 
// Using wires (aux) to interconnect Carry in with Carry out between modules
//
//COB COB0(.A_in(A_N[0]), .B_in(B_N[0]),.AlwrB(e0[0]),.AgrtB(e1[0]),.AeqB(e2[0]));
//COB COB1(.A_in(A_N[1]), .B_in(B_N[1]),.AlwrB(e0[1]),.AgrtB(e1[1]),.AeqB(e2[1]));
//COB COB2(.A_in(A_N[2]), .B_in(B_N[2]),.AlwrB(e0[2]),.AgrtB(e1[2]),.AeqB(e2[2]));
//COB COB3(.A_in(A_N[3]), .B_in(B_N[3]),.AlwrB(e0[3]),.AgrtB(e1[3]),.AeqB(e2[3]));
//
//assign AlwrB_N = | e0;
//assign AgrtB_N = | e1;
//assign AeqB_N = & e2;


//******************** Generte Module ***********************--
//***********************************************************--

// Generate Block
generate
	genvar i; 
	for (i=0; i< Nbits; i=i+1)
	begin: N_bit_Modules // It is necessary to give a name to the generate module/instance
		COB COB(	.A_in(A_N[i]),
					.B_in(B_N[i]),
					.AlwrB(e0[i]),
					.AgrtB(e1[i]), // This "i+1" is done so that each Cin recieve a Cout
					.AeqB(e2[i])
				 );
	end
endgenerate

assign AlwrB_N = | e0;
assign AgrtB_N = | e1;
assign AeqB_N = & e2;


//************* Compact description of Adder ****************--
//***********************************************************--

// Other Options, but only functional when output is of type "reg"     		
//                   	          	
//always @(A_N or B_N)
//	begin: COMPARE
//		AlwrB_N = (A_N < B_N);
//		AgrtB_N = (A_N > B_N);
//		AeqB_N = (A_N == B_N);
//	end
//
//assign AlwrB_N = (A_N < B_N);
//assign AgrtB_N = (A_N > B_N);
//assign AeqB_N = (A_N == B_N);
	
endmodule 
