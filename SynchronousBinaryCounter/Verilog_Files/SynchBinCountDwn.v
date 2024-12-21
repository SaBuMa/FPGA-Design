//************* Synchronous Binary Counter Down *************--
//***********************************************************--

//**************** Module Inputs and Outputs ****************--
//***********************************************************--
module SynchBinCountDwn
#(parameter Nbits = 4 							// # of bits to used
 )
(
   input clk,            						// Clock Input
   input rst,          							// Reset Input
   input ena,         			 				// Enable Input
	output reg [(Nbits-1):0]counter			// Data Output
); 

//******************* Auxiliary cables **********************--
//***********************************************************--

// Cables used in "Module Instantiation"
reg enables0,enables1,enables2,enables3;	// Enables for each Register
wire qout0,qout1,qout2,qout3;					// Ouput Aux Variables

// Cables used in "Module Parameterization"
localparam [(Nbits-1):0]ZEROS = 0; 			// Aux Var -> Set All to Zero
reg [(Nbits-1):0]Count_next,Count_aux;		// Aux Var for counting
reg [(Nbits-1):0]reg1;							// Aux var store actual value

//***************** Module Instantiation ********************--
//***********************************************************--

//my_dff dff0(.clk(clk), .rst(rst),.ena(enables0),.d(~qout0),.q(qout0));
//my_dff dff1(.clk(clk), .rst(rst),.ena(enables1),.d(~qout1),.q(qout1));
//my_dff dff2(.clk(clk), .rst(rst),.ena(enables2),.d(~qout2),.q(qout2));
//my_dff dff3(.clk(clk), .rst(rst),.ena(enables3),.d(~qout3),.q(qout3));
//
//always @(*)
//	begin
//	
//	// Output
//		counter = {qout3,qout2,qout1,qout0};
//		
//	// Combinatorial Logic
//		enables0 = ena;
//		enables1 = ~qout0 & ena;
//		enables2 = ~qout0 & ~qout1 & ena;
//		enables3 = ~qout0 & ~qout1 & ~qout2 & ena;
//	end

//****************** Module Parameterization ****************--
//***********************************************************--
always @(*)
begin
	if(rst==1)
		Count_next = ZEROS;
	else if (ena)
		Count_next = Count_aux - 1'b1;
	else
		Count_next = Count_aux;
		
end

always @(posedge clk, posedge rst)
begin
	if(rst)
		reg1 = ZEROS;
	else if (clk)
		if (ena)
				reg1 =  Count_next;		
	counter		= reg1;
	Count_aux 	= reg1;	
end

endmodule 