//******************* Full Adder N BitS *********************--
//***********************************************************--

//**************** module = Inputs Outputs ******************--
//***********************************************************--
module FANB                	
#(parameter Nbits = 4) // #Nbits Choose your flavor
(
		input [(Nbits-1):0] A_N, B_N, 
		input Cin, 
		output Cout,		
		output [(Nbits-1):0] Qout_N
		
);
//******************* Auxiliary cables **********************--
//***********************************************************--

wire [2:0]co;			// Used in Module Instantiation
wire [Nbits:0] aux;	// Used in Generate Module

//***************** Module Instantiation ********************--
//***********************************************************--

// Instantiating each of the Full Adders needed and 
// Using wires (co) to interconnect Carry in with Carry out between modules

//FAOB faob0(.A_in(A_N[0]), .B_in(B_N[0]),.C_in(Cin),.Q_out(Qout_N[0]),.C_out(co[0]));
//FAOB faob1(.A_in(A_N[1]), .B_in(B_N[1]),.C_in(co[0]),.Q_out(Qout_N[1]),.C_out(co[1]));
//FAOB faob2(.A_in(A_N[2]), .B_in(B_N[2]),.C_in(co[1]),.Q_out(Qout_N[2]),.C_out(co[2]));
//FAOB faob3(.A_in(A_N[3]), .B_in(B_N[3]),.C_in(co[2]),.Q_out(Qout_N[3]),.C_out(Cout));

//******************** Generte Module ***********************--
//***********************************************************--

// First assign the Carry in to the auxiliary cable [0]
assign aux[0] = Cin;

// Generate Block
generate
	genvar i; 
	for (i=0; i< Nbits; i=i+1)
	begin: N_bit_Modules // It is necessary to give a name to the generate module/instance
		FAOB faob(	.A_in(A_N[i]),
						.B_in(B_N[i]),
						.C_in(aux[i]),
						.C_out(aux[i+1]), // This "i+1" is done so that each Cin recieve a Cout
						.Q_out(Qout_N[i])
					 );
	end
endgenerate

assign Cout = aux[Nbits];

//****************** Compact Description ********************--
//***********************************************************--
//
//assign {Qout_N, Cout} = A_N + B_N + Cin;

endmodule 