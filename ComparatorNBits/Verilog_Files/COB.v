//******************* Comparator One Bit ********************--
//***********************************************************--

//**************** Module Inputs nad Outputs ****************--
//***********************************************************--
module COB
 (	
	input A_in,B_in,
	
//	output reg AeqB, AgrtB, AlwrB // Use this line in combination with
											// The "always" block
									
	output AeqB, AgrtB, AlwrB 		// Used this line in combination with
											// The "assign" expression

// AeqB -> A = B // AgrtB -> A > B // AlwrB -> A < B
 );

//******************* Auxiliary cables **********************--
//***********************************************************--

//wire e0,e1;

//******************** Module Description *******************--
//***********************************************************--

// Auxiliary Equations
assign e0 = (!A_in) & B_in;
assign e1 = (!B_in) & A_in;


// Using the output as a "net" type

assign	 AlwrB = e0;
assign	 AgrtB = e1;
assign	 AeqB = e0 ~^ e1;


//************* Compact description of Adder ****************--
//***********************************************************--

// Other Options, but only functional when output is of type "reg"     		
                   	          	
//always @(A_in or B_in)
//	begin: COMPARE
//		AlwrB = (A_in < B_in);
//		AgrtB = (A_in > B_in);
//		AeqB = (A_in == B_in);
//	end

//assign AlwrB = (A_in < B_in);
//assign AgrtB = (A_in > B_in);
//assign AeqB = (A_in == B_in);

endmodule 