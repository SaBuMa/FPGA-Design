module SinglePortRAM_tb
#(
  parameter Data_Width = 8, // Size of the data to be written in memory
            Addr_Width = 2  // Size of the memory address
);

//******************** Testbench Signals ********************--
//***********************************************************--
   reg clk_tb;            				
   reg wr_rd_ena_tb;          				    			 		
   reg [(Addr_Width-1):0] addr_tb;    		
   reg [(Data_Width-1):0] Data_write_tb;          				      			 		
	wire [(Data_Width-1):0] Data_read_tb;	
	
//************** Instatiating Device Under Test *************--
//***********************************************************--


// ALLowing to change the number of bits to be used
SinglePortRAM #(.Data_Width(Data_Width),.Addr_Width(Addr_Width)) 
					DUT(.clk(clk_tb), .wr_rd_ena(wr_rd_ena_tb),.addr(addr_tb),
						 .Data_write(Data_write_tb), .Data_read(Data_read_tb));

// 50MHz clock generation
initial clk_tb = 1;
always #10 clk_tb = ~clk_tb;// 50MHz clock generation 
									 // Every 20 ns one full cycle
initial begin
// Two clock cycles to read and/or write

	//Reading the memory
		// TEST VECTOR 1 Read pos#0
		wr_rd_ena_tb	= 1'b0;
		addr_tb			= 2'b00;
		Data_write_tb	= 8'b00000000;
		#40;
		
		// TEST VECTOR 2 Read pos#1
		wr_rd_ena_tb	= 1'b0;
		addr_tb			= 2'b01;
		Data_write_tb	= 8'b00000000;
		#40;
		
		// TEST VECTOR 3 Read pos#2
		wr_rd_ena_tb	= 1'b0;
		addr_tb			= 2'b10;
		Data_write_tb	= 8'b00000000;
		#40;
		
		// TEST VECTOR 4 Read pos#3
		wr_rd_ena_tb	= 1'b0;
		addr_tb			= 2'b11;
		Data_write_tb	= 8'b00000000;
		#40;

////////////////////////////////////////////////////////////
			
	// Writting to the memory	
		// TEST VECTOR 5 Write pos#0
		wr_rd_ena_tb	= 1'b1;
		addr_tb			= 2'b00;
		Data_write_tb	= 8'b00000110;
		#40;	
		
		// TEST VECTOR 6 Write pos#1
		wr_rd_ena_tb	= 1'b1;
		addr_tb			= 2'b01;
		Data_write_tb	= 8'b00000101;
		#40;

		// TEST VECTOR 7 Write pos#2
		wr_rd_ena_tb	= 1'b1;
		addr_tb			= 2'b10;
		Data_write_tb	= 8'b00000100;
		#40;
		
		// TEST VECTOR 8 Write pos#3
		wr_rd_ena_tb	= 1'b1;
		addr_tb			= 2'b11;
		Data_write_tb	= 8'b00000011;
		#40;
		
////////////////////////////////////////////////////////////
		
	// Reading what was written
		// TEST VECTOR 9 Read pos#0
		wr_rd_ena_tb	= 1'b0;
		addr_tb			= 2'b00;
		Data_write_tb	= 8'b00000000;
		#40;
		
		// TEST VECTOR 10 Read pos#1
		wr_rd_ena_tb	= 1'b0;
		addr_tb			= 2'b01;
		Data_write_tb	= 8'b00000000;
		#40;
		
		// TEST VECTOR 11 Read pos#2
		wr_rd_ena_tb	= 1'b0;
		addr_tb			= 2'b10;
		Data_write_tb	= 8'b00000000;
		#40;
		
		// TEST VECTOR 12 Read pos#3
		wr_rd_ena_tb	= 1'b0;
		addr_tb			= 2'b11;
		Data_write_tb	= 8'b00000000;
		#40;
end
endmodule