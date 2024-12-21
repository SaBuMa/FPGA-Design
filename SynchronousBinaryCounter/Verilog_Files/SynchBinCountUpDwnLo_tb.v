module SynchBinCountUpDwnLo_tb
#(parameter Nbits = 4 // # of bits to used
);

//******************** Testbench Signals ********************--
//***********************************************************--
   reg clk_tb;            				
   reg rst_tb;          				
   reg ena_tb;         			 		
   reg [(Nbits-1):0]Data_tb;    		
   reg UpDwn_tb;          				
   reg Load_tb;         			 		
	wire [(Nbits-1):0]counter_tb;	

//************** Instatiating Device Under Test *************--
//***********************************************************--

// ALLowing to change the number of bits to be used
SynchBinCountUpDwnLo #(.Nbits(Nbits)) DUT(.clk(clk_tb), .rst(rst_tb),.ena(ena_tb),
												 .Data(Data_tb), .UpDwn(UpDwn_tb),.Load(Load_tb),
												 .counter(counter_tb));

// 50MHz clock generation
initial clk_tb = 0;
always #10 clk_tb = ~clk_tb;
 
initial begin

		// TEST VECTOR 1 START
		rst_tb	= 1;
		ena_tb	= 0;
		Data_tb	= 0;
		UpDwn_tb	= 0;
		Load_tb	= 0;
		#50;
		
		// TEST VECTOR 2 Nothing
		rst_tb	= 0;
		ena_tb	= 0;
		Data_tb	= 0;
		UpDwn_tb	= 0;
		Load_tb	= 0;
		#50;
		
		// TEST VECTOR 3 Up
		rst_tb	= 0;
		ena_tb	= 1;
		Data_tb	= 0;
		UpDwn_tb	= 1;
		Load_tb	= 0;
		#200;
		
		// TEST VECTOR 4 Down
		rst_tb	= 0;
		ena_tb	= 1;
		Data_tb	= 0;
		UpDwn_tb	= 0;
		Load_tb	= 0;
		#200;
		
		// TEST VECTOR 5 Load #1
		rst_tb	= 0;
		ena_tb	= 1;
		Data_tb	= 7;
		UpDwn_tb	= 0;
		Load_tb	= 1;
		#200;	
		
		// TEST VECTOR 6 Count Up From Load
		rst_tb	= 0;
		ena_tb	= 1;
		Data_tb	= 0;
		UpDwn_tb	= 1;
		Load_tb	= 0;
		#200;

		// TEST VECTOR 7 Load #2
		rst_tb	= 0;
		ena_tb	= 1;
		Data_tb	= 14;
		UpDwn_tb	= 0;
		Load_tb	= 1;
		#200;
		
		// TEST VECTOR 8 Count Down From Load
		rst_tb	= 0;
		ena_tb	= 1;
		Data_tb	= 0;
		UpDwn_tb	= 0;
		Load_tb	= 0;
		#200;
end
endmodule