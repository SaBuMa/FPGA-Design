# FIFO (First IN First Out) Buffer
* For this scenario, a **FIFO** that ***Writes*** and ***Reads*** from an specific ***Address*** is being implemented using **Parameterization**.  

 * Then through the use of **Quartus**, the circuit is going to be coded both in **VHDL** and **Verilog** languages.
    * With the use of Quartus one can check the VHDL or Verilog code implementation does in fact recreate the circuit in question looking at the **RTL model** created by Quartus.  

* Finally to verify that the **RAM** is working as expected a **testbench** and simulation in **Questa** is done. 

## Block Diagrams
<p align="center">
    <b>  
        FIFO Block Diagram  
    </b>
</p>
<p align="Center">
    <kbd>
        <img src="FIFO_Img/FIFO_Block.svg" alt="Block Dia" width="580" />
    </kbd>
</p>

## Hardware used
<p align="center">
    <b>  
        FPGA DE10-Lite  
    </b>
</p>
<p align="center">
    <kbd>
        <img src="../../FPGA_PrjImg/FPGA1.JPG" alt="FPGA BOX" width="250"/> 
    </kbd>
    <kbd>
        <img src="../../FPGA_PrjImg/FPGA2.JPG" alt="FPGA Board" width="250"/> 
    </kbd>
</p>

## Software used
<p>
    <b>  
        Design Software  
    </b>
</p>
<p align="center">
    <kbd>
        <img src="../../FPGA_PrjImg/Quartus.png" alt="QuartusPrime" width="100"/> 
    </kbd>
<p align ="center" >
    <i>
         Quartus --> Design / Synthesis / FPGA Support.
    </i>
</p>
<p>
    <b>  
        Simulation Software
    </b>
</p>
<p align="center">
    <kbd>
        <img src="../../FPGA_PrjImg/Questa.png" alt="Questa" width="100"/>  
    </kbd>
</p>
<p align="center">
  <i>
        Mentor Graphics Questa (Modelsim) --> Functional Timing.
  </i>
</p>

## [VHDL Dual Port RAM](VHDL_Files)
For the code, **VHDL 2008** was used in order to allow comments using "--"  
```
--*********************** FIFO Buffer ***********************--
--***********************************************************--

--******************* LIBRARY DEFINITION ********************--
--***********************************************************--
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

--***************** ENITY = Inputs Outputs ******************--
--***********************************************************--
ENTITY FIFO IS
	GENERIC (DATA_WIDTH: integer :=4;	-- Size of the data to be written in memory
				ARRAY_LENGTH: integer:=8); -- Size of the memory address
	PORT(		
		clk 					: IN STD_LOGIC;
		rst					: IN STD_LOGIC;
		rd_ena				: IN STD_LOGIC;
		wr_ena				: IN STD_LOGIC;
		data_write			: IN STD_LOGIC_VECTOR (DATA_WIDTH-1 DOWNTO 0);
		empty					: OUT STD_LOGIC;
		full					: OUT STD_LOGIC;
		data_read			: OUT STD_LOGIC_VECTOR (DATA_WIDTH-1 DOWNTO 0);
		r_addr_next_s		: OUT STD_LOGIC_VECTOR (ARRAY_LENGTH-1 DOWNTO 0)
);
END ENTITY FIFO;

ARCHITECTURE arch OF FIFO IS

--******************* Auxiliary cables **********************--
--***********************************************************--

	SIGNAL WrAddr_aux 				: STD_LOGIC_VECTOR (ARRAY_LENGTH-1 DOWNTO 0); -- Write Address
	SIGNAL ReAddr_aux					: STD_LOGIC_VECTOR (ARRAY_LENGTH-1 DOWNTO 0); -- Read Address
	SIGNAL Wr_aux						: STD_LOGIC; -- Auxiliary cable for write enable
	SIGNAL full_aux					: STD_LOGIC; -- Auxiliary cable for full buffer signal

	TYPE mem_2d_type IS ARRAY(0 TO 2**ARRAY_LENGTH-1) OF STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);-- declaracion del tamaño/longitud del buffer y del tamaño de datos de cada posicion
	SIGNAL reg_file : mem_2d_type;	
	
BEGIN

--Declaracion logica para habilitar la escritura en el register file
Wr_aux<= (wr_ena AND (NOT full_aux));

--Señal que indica si el buffer esta lleno o no
full 	<= full_aux;

------------------------------------
-- Control Block Buffer FIFO 
control_fifo: ENTITY work.fifo_ctrl
		PORT MAP(
		
		clk 			=>clk,			
		rst			=>rst,
		rd_ena		=>rd_ena,			
		wr_ena		=>wr_ena,			
		empty			=>empty,			
		full			=>full_aux,			
		w_addr		=>WrAddr_aux,			
		r_addr		=>ReAddr_aux,			
		r_addr_next =>r_addr_next_s
		);
		
------------------------------------		
-- Register File Buffer FIFO	
	WRITE_PROCESS: PROCESS (clk, Wr_aux, WrAddr_aux, data_write)
	BEGIN 
		IF (rising_edge(clk)) THEN
		--WRITE
			IF (Wr_aux = '1') THEN
				reg_file(to_integer(unsigned(WrAddr_aux)))<= data_write;
			END IF;
		END IF;
	END PROCESS;

	READ_PROCESS: PROCESS (rd_ena, reg_file, ReAddr_aux)
	BEGIN 
	--READ
		IF (rd_ena='1') THEN
			data_read<=reg_file(to_integer(unsigned(ReAddr_aux)));
		ELSE
			data_read <= (OTHERS => '0');
		END IF;
	END PROCESS;
END ARCHITECTURE arch;
```
[comment]: <> (To make a reference to a parent folder, used when the images are within a parent folder od the Readme.md file one must use ".." as represented below)
### VHDL RTL
**1.** This image represent the **FIFO** being Parameterized
<p align="center">
    <kbd>
        <img src="FIFO_Img/FIFO_VHDL.svg" alt="FIFO_VHDL" width="500"/>  
    </kbd>
</p>
<p align="center">
    <kbd>
        <img src="FIFO_Img/FIFO_VHDL_Enlarged.svg" alt="FIFO_VHDL_Enlarged" width="500"/>  
    </kbd>
</p>
<p align="center">
    <b>
       RTL Parameterized Description
    </b>
</p>

## [Verilog Code](Verilog_Files)
This project is sub-dived into three (3) files: **FIFO, FIFO_Ctrl** and **RegFile.**  

These files are the complete FIFO Project
```
//*********************** FIFO Buffer ***********************--
//***********************************************************--

//**************** Module Inputs and Outputs ****************--
//***********************************************************--
module FIFO 
#(
  parameter Data_Width = 4, // Size of the data to be written in memory
            Addr_Width = 3  // Size of the memory address a.k.a # of positions
)
(  
    input wire clk,											// Clock Input
    input wire rst,								   		// Reset
	 input wire rd_ena,								   	// Read Enable
	 input wire wr_ena,								   	// Write Enable
    input wire [(Data_Width-1):0] data_write,		// Data to be written
	 output wire empty,										// Buffer is empty
	 output reg full,										// Buffer is full
	 output wire [(Data_Width-1):0] data_read			// Data read from memory // (, ) if Test signals enable
//	 output wire [(Addr_Width-1):0] wrptrnxt_test,	// Test signals
//    output wire [(Addr_Width-1):0] rdptrnxt_test	// Test signals
);

//******************* Auxiliary cables **********************--
//***********************************************************--

//wire [(Data_Width-1):0] DataRd_aux; // Data aux
wire [(Addr_Width-1):0] WrAddr_aux; // Write Address
wire [(Addr_Width-1):0] RdAddr_aux; // Read  Address
wire full_aux; // Read  Address

// Auxiliary cable for full buffer signal
always @(*)
	begin
		full	=	full_aux;
	end	


//****************** Module Parameterization ****************--
//***********************************************************--

FIFO_Ctrl control_fifo(
				 .clk(clk), .rst(rst),
				 .rd_ena(rd_ena),.wr_ena(wr_ena),
				 .empty(empty),.full(full_aux),
				 .w_addr(WrAddr_aux),.r_addr(RdAddr_aux)								// (,) if Test signals enable
//				 .wrptr_nxt_test(wrptrnxt_test),.rdptr_nxt_test(rdptrnxt_test) // Test signals
				 );

RegFile register_file(
				 .clk(clk), 
				 .rd_ena(rd_ena),.wr_ena(wr_ena),
				 .data_write(data_write),.full(full_aux),
				 .w_addr(WrAddr_aux),.r_addr(RdAddr_aux),
				 .data_read(data_read)
				 );
endmodule 
```
```
//********************** FIFO Control ***********************--
//***********************************************************--

//**************** Module Inputs and Outputs ****************--
//***********************************************************--
module FIFO_Ctrl 
#(
  parameter Addr_Width = 3  // Size of the memory address a.k.a # of positions
)
(  
    input wire clk,											// Clock Input
    input wire rst,								   		// Reset
	 input wire rd_ena,								   	// Read Enable
	 input wire wr_ena,								   	// Write Enable
	 output reg empty,										// Buffer is empty
	 output reg full,										// Buffer is full
	 output reg [(Addr_Width-1):0] w_addr,		// Write Address
	 output reg [(Addr_Width-1):0] r_addr		// Data read from memory // (,) if Test signals enable
//	 output reg [(Addr_Width-1):0] wrptr_nxt_test,	// Test signals
//  output reg [(Addr_Width-1):0] rdptr_nxt_test	// Test signals
);

//******************* Auxiliary cables **********************--
//***********************************************************--

// wrptr --> write pointer register - Current Position of Write Pointer
// wrnxt --> write pointer next - To be next posiiont of Write pointer
// wraux --> write pointer aux -  Handles the + 1 Adder creation
// rdptr --> read pointer register- Current Position of Read Pointer
// rdnxt --> read pointer next - To be next posiiont of Read pointer
// rdaux --> read pointer aux -  Handles the + 1 Adder creation

reg [(Addr_Width-1):0] wrptr, wrnxt, wraux;
reg [(Addr_Width-1):0] rdptr, rdnxt, rdaux;
reg full_buff, full_aux;
reg empty_buff, empty_aux;
reg [1:0]WrRe_op;

always @(*)
	begin
		WrRe_op <= {wr_ena, rd_ena};// Concatenation of Wr and Rd enables to use it in the CASE Statement
		wraux <= wrptr + 1'b1;// Adder creation
		rdaux <= rdptr + 1'b1;// Adder creation
	end

//****************** Module Parameterization ****************--
//***********************************************************--

always@(posedge clk, posedge rst)
	begin
		if(rst)
			begin
				wrptr 		<= 3'b000;
				rdptr 		<= 3'b000;
				full_buff	<= 1'b0;
				empty_buff 	<= 1'b1;
			end
		else if (clk)
			begin
				wrptr 		<= wrnxt;
				rdptr 		<= rdnxt;
				full_buff	<= full_aux;
				empty_buff 	<= empty_aux;
			end	
	end

// Use Blocking Assignments
always@(wrptr, wraux, rdptr, rdaux, WrRe_op, empty_buff, full_buff)
	begin
		case(WrRe_op)
			2'b00    : 	// When there is no Read or Write Operation
							begin	
								wrnxt 		= wrptr;
								rdnxt 		= rdptr;
								full_aux		= full_buff;
								empty_aux	= empty_buff;
							end 
							
			2'b01    : 	// When there is Read Operation
							begin
								wrnxt 		= wrptr;
								rdnxt 		= rdptr;
								full_aux		= full_buff;
								empty_aux	= empty_buff;
								if(empty_buff !== 1'b1) // empty not equal to 1, including x and z
									begin
										rdnxt		= rdaux;
										full_aux	= 1'b0;
									if(rdaux === wrptr) // rdaux equal to wrptr, including x and z
											empty_aux	= 1'b1;
									else
											empty_aux	= empty_buff;
									end
							end 
							
			2'b10    : // When there is Write Operation
							begin
								wrnxt 		= wrptr;
								rdnxt 		= rdptr;
								full_aux		= full_buff;
								empty_aux	= empty_buff;
								if(full_buff  !== 1'b1) // full_buff not equal to 1, including x and z
									begin
										wrnxt 	=	wraux;
										empty_aux=1'b0;
									if(wraux === rdptr) // wraux equal to rdptr, including x and z
											full_aux	= 1'b1;
									else
											full_aux	= full_buff;
									end
							end
							
			2'b11		: // When there is both a Read and Write Operation
							begin	
								wrnxt 		=	wraux;
								rdnxt 		=	rdaux;
								full_aux		=	full_buff;
								empty_aux	=	empty_buff;
							end 
		endcase
	end
	
always @(*)
	begin
		w_addr			<= wrptr;
		r_addr			<= rdptr;
		full				<= full_buff;
		empty				<= empty_buff;
//		wrptr_nxt_test	<= wrptr; // Test signals
//		rdptr_nxt_test	<= rdptr; // Test signals
	end

// ALWAYS REMEBER THAT 
// IF ONE WANTS TO DO MORE THAN ONE STATEMENT INSIDE THE IF STATEMENT 
// ONE HAS TO INCLUDE THE BEGIN AND END RESERVERD WORDS
endmodule 
```
```
//**************** Register File Buffer FIFO ****************--
//***********************************************************--

//**************** Module Inputs and Outputs ****************--
//***********************************************************--
module RegFile 
#(
  parameter Data_Width = 4, // Size of the data to be written in memory
            Addr_Width = 3  // Size of the memory address a.k.a # of positions
)
(  
    input wire clk,										// Clock Input
	 input wire rd_ena,								   // Read Enable
	 input wire wr_ena,								   // Write Enable
    input wire [(Data_Width-1):0] data_write,	// Data to be written
	 input wire [(Addr_Width-1):0] w_addr,			// Addres to write
	 input wire [(Addr_Width-1):0] r_addr,			// Addres to read
	 input wire full,										// Buffer is full
	 output wire [(Data_Width-1):0] data_read		// Data read from memory
 
);

//******************* Auxiliary cables **********************--
//***********************************************************--

reg wr_aux;	
reg [(Data_Width-1):0] data_read_aux;															// Auxiliary cable for write enable

//reg [(Data_Width-1):0] reg_file [0:(2**Addr_Width-1)];		// Register File Declaration a.k.a Buffer
reg [(Data_Width-1):0] reg_file [0:((2**Addr_Width)-1)]; // This is how quartus does the operations

//initialization file for the reg_file
initial
	begin
		 $readmemh("FIFO_Buffer.mif", reg_file);
	end

assign data_read = data_read_aux;

always @(*)
	begin
		wr_aux <= (wr_ena & (~full));
	end	

//****************** Module Parameterization ****************--
//***********************************************************--

always@(posedge clk)
	begin
		if(wr_aux)
			reg_file[w_addr] <= data_write;
	end

always@(rd_ena, r_addr)
	begin
		if(rd_ena)
			data_read_aux <= reg_file[r_addr];
		else
			data_read_aux <= 4'b0000;
	end	


endmodule 
```
### Verilog RTL

**1.** This image represent the **FIFO** being Parameterized
<p align="center">
    <kbd>
        <img src="FIFO_Img/FIFO_Verilog.svg" alt="FIFO_Verilog" width="500"/>  
    </kbd>
</p>
<p align="center">
    <kbd>
        <img src="FIFO_Img/FIFO_Verilog_Enlarged.svg" alt="FIFO_Verilog_Enlarged" width="500"/>  
    </kbd>
</p>
<p align="center">
    <b>
       RTL Parameterized Description
    </b>
</p>

## Test Benches
### Configuration
* For the testbench the **Write** and **Read** instructions are implemented

### TestBench VHDL
```

```
### Testbench Verilog
This verilog testbench includes the test vectors that are discused in the [Findings](##Findings (Errors found in simulation)) section
```
module FIFO_tb
#(
  parameter Data_Width = 4, // Size of the data to be written in memory
            Addr_Width = 3  // Size of the memory address a.k.a # of positions
);

//******************** Testbench Signals ********************--
//***********************************************************--
   reg clk_tb, rst_tb;            				
   reg wr_ena_tb, rd_ena_tb;          				    			 		   		
   reg [(Data_Width-1):0] data_write_tb;
	wire empty_tb, full_tb;	
	wire [(Data_Width-1):0] data_read_tb;
//	wire [(Addr_Width-1):0] wrptr_nxt_tb, rdptr_nxt_tb; // Test signals	
		
//************** Instatiating Device Under Test *************--
//***********************************************************--


// ALLowing to change the number of bits to be used
FIFO #(.Data_Width(Data_Width),.Addr_Width(Addr_Width)) 
					DUT(.clk(clk_tb), .rst(rst_tb),
						 .rd_ena(rd_ena_tb),.wr_ena(wr_ena_tb),
						 .data_write(data_write_tb),
						 .empty(empty_tb),.full(full_tb),							
						 .data_read(data_read_tb)							// (,) if Test signals enable
//						 .wrptrnxt_test(wrptr_nxt_tb),.rdptrnxt_test(rdptr_nxt_tb)
						 );
						 
// 50MHz clock generation
initial clk_tb = 1;
always #10 clk_tb = ~clk_tb;// 50MHz clock generation 
									 // Every 20 ns one full cycle
initial begin
// Two clock cycles to read and/or write

//************** Input Test Signals Generation **************--
//***********************************************************--
//----------------------------------------------------------	
				// TEST VECTOR 0 Start
				rst_tb 			= 1'b1;
				rd_ena_tb 		= 1'b0;
				wr_ena_tb 		= 1'b0;
				data_write_tb	= 4'b0000;
				#40; 
	
				// TEST VECTOR 1 Check Empty Signal
				rst_tb 			= 1'b0;
				rd_ena_tb  		= 1'b0;
				wr_ena_tb 		= 1'b0;
				data_write_tb	= 4'b0000;
				#40;

//----------------------------------------------------------					
		// Writing data to the buffer		
				// TEST VECTOR 2 Write pos#0
				rst_tb 			= 1'b0;
				rd_ena_tb  		= 1'b0;
				wr_ena_tb 		= 1'b1;
				data_write_tb 	= 4'b0000;	
				#20;

				// TEST VECTOR 3 Write pos#1					
				rst_tb 			= 1'b0;
				rd_ena_tb 		= 1'b0;
				wr_ena_tb 		= 1'b1;
				data_write_tb	= 4'b0001;	
				#20; 
		
				// TEST VECTOR 4 Write pos#2					
				rst_tb			= 1'b0;
				rd_ena_tb 		= 1'b0;
				wr_ena_tb 		= 1'b1;
				data_write_tb	= 4'b0010;	
				#20;
				
				// TEST VECTOR 5 Write pos#3					
				rst_tb			= 1'b0;
				rd_ena_tb	 	= 1'b0;
				wr_ena_tb 		= 1'b1;
				data_write_tb	= 4'b0011;		
				#20;
//----------------------------------------------------------				
		// Reading data from the buffer	
				// TEST VECTOR 6 Read pos#0
				rst_tb 			= 1'b0;
				rd_ena_tb  		= 1'b1;
				wr_ena_tb 		= 1'b0;
				data_write_tb 	= 4'b0000;	
				#20;

//----------------------------------------------------------					
		// Writing data to the buffer
				// TEST VECTOR 7 Write pos#4					
				rst_tb			= 1'b0;
				rd_ena_tb 		= 1'b0;
				wr_ena_tb 		= 1'b1;
				data_write_tb	= 4'b0100;	
				#20;
			
				// TEST VECTOR 8 Write pos#5					
				rst_tb			= 1'b0;
				rd_ena_tb 		= 1'b0;
				wr_ena_tb 		= 1'b1;
				data_write_tb	= 4'b0101;	
				#20; 
				
				// TEST VECTOR 9 Write pos#6					
				rst_tb			= 1'b0;
				rd_ena_tb  		= 1'b0;
				wr_ena_tb 		= 1'b1;
				data_write_tb	= 4'b0110;	
				#20;
				
				// TEST VECTOR 10 Write pos#7					
				rst_tb			= 1'b0;
				rd_ena_tb  		= 1'b0;
				wr_ena_tb 		= 1'b1;
				data_write_tb 	= 4'b0111;
				#20;
				
				// TEST VECTOR 11 Write pos#8 a.k.a full buffer					
				rst_tb			= 1'b0;
				rd_ena_tb  		= 1'b0;
				wr_ena_tb 		= 1'b1;
				data_write_tb 	= 4'b1000;
				#20;

//----------------------------------------------------------					
		// Reading data from the buffer	
				// TEST VECTOR 12 Read pos#1
				rst_tb 			= 1'b0;
				rd_ena_tb  		= 1'b1;
				wr_ena_tb 		= 1'b0;
				data_write_tb 	= 4'b0000;	
				#20;
				
				// TEST VECTOR 13 Read pos#2				
				rst_tb 			= 1'b0;
				rd_ena_tb  		= 1'b1;
				wr_ena_tb 		= 1'b0;
				data_write_tb 	= 4'b0000;	
				#20;
				
				// TEST VECTOR 14 Read pos#3					
				rst_tb 			= 1'b0;
				rd_ena_tb  		= 1'b1;
				wr_ena_tb 		= 1'b0;
				data_write_tb	= 4'b0000;	
				#20;
				
				// TEST VECTOR 15 Read pos#4					
				rst_tb 			= 1'b0;
				rd_ena_tb  		= 1'b1;
				wr_ena_tb 		= 1'b0;
				data_write_tb 	= 4'b0000;	
				#20;
				
				// TEST VECTOR 16 Read pos#5					
				rst_tb 			= 1'b0;
				rd_ena_tb  		= 1'b1;
				wr_ena_tb 		= 1'b0;
				data_write_tb 	= 4'b0000;	
				#20;
				
				// TEST VECTOR 17 Read pos#6					
				rst_tb 			= 1'b0;
				rd_ena_tb  		= 1'b1;
				wr_ena_tb 		= 1'b0;
				data_write_tb 	= 4'b0000;	
				#20;
				
				// TEST VECTOR 18 Read pos#7					
				rst_tb 			= 1'b0;
				rd_ena_tb  		= 1'b1;
				wr_ena_tb 		= 1'b0;
				data_write_tb 	= 4'b0000;	
				#20;
				
				// TEST VECTOR 19 Read pos#0					
				rst_tb 			= 1'b0;
				rd_ena_tb  		= 1'b1;
				wr_ena_tb 		= 1'b0;
				data_write_tb 	= 4'b0000;	
				#20;
				
////----------------------------------------------------------	
////----------------------------------------------------------				
//		// Writing and Reading data to and from the buffer		
//				// TEST VECTOR 20 Write pos#0
//				rst_tb 			= 1'b0;
//				rd_ena_tb  		= 1'b0;
//				wr_ena_tb 		= 1'b1;
//				data_write_tb 	= 4'b0000;	
//				#20;
//
//				// TEST VECTOR 21 Write pos#1/ Read pos#0				
//				rst_tb 			= 1'b0;
//				rd_ena_tb 		= 1'b1;
//				wr_ena_tb 		= 1'b1;
//				data_write_tb	= 4'b0001;	
//				#20; 
//		
//				// TEST VECTOR 22 Write pos#2/ Read pos#1						
//				rst_tb			= 1'b0;
//				rd_ena_tb 		= 1'b1;
//				wr_ena_tb 		= 1'b1;
//				data_write_tb	= 4'b0010;	
//				#20;
//				
//				// TEST VECTOR 23 Write pos#3/ Read pos#2						
//				rst_tb			= 1'b0;
//				rd_ena_tb	 	= 1'b1;
//				wr_ena_tb 		= 1'b1;
//				data_write_tb	= 4'b0011;		
//				#20;
//
//				// TEST VECTOR 24 Write pos#4/ Read pos#3						
//				rst_tb			= 1'b0;
//				rd_ena_tb 		= 1'b1;
//				wr_ena_tb 		= 1'b1;
//				data_write_tb	= 4'b0100;	
//				#20;
//			
//				// TEST VECTOR 25 Write pos#5/ Read pos#4						
//				rst_tb			= 1'b0;
//				rd_ena_tb 		= 1'b1;
//				wr_ena_tb 		= 1'b1;
//				data_write_tb	= 4'b0101;	
//				#20; 
//				
//				// TEST VECTOR 26 Write pos#6/ Read pos#5						
//				rst_tb			= 1'b0;
//				rd_ena_tb  		= 1'b1;
//				wr_ena_tb 		= 1'b1;
//				data_write_tb	= 4'b0110;	
//				#20;
//				
//				// TEST VECTOR 27 Write pos#7/ Read pos#6						
//				rst_tb			= 1'b0;
//				rd_ena_tb  		= 1'b1;
//				wr_ena_tb 		= 1'b1;
//				data_write_tb 	= 4'b0111;
//				#20;
//				
//				// TEST VECTOR 28 / Read pos#7						
//				rst_tb			= 1'b0;
//				rd_ena_tb  		= 1'b1;
//				wr_ena_tb 		= 1'b0;
//				data_write_tb 	= 4'b0000;
//				#20;
end
endmodule
```
## Simulation
<p align="center">
    <b>
       Simulation Results for FIFO Correct Writing and Reading
    </b>
</p>
<p align="center">
    <kbd>
        <img src="FIFO_Img/FIFO_Simu_1.png" alt="FIFO_Simu_1" width="500"/>  
    </kbd>
</p>
<p align="center">
    <b>
       Simulation Results for FIFO Correct Writing and Reading
    </b>
</p>
<p align="center">
    <kbd>
        <img src="FIFO_Img/FIFO_Simu_2.png" alt="FIFO_Simu_2" width="500"/>  
    </kbd>
</p>

## Findings (Errors found in simulation)
**1.** This image represent the **FIFO** being Parameterized
<p align="center">
    <kbd>
        <img src="FIFO_Img/FIFO_Simu_Findings1.png" alt="FIFO_Simu_Findings1" width="500"/>  
    </kbd>
</p>

**2.** This image represent the **FIFO** being Parameterized
<p align="center">
    <kbd>
        <img src="FIFO_Img/FIFO_Simu_Findings2.png" alt="FIFO_Simu_Findings2" width="500"/>  
    </kbd>
</p>
