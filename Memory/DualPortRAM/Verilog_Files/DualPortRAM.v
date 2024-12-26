//********************* Single Port RAM *********************--
//***********************************************************--

//**************** Module Inputs and Outputs ****************--
//***********************************************************--
module DualPortRAM 
#(
  parameter Data_Width = 8, // Size of the data to be written in memory
            Addr_Width = 2  // Size of the memory address
)
(  
    input wire clk,										// Clock Input
    input wire wr_ena,								   // Write/Read Enable
    input wire [(Addr_Width-1):0] Wr_addr, 		// Address to write
	 input wire [(Addr_Width-1):0] Re_addr, 		// Address to read
    input wire [(Data_Width-1):0] Data_write,	// Data to be written
    output wire [(Data_Width-1):0] Data_read		// Data read from memory
);

//******************* Auxiliary cables **********************--
//***********************************************************--
reg [(Addr_Width-1):0] addr_reg;

reg [(Data_Width-1):0] ram [0:(2**Addr_Width-1)];
//reg [(Data_Width-1):0] ram [0:((2**Addr_Width)-1)]; // This is how quartus does the ** operation

initial
begin
    $readmemh("DualPortRAM.mif", ram);
end

//****************** Module Parameterization ****************--
//***********************************************************--
always@(posedge clk)
	begin
		if(wr_ena == 1)
			ram[Wr_addr] <= Data_write;
		addr_reg <= Re_addr;
	end
	
assign Data_read = ram[addr_reg];


////////Letter0////Letter1////Letter2////Letter3////
//--------------------------------------------------
//Word0/-Value-////-Value-////-Value-////-Value-////
//--------------------------------------------------
//Word1/-Value-////-Value-////-Value-////-Value-////
endmodule 