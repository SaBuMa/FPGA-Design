//******************* Full Adder One Bit ********************--
//***********************************************************--

//**************** Module Inputs nad Outputs ****************--
//***********************************************************--
module FAOB
 (	input A_in,B_in,C_in,
//	output reg Q_out, C_out // Use this line in combination with
									// The "always" block
									
	output Q_out, C_out		// Used this line in combination with
									// The "assign" expression
 );

//******************* Auxiliary cables **********************--
//***********************************************************--

wire e1,e2,e3;

//******************** Module Description *******************--
//***********************************************************--
assign e1 = A_in ^ B_in;
assign e2 = A_in & B_in;
assign e3 = e1 & C_in;

// Using the output as "reg" type
//always @ (e1, e2, e3, C_in)
//	begin
//	 Q_out = e1 ^ C_in;
//	 
//	 C_out = e3 | e2;
//	end

// Using the output as a "net" type
assign	 Q_out = e1 ^ C_in;
assign	 C_out = e3 | e2;


//************* Compact description of Adder ****************--
//***********************************************************--
 
//assign {C_out, Q_out} = A_in + B_in + C_in;

endmodule 