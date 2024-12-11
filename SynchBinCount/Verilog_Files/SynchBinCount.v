//************** Synchronous Binary Counter Up **************--
//***********************************************************--

//**************** Module Inputs and Outputs ****************--
//***********************************************************--
module SynchBinCount
#(parameter Nbits = 4 // #bits
 )
(
   input clk,            				// Clock
   input rst,          					// Reset
   input ena,         			 		// Enable
	output reg [(Nbits-1):0]counter	// Output as 'reg' type
//	output [(Nbits-1):0]counter		//  Output as 'net' type
); 

//******************* Auxiliary cables **********************--
//***********************************************************--

reg [(Nbits-1):0]reg1,reg2;
wire e0,e1;
wire [(Nbits-1):0]qout;

localparam [(Nbits-1):0]ZEROS = 0; 

//***************** Module Instantiation ********************--
//***********************************************************--

my_dff dff0(.clk(clk), .rst(rst),.ena(ena),.d(~qout[0]),.q(qout[0]));
my_dff dff1(.clk(clk), .rst(rst),.ena(qout[0]),.d(~qout[1]),.q(qout[1]));
my_dff dff2(.clk(clk), .rst(rst),.ena(e0),.d(~qout[2]),.q(qout[2]));
my_dff dff3(.clk(clk), .rst(rst),.ena(e1),.d(~qout[3]),.q(qout[3]));


assign e0 = qout[0] & qout[1];
assign e1 = qout[0] & qout[1] & qout[2];

// Using the output signal 'counter' as 'net' type
	//assign counter = qout; 

// Using the output signal 'counter' as 'reg' type
	always @(*)
		begin
			counter = qout;
		end

//****************** Module Parameterization ****************--
//***********************************************************--
//always @(posedge clk)
//begin
//	if(rst==1)
//		reg1 = ZEROS;
//	else if (clk)
//		if (ena == 1)
//			reg1 =  reg2 + 1;
//		else
//			reg1 = reg2;
//			
//	counter	= reg1;
//	reg2 		= reg1;	
//end

endmodule 