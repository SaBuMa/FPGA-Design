# Dual Port RAM
* For this scenario, a **Dual Port RAM** that ***Writes*** and ***Reads*** from an specific ***Address*** is being implemented using **Parameterization**.  

 * Then through the use of **Quartus**, the circuit is going to be coded both in **VHDL** and **Verilog** languages.
    * With the use of Quartus one can check the VHDL or Verilog code implementation does in fact recreate the circuit in question looking at the **RTL model** created by Quartus.  

* Finally to verify that the **RAM** is working as expected a **testbench** and simulation in **Questa** is done. 

## Block Diagrams
<p align="center">
    <b>  
        DPRAM Representation  
    </b>
</p>
<p align="Center">
    <kbd>
        <img src="DualPortRAM_Img/DPRAM_Block.svg" alt="Block Dia" width="580" />
    </kbd>
</p>
<p align="center">
    <b>  
        DPRAM Configuration  
    </b>
</p>
<p align="Center">
    <kbd>
        <img src="DualPortRAM_Img/DPRAM_CONFIG.png" alt="Representation" width="580" />
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
--********************** Dual Port RAM **********************--
--***********************************************************--

--******************* LIBRARY DEFINITION ********************--
--***********************************************************--
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

--***************** ENITY = Inputs Outputs ******************--
--***********************************************************--
ENTITY DualPortRAM IS
	GENERIC	(	Data_Width				:	INTEGER	:= 8; -- Size of the data to be written in memory
					Addr_Width				:	INTEGER	:= 2	-- Size of the memory address
				);	
	PORT 		(	clk			: 	IN		STD_LOGIC;											-- Clock Input
					wr_ena		: 	IN		STD_LOGIC;											--	Write/Read Enable
					Wr_addr		: 	IN		STD_LOGIC_VECTOR(Addr_Width-1 DOWNTO 0);  -- Address to write 
					Re_addr		: 	IN		STD_LOGIC_VECTOR(Addr_Width-1 DOWNTO 0);  -- Address to read
					Data_write	: 	IN		STD_LOGIC_VECTOR(Data_Width-1 DOWNTO 0);  -- Data to be written
					Data_read	: 	OUT	STD_LOGIC_VECTOR(Data_Width-1 DOWNTO 0)); -- Data read from memory
END ENTITY;

ARCHITECTURE rt1 OF DualPortRAM IS

--******************* Auxiliary cables **********************--
--***********************************************************--

-- Cables used in "Module Parameterization"
	TYPE mem_2d IS ARRAY (0 TO 2**Addr_Width-1) OF STD_LOGIC_VECTOR(Data_Width-1 DOWNTO 0);
	
	SIGNAL ram : mem_2d := (("00000000"),("00000000"),("00000000"),("00000000")); -- Initializing Memory to zeroes
	
	SIGNAL addr_reg : STD_LOGIC_VECTOR(Addr_Width-1 DOWNTO 0);

BEGIN
					
--************* Parameterized description of RAM ************--
--***********************************************************--
WriteProcess: PROCESS (clk)
	BEGIN
		IF (rising_edge(clk)) THEN
			IF (wr_ena = '1') THEN
				ram(TO_INTEGER(UNSIGNED(Wr_addr))) <= Data_write;
			END IF;
			addr_reg <= Re_addr;
		END IF;
	END PROCESS;
	Data_read <= ram(TO_INTEGER(UNSIGNED(addr_reg)));

END ARCHITECTURE;
```
[comment]: <> (To make a reference to a parent folder, used when the images are within a parent folder od the Readme.md file one must use ".." as represented below)
### VHDL Up RTL
**1.** This image represent the **Dual Port RAM** being Parameterized
<p align="center">
    <kbd>
        <img src="DualPortRAM_Img/DPRAM_VHDL.svg" alt="DualPortRAM_VHDL" width="500"/>  
    </kbd>
</p>
<p align="center">
    <b>
       RTL Parameterized Description
    </b>
</p>

## [Verilog](Verilog_Files)
```
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
```
### Verilog RTL

**1.** This image represent the **Dual Port RAM** being Parameterized
<p align="center">
    <kbd>
        <img src="DualPortRAM_Img/DPRAM_Verilog.svg" alt="DualPortRAM_Verilog" width="500"/>  
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
--******************* LIBRARY DEFINITION ********************--
--***********************************************************--
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
------------------------------------
ENTITY DualPortRAM_tb IS
	GENERIC	(	Data_Width				:	INTEGER	:= 8; -- Size of the data to be written in memory
					Addr_Width				:	INTEGER	:= 2	-- Size of the memory address
				);
	END ENTITY;
------------------------------------
ARCHITECTURE rt1 OF DualPortRAM_tb IS

--******************** Testbench Signals ********************--
--***********************************************************--
	SIGNAL	clk_tb      	: STD_LOGIC := '1';
	SIGNAL	wr_ena_tb		: STD_LOGIC;
	SIGNAL	Wr_addr_tb		: STD_LOGIC_VECTOR(Addr_Width-1 DOWNTO 0);
	SIGNAL	Re_addr_tb		: STD_LOGIC_VECTOR(Addr_Width-1 DOWNTO 0);
	SIGNAL	Data_write_tb	: STD_LOGIC_VECTOR(Data_Width-1 DOWNTO 0);
	SIGNAL	Data_read_tb	: STD_LOGIC_VECTOR(Data_Width-1 DOWNTO 0);

BEGIN
--CLOCK GENERATION:------------------------
	clk_tb <= not clk_tb after 10ns; -- 50MHz clock generation 
												-- Every 20 ns one full cycle

--************** Instatiating Device Under Test *************--
--***********************************************************--
DeviceUnderTest:	ENTITY work.DualPortRAM
	PORT MAP(	clk			=>	clk_tb,
					wr_ena		=> wr_ena_tb,
					Wr_addr		=>	Wr_addr_tb,
					Re_addr		=>	Re_addr_tb,
					Data_write	=> Data_write_tb,
					Data_read	=> Data_read_tb
					);
	
--************** Input Test Signals Generation **************--
--***********************************************************--

-- Two clock cycles to read and/or write
signal_generation: PROCESS
	BEGIN
	-- Reading the memory
		-- TEST VECTOR 1 Read pos#0
		wr_ena_tb		<= '0';
		Wr_addr_tb	  	<= "00";
		Re_addr_tb	  	<= "00";
		Data_write_tb	<= "00000000";
		WAIT FOR 40 ns;
		
		-- TEST VECTOR 2 Read pos#1
		wr_ena_tb		<= '0';
		Wr_addr_tb	  	<= "00";
		Re_addr_tb	  	<= "01";
		Data_write_tb	<= "00000000";
		WAIT FOR 40 ns;
		
		-- TEST VECTOR 3 Read pos#2
		wr_ena_tb		<= '0';
		Wr_addr_tb	  	<= "00";
		Re_addr_tb	  	<= "10";
		Data_write_tb	<= "00000000";
		WAIT FOR 40 ns;
		
		-- TEST VECTOR 4 Read pos#3
		wr_ena_tb		<= '0';
		Wr_addr_tb	  	<= "00";
		Re_addr_tb	  	<= "11";
		Data_write_tb	<= "00000000";
		WAIT FOR 40 ns;
------------------------------------------------------------	
	-- Writing the memory
		-- TEST VECTOR 5 Wirte pos#0
		wr_ena_tb		<= '1';
		Wr_addr_tb	  	<= "00";
		Re_addr_tb	  	<= "00";
		Data_write_tb	<= "00000110";
		WAIT FOR 40 ns;
		
		-- TEST VECTOR 6 Wirte pos#1
		wr_ena_tb		<= '1';
		Wr_addr_tb	  	<= "01";
		Re_addr_tb	  	<= "00";
		Data_write_tb	<= "00000101";
		WAIT FOR 40 ns;
		
		-- TEST VECTOR 7 Wirte pos#2
		wr_ena_tb		<= '1';
		Wr_addr_tb	  	<= "10";
		Re_addr_tb	  	<= "00";
		Data_write_tb	<= "00000100";
		WAIT FOR 40 ns;
		
		-- TEST VECTOR 8 Wirte pos#3
		wr_ena_tb		<= '1';
		Wr_addr_tb	  	<= "11";
		Re_addr_tb	  	<= "00";
		Data_write_tb	<= "00000011";
		WAIT FOR 40 ns;
------------------------------------------------------------	
	-- Reading what was written	
		-- TEST VECTOR 9 Read pos#0
		wr_ena_tb		<= '0';
		Wr_addr_tb	  	<= "00";
		Re_addr_tb	  	<= "00";
		Data_write_tb	<= "00000000";
		WAIT FOR 40 ns;
		
		-- TEST VECTOR 10 Read pos#1
		wr_ena_tb		<= '0';
		Wr_addr_tb	  	<= "00";
		Re_addr_tb	  	<= "01";
		Data_write_tb	<= "00000000";
		WAIT FOR 40 ns;
		
		-- TEST VECTOR 11 Read pos#2
		wr_ena_tb		<= '0';
		Wr_addr_tb	  	<= "00";
		Re_addr_tb	  	<= "10";
		Data_write_tb	<= "00000000";
		WAIT FOR 40 ns;
		
		-- TEST VECTOR 12 Read pos#3
		wr_ena_tb		<= '0';
		Wr_addr_tb	  	<= "00";
		Re_addr_tb	  	<= "11";
		Data_write_tb	<= "00000000";
		WAIT FOR 40 ns;
	END PROCESS;
	
END ARCHITECTURE;
```
### Testbench Verilog
```
module DualPortRAM_tb
#(
  parameter Data_Width = 8, // Size of the data to be written in memory
            Addr_Width = 2  // Size of the memory address
);

//******************** Testbench Signals ********************--
//***********************************************************--
   reg clk_tb;            				
   reg wr_ena_tb;          				    			 		
   reg [(Addr_Width-1):0] Wr_addr_tb;
	reg [(Addr_Width-1):0] Re_addr_tb;    		
   reg [(Data_Width-1):0] Data_write_tb;          				      			 		
	wire [(Data_Width-1):0] Data_read_tb;	
	
//************** Instatiating Device Under Test *************--
//***********************************************************--


// ALLowing to change the number of bits to be used
DualPortRAM #(.Data_Width(Data_Width),.Addr_Width(Addr_Width)) 
					DUT(.clk(clk_tb), .wr_ena(wr_ena_tb),
						 .Wr_addr(Wr_addr_tb),.Re_addr(Re_addr_tb),
						 .Data_write(Data_write_tb), .Data_read(Data_read_tb));

// 50MHz clock generation
initial clk_tb = 1;
always #10 clk_tb = ~clk_tb;// 50MHz clock generation 
									 // Every 20 ns one full cycle
initial begin
// Two clock cycles to read and/or write

	//Reading the memory
		// TEST VECTOR 1 Read pos#0
		wr_ena_tb		= 1'b0;
		Wr_addr_tb		= 2'b00;
		Re_addr_tb		= 2'b00;
		Data_write_tb	= 8'b00000000;
		#40;
		
		// TEST VECTOR 2 Read pos#1
		wr_ena_tb		= 1'b0;
		Wr_addr_tb		= 2'b00;
		Re_addr_tb		= 2'b01;
		Data_write_tb	= 8'b00000000;
		#40;
		
		// TEST VECTOR 3 Read pos#2
		wr_ena_tb		= 1'b0;
		Wr_addr_tb		= 2'b00;
		Re_addr_tb		= 2'b10;
		Data_write_tb	= 8'b00000000;
		#40;
		
		// TEST VECTOR 4 Read pos#3
		wr_ena_tb		= 1'b0;
		Wr_addr_tb		= 2'b00;
		Re_addr_tb		= 2'b11;
		Data_write_tb	= 8'b00000000;
		#40;

////////////////////////////////////////////////////////////
			
	// Writting to the memory	
		// TEST VECTOR 5 Write pos#0
		wr_ena_tb		= 1'b1;
		Wr_addr_tb		= 2'b00;
		Re_addr_tb		= 2'b00;
		Data_write_tb	= 8'b00000110;
		#40;	
		
		// TEST VECTOR 6 Write pos#1
		wr_ena_tb		= 1'b1;
		Wr_addr_tb		= 2'b01;
		Re_addr_tb		= 2'b00;
		Data_write_tb	= 8'b00000101;
		#40;

		// TEST VECTOR 7 Write pos#2
		wr_ena_tb		= 1'b1;
		Wr_addr_tb		= 2'b10;
		Re_addr_tb		= 2'b00;
		Data_write_tb	= 8'b00000100;
		#40;
		
		// TEST VECTOR 8 Write pos#3
		wr_ena_tb		= 1'b1;
		Wr_addr_tb		= 2'b11;
		Re_addr_tb		= 2'b00;
		Data_write_tb	= 8'b00000011;
		#40;
		
////////////////////////////////////////////////////////////
		
	// Reading what was written
		// TEST VECTOR 9 Read pos#0
		wr_ena_tb		= 1'b0;
		Wr_addr_tb		= 2'b00;
		Re_addr_tb		= 2'b00;
		Data_write_tb	= 8'b00000000;
		#40;
		
		// TEST VECTOR 10 Read pos#1
		wr_ena_tb		= 1'b0;
		Wr_addr_tb		= 2'b00;
		Re_addr_tb		= 2'b01;
		Data_write_tb	= 8'b00000000;
		#40;
		
		// TEST VECTOR 11 Read pos#2
		wr_ena_tb		= 1'b0;
		Wr_addr_tb		= 2'b00;
		Re_addr_tb		= 2'b10;
		Data_write_tb	= 8'b00000000;
		#40;
		
		// TEST VECTOR 12 Read pos#3
		wr_ena_tb		= 1'b0;
		Wr_addr_tb		= 2'b00;
		Re_addr_tb		= 2'b11;
		Data_write_tb	= 8'b00000000;
		#40;
end
endmodule
```
## Simulation
<p align="center">
    <b>
       Simulation Results for Write  & Read
    </b>
</p>
<p align="center">
    <kbd>
        <img src="DualPortRAM_Img/DPRAM_Simu.png" alt="DualPortRAM_Simu"/>  
    </kbd>
</p>
