//********* Synchronous Binary Counter Up/Down/Load *********--
//***********************************************************--

//**************** Module Inputs and Outputs ****************--
//***********************************************************--
module SynchBinCountUpDwnLo
#(parameter Nbits = 4 							// #bits
 )
(
   input clk,            						// Clock
   input rst,          							// Reset
   input ena,         			 				// Enable
   input [(Nbits-1):0] Data,   				// Data input
   input UpDwn,          						// UpDwn = 1 Count Up
														//	UpDwn = 1 Count Down
   input Load,										//	Signal to load the registers
	output reg [(Nbits-1):0]counter			// Output as 'reg' type
); 

//******************* Auxiliary cables **********************--
//***********************************************************--

// Cables used in "Module Instantiation"
reg datain0,datain1,datain2,datain3;		// Input Aux Variables
reg enables0,enables1,enables2,enables3;	// Enables for each Register
wire qout0,qout1,qout2,qout3;					// Ouput Aux Variables
reg aux_a0,aux_a1,aux_a2,aux_a3;				// Auxiliary Variables
reg aux_b0,aux_b1,aux_b2;						// Auxiliary Variables

// Cables used in "Module Parameterization"
localparam [(Nbits-1):0]ZEROS = 0; 			// Aux Var -> Set All to Zero
reg [(Nbits-1):0]Count_next,Count_aux;		// Aux Var for counting
reg [(Nbits-1):0]reg1;							// Aux var store actual value



//***************** Module Instantiation ********************--
//***********************************************************--

//my_dff dff0(.clk(clk), .rst(rst),.ena(enables0),.d(datain0),.q(qout0));
//my_dff dff1(.clk(clk), .rst(rst),.ena(enables1),.d(datain1),.q(qout1));
//my_dff dff2(.clk(clk), .rst(rst),.ena(enables2),.d(datain2),.q(qout2));
//my_dff dff3(.clk(clk), .rst(rst),.ena(enables3),.d(datain3),.q(qout3));
//
//
//// Using the output signal 'counter' as 'reg' type
//always @(*)
//begin
//
//// Output
//	counter = {qout3,qout2,qout1,qout0};
//
//// Auxiliary Combinatorial circuits
//aux_a0 = qout0 & qout1 & ena;
//aux_a1 = (~qout0 & ~qout1 & ena);
//aux_a2 = qout0 & qout1 & qout2 & ena;
//aux_a3 = (~qout0 & ~qout1 & ~qout2 & ena);
//
//// Logic Gates to enable Up/Down count on Registers				
//	if (UpDwn == 0)
//		begin
//			aux_b0 = (~qout0 & ena);
//			aux_b1 = aux_a1;
//			aux_b2 = aux_a3;
//			
//		end
//	else
//		begin
//			aux_b0 = (qout0 & ena);
//			aux_b1 = aux_a0;
//			aux_b2 = aux_a2;
//		end
//
//// Enables for each of the registers				
//	enables0 = Load | ena;
//	
//	if (Load == 0)
//		begin
//			datain0 = ~qout0;
//			datain1 = ~qout1;
//			datain2 = ~qout2;
//			datain3 = ~qout3;
//			enables1 = aux_b0;
//			enables2 = aux_b1;
//			enables3 = aux_b2;
//			
//		end
//	else
//		begin
//			datain0 = Data[0];
//			datain1 = Data[1];
//			datain2 = Data[2];
//			datain3 = Data[3];
//			enables1 = 1'b1;
//			enables2 = 1'b1;
//			enables3 = 1'b1;
//		end
//		
//end

//****************** Module Parameterization ****************--
//***********************************************************--
always @(*)
begin
	if(rst==1)
		Count_next = ZEROS;
	else if (Load)
		Count_next = Data;
	else if (ena & UpDwn)
		Count_next = Count_aux + 1'b1;
	else if (ena & ~UpDwn)
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

//******************* FINDINGS - DOES NOT WORK **********************--
//******************* FINDINGS - DOES NOT WORK **********************--
//******************* FINDINGS - DOES NOT WORK **********************--
//******************* FINDINGS - DOES NOT WORK **********************--
//******************* FINDINGS - DOES NOT WORK **********************--
//******************* Auxiliary cables **********************--
//***********************************************************--

//reg [(Nbits-1):0]reg1,reg2;
//
//wire [(Nbits-1):0]qout;
//reg [(Nbits-1):0]datain;
//reg [(Nbits-1):0]aux_a;				// Auxiliary Variables
//reg [(Nbits-1):0]aux_b;						// Auxiliary Variables
//reg [(Nbits-1):0]enables;
//
//localparam [(Nbits-1):0]ZEROS = 0; 
//
////***************** Module Instantiation ********************--
////***********************************************************--
//
//
//my_dff dff0(.clk(clk), .rst(rst),.ena(enables[0]),.d(datain[0]),.q(qout[0]));
//my_dff dff1(.clk(clk), .rst(rst),.ena(enables[1]),.d(datain[1]),.q(qout[1]));
//my_dff dff2(.clk(clk), .rst(rst),.ena(enables[2]),.d(datain[2]),.q(qout[2]));
//my_dff dff3(.clk(clk), .rst(rst),.ena(enables[3]),.d(datain[3]),.q(qout[3]));
//
//// Using the output signal 'counter' as 'reg' type
//always @(*)
//begin
//
//// Output
//	counter = qout;
//	
//aux_a[0] = qout[0] & qout[1] & ena;
//aux_a[1] = (~qout[0] & ~qout[1] & ena);
//aux_a[2] = qout[0] & qout[1] & qout[2] & ena;
//aux_a[3] = (~qout[0] & ~qout[1] & ~qout[2] & ena);
//
//// Logic Gates to enable Up/Down count on Registe 1				
//	if (UpDwn == 0)
//		begin
//			aux_b[0] = (~qout[0] & ena);
//			aux_b[1] = aux_a[1];
//			aux_b[2] = aux_a[3];
//			
//		end
//	else
//		begin
//			aux_b[0] = (qout[0] & ena);
//			aux_b[1] = aux_a[0];
//			aux_b[2] = aux_a[2];
//		end
//
//// Enables for each of the registers				
//	enables[0] = Load | ena;
//	
//	if (Load == 0)
//		begin
//			datain[0] = ~qout[0];
//			datain[1] = ~qout[1];
//			datain[2] = ~qout[2];
//			datain[3] = ~qout[3];
//			enables[1] = aux_b[0];
//			enables[2] = aux_b[1];
//			enables[3] = aux_b[2];
//			
//		end
//	else
//		begin
//			datain[0] = Data[0];
//			datain[1] = Data[1];
//			datain[2] = Data[2];
//			datain[3] = Data[3];
//			enables[1] = 1'b1;
//			enables[2] = 1'b1;
//			enables[3] = 1'b1;
//		end
//		
//end
//******************* FINDINGS - DOES NOT WORK **********************--
//******************* FINDINGS - DOES NOT WORK **********************--
//******************* FINDINGS - DOES NOT WORK **********************--
//******************* FINDINGS - DOES NOT WORK **********************--

endmodule 