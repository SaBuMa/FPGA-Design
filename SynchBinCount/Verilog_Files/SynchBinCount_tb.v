module SynchBinCount_tb
#(parameter Nbits = 4 // #bits
);
   reg clk_tb;            				// Clock
   reg rst_tb;          				// Reset
   reg ena_tb;         			 		// Enable
	wire [(Nbits-1):0]counter_tb;	// Output as 'reg' type

// 50MHz clock generation
initial clk_tb = 0;
always #10 clk_tb = ~clk_tb;

SynchBinCount DUT(.clk(clk_tb), .rst(rst_tb),.ena(ena_tb),.counter(counter_tb));

	
initial begin

		// TEST VECTOR 1
		rst_tb	= 1;
		ena_tb	= 0;
		#50;
		
		// TEST VECTOR 2
		rst_tb	  <= 0;
		ena_tb	  <= 1;
		#200;
		
		// TEST VECTOR 3
		rst_tb	  <= 0;
		ena_tb	  <= 1;
		#200;
		
		// TEST VECTOR 4
		rst_tb	  <= 0;
		ena_tb	  <= 1;
		#200;	
		
		// TEST VECTOR 5
		rst_tb	  <= 0;
		ena_tb	  <= 1;
		#200;
end
endmodule