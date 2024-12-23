# Single Port RAM
* For this scenario, a **Single Port RAM** that ***Writes*** and ***Reads*** from an specific ***Address*** is being implemented using **Parameterization**.  

 * Then through the use of **Quartus**, the circuit is going to be coded both in **VHDL** and **Verilog** languages.
    * With the use of Quartus one can check the VHDL or Verilog code implementation does in fact recreate the circuit in question looking at the **RTL model** created by Quartus.  

* Finally to verify that the **RAM** is working as expected a **testbench** and simulation in **Questa** is done. 

## Block Diagrams
<p align="Center">
    <kbd>
        <img src="SynchBinCount_Img/SynchBinCountUp_Block.svg" alt="Block Dia" width="580" />
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

## [VHDL Single Port RAM](VHDL_Files)
For the code, **VHDL 2008** was used in order to allow comments using "--"  
```
--********************* Single Port RAM *********************--
--***********************************************************--

--******************* LIBRARY DEFINITION ********************--
--***********************************************************--
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

--***************** ENITY = Inputs Outputs ******************--
--***********************************************************--
ENTITY SinglePortRAM IS
	GENERIC	(	Data_Width				:	INTEGER	:= 8; -- Size of the data to be written in memory
					Addr_Width				:	INTEGER	:= 2	-- Size of the memory address
				);	
	PORT 		(	clk			: 	IN		STD_LOGIC;											-- Clock Input
					wr_rd_ena	: 	IN		STD_LOGIC;											--	Write/Read Enable
					addr			: 	IN		STD_LOGIC_VECTOR(Addr_Width-1 DOWNTO 0);  -- Address to write or read
					Data_write	: 	IN		STD_LOGIC_VECTOR(Data_Width-1 DOWNTO 0);  -- Data to be written
					Data_read	: 	OUT	STD_LOGIC_VECTOR(Data_Width-1 DOWNTO 0)); -- Data read from memory
END ENTITY;

ARCHITECTURE rt1 OF SinglePortRAM IS

--******************* Auxiliary cables **********************--
--***********************************************************--
	TYPE mem_2d IS ARRAY (0 TO 2**Addr_Width-1) OF STD_LOGIC_VECTOR(Data_Width-1 DOWNTO 0);
	SIGNAL ram : mem_2d;
	SIGNAL addr_reg : STD_LOGIC_VECTOR(Addr_Width-1 DOWNTO 0);
-- Cables used in "Module Instantiation"	

-- Cables used in "Module Parameterization"
	
BEGIN

--***************** Module Instantiation ********************--
--***********************************************************--


					
--********** Parameterized description of Counter ***********--
--***********************************************************--
WriteProcess: PROCESS (clk)
	BEGIN
		IF (rising_edge(clk)) THEN
			IF (wr_rd_ena = '1') THEN
				ram(TO_INTEGER(UNSIGNED(Addr))) <= Data_write;
			END IF;
			addr_reg <= addr;
		END IF;
	END PROCESS;
	Data_read <= ram(TO_INTEGER(UNSIGNED(addr_reg)));

END ARCHITECTURE;

```
[comment]: <> (To make a reference to a parent folder, used when the images are within a parent folder od the Readme.md file one must use ".." as represented below)
### VHDL Up RTL
**1.** This image represent the **Single Port RAM** being Parameterized
<p align="center">
    <kbd>
        <img src="SinglePortRAM_Img/SPRAM_VHDL.svg" alt="SinglePortRAM_VHDL" width="500"/>  
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
module SinglePortRAM 
#(
  parameter Data_Width = 8, // Size of the data to be written in memory
            Addr_Width = 2  // Size of the memory address
)
(  
    input wire clk,										// Clock Input
    input wire wr_rd_ena,								// Write/Read Enable
    input wire [(Addr_Width-1):0] addr, 			// Address to write or read
    input wire [(Data_Width-1):0] Data_write,	// Data to be written
    output wire [(Data_Width-1):0] Data_read		// Data read from memory
);

//******************* Auxiliary cables **********************--
//***********************************************************--
reg [(Data_Width-1):0] ram [2**(Addr_Width-1):0];
reg [(Addr_Width-1):0] addr_reg;

//****************** Module Parameterization ****************--
//***********************************************************--
always@(posedge clk)
	begin
		if(wr_rd_ena == 1)
			ram[addr] <= Data_write;
		
		addr_reg <= addr;
	end
	
assign Data_read = ram[addr_reg];

endmodule 
```
### Verilog RTL

**1.** This image represent the **Single Port RAM** being Parameterized
<p align="center">
    <kbd>
        <img src="SinglePortRAM_Img/SPRAM_Verilog.svg" alt="SinglePortRAM_Verilog" width="500"/>  
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
```

```
## Simulation
<p align="center">
    <b>
       Simulation Results for Write
    </b>
</p>
<p align="center">
    <kbd>
        <img src="SinglePortRAM_Img/SPRAM_Write_VHDL_Simu.png" alt="SinglePortRAM_VHDL_Simu"/>  
    </kbd>
</p>

<p align="center">
    <b>
       Simulation Results for Read
    </b>
</p>
<p align="center">
    <kbd>
        <img src="SinglePortRAM_Img/SPRAM_Read_VHDL_Simu.png" alt="SinglePortRAM_VHDL_Simu"/>  
    </kbd>
</p>
