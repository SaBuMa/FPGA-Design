module SynchBinCount_tb
#(parameter Nbits = 4 // # of bits to used
);

//******************** Testbench Signals ********************--
//***********************************************************--
   reg clk_tb;            				
   reg rst_tb;          				
   reg ena_tb;         			 		
	wire [(Nbits-1):0]counter_tb;		

//************** Instatiating Device Under Test *************--
//***********************************************************--

// ALLowing to change the number of bits to be used
SynchBinCountUp #(.Nbits(Nbits)) DUT(.clk(clk_tb), .rst(rst_tb),.ena(ena_tb),.counter(counter_tb));


// 50MHz clock generation
initial clk_tb = 0;
always #10 clk_tb = ~clk_tb;

//************** Input Test Signals Generation **************--
//***********************************************************--	
initial begin

		// TEST VECTOR 1 START
		rst_tb	= 1;
		ena_tb	= 0;
		#50;
		
		// TEST VECTOR 2 Nothing
		rst_tb	= 0;
		ena_tb	= 0;
		#50;
		
		// TEST VECTOR 3 Count
		rst_tb	  <= 0;
		ena_tb	  <= 1;
		#200;
		
		// TEST VECTOR 4 Count
		rst_tb	  <= 0;
		ena_tb	  <= 1;
		#200;
		
		// TEST VECTOR 5 Count
		rst_tb	  <= 0;
		ena_tb	  <= 1;
		#200;	
		
		// TEST VECTOR 6 Count
		rst_tb	  <= 0;
		ena_tb	  <= 1;
		#200;
end
endmodule