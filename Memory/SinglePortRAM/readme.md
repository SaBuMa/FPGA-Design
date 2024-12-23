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
        <img src="../FPGA_PrjImg/FPGA1.JPG" alt="FPGA BOX" width="250"/> 
    </kbd>
    <kbd>
        <img src="../FPGA_PrjImg/FPGA2.JPG" alt="FPGA Board" width="250"/> 
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
        <img src="../FPGA_PrjImg/Quartus.png" alt="QuartusPrime" width="100"/> 
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
        <img src="../FPGA_PrjImg/Questa.png" alt="Questa" width="100"/>  
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
        <img src="SinglePortRAM_Img/SinglePortRAM_VHDL.svg" alt="SinglePortRAM_VHDL" width="500"/>  
    </kbd>
</p>
<p align="center">
    <b>
       RTL Parameterized Description
    </b>
</p>

## [Verilog](Verilog_Files)
```

```
### Verilog RTL
**1.** This first image represent the **Binary Counter** in a Gate Level description using **Instantiation**
<p align="center">
    <kbd>
        <img src="SynchBinCount_Img/SynchBinCountUp_FlipFlop_Verilog.svg" alt="SynchBinCountUp_FlipFlop_Verilog" width="500"/>
    </kbd>
</p>
<p align="center">
    <b>
       RTL D-Type FlipFlop Instantiation
    </b>
</p>

**2.** This second image represent the **Synchronous Binary Counter** being Parameterized
<p align="center">
    <kbd>
        <img src="SynchBinCount_Img/SynchBinCountUp_Parameterization_Verilog.svg" alt="SynchBinCountUp_Parameterization_Verilog" width="500"/>  
    </kbd>
</p>
<p align="center">
    <b>
       RTL Parameterized Description
    </b>
</p>



## Test Benches
### Configuration
* For both the Count **Up and Down** counters, the testbench file is the same.
* For the Count **UpDownLoad** Counter the testbench includes the load function and the count up and down from the load value

### TestBench VHDL Code Up - Down Counters
```
--******************* LIBRARY DEFINITION ********************--
--***********************************************************--
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
------------------------------------
ENTITY SynchBinCount_tb IS
    GENERIC	(	Nbits			:	INTEGER	:= 4); -- # of bits to used
    
    END ENTITY;
------------------------------------
ARCHITECTURE rt1 OF SynchBinCount_tb IS

--******************** Testbench Signals ********************--
--***********************************************************--
    SIGNAL	clk_tb      	: STD_LOGIC := '0';
    SIGNAL	rst_tb			: STD_LOGIC;
    SIGNAL	ena_tb			: STD_LOGIC;
    SIGNAL	counter_tb		: STD_LOGIC_VECTOR(Nbits-1 DOWNTO 0);

    
BEGIN

--CLOCK GENERATION:------------------------
    clk_tb <= not clk_tb after 10ns; -- 50MHz clock generation

--************** Instatiating Device Under Test *************--
--***********************************************************--
DeviceUnderTest:	ENTITY work.SynchBinCountUp
    PORT MAP(	clk		=>	clk_tb,
                    rst		=> rst_tb,
                    ena		=>	ena_tb,
                    counter	=> counter_tb
                    );
    
--************** Input Test Signals Generation **************--
--***********************************************************--
signal_generation: PROCESS
    BEGIN
        -- TEST VECTOR 1 Start
        rst_tb	  <= '1';
        ena_tb	  <= '0';
        WAIT FOR 50 ns;
        
        -- TEST VECTOR 2 Nothing
        rst_tb	  <= '0';
        ena_tb	  <= '0';
        WAIT FOR 50 ns;
        
        -- TEST VECTOR 3 Count
        rst_tb	  <= '0';
        ena_tb	  <= '1';
        WAIT FOR 200 ns;
        
        -- TEST VECTOR 4 Count
        rst_tb	  <= '0';
        ena_tb	  <= '1';
        WAIT FOR 200 ns;
        
        -- TEST VECTOR 5 Count
        rst_tb	  <= '0';
        ena_tb	  <= '1';
        WAIT FOR 200 ns;
        
        -- TEST VECTOR 6 Count
        rst_tb	  <= '0';
        ena_tb	  <= '1';
        WAIT FOR 200 ns;
        
    END PROCESS;
    
END ARCHITECTURE;
```

### TestBench VHDL Code UpDownLoad Counter
```
--******************* LIBRARY DEFINITION ********************--
--***********************************************************--
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
------------------------------------
ENTITY SynchBinCountUPDwnLo_tb IS
    GENERIC	(	Nbits				:	INTEGER	:= 4);
    
    END ENTITY;
------------------------------------
ARCHITECTURE rt1 OF SynchBinCountUPDwnLo_tb IS

--******************** Testbench Signals ********************--
--***********************************************************--
    SIGNAL	clk_tb      	: STD_LOGIC := '0';
    SIGNAL	rst_tb			: STD_LOGIC;
    SIGNAL	ena_tb			: STD_LOGIC;
    SIGNAL	Data_tb			: STD_LOGIC_VECTOR(Nbits-1 DOWNTO 0);
    SIGNAL	UpDwn_tb			: STD_LOGIC;
    SIGNAL	Load_tb			: STD_LOGIC;
    SIGNAL	counter_tb		: STD_LOGIC_VECTOR(Nbits-1 DOWNTO 0);

    
BEGIN
--CLOCK GENERATION:------------------------
    clk_tb <= not clk_tb after 10ns; -- 50MHz clock generation

--************** Instatiating Device Under Test *************--
--***********************************************************--
DeviceUnderTest:	ENTITY work.SynchBinCountUPDwnLo
    PORT MAP(	clk		=>	clk_tb,
                    rst		=> rst_tb,
                    ena		=>	ena_tb,
                    Data		=> Data_tb,
                    UpDwn		=> UpDwn_tb,
                    Load		=>	Load_tb,
                    counter	=> counter_tb
                    );
    
--************** Input Test Signals Generation **************--
--***********************************************************--
signal_generation: PROCESS
    BEGIN
        -- TEST VECTOR 1 START
        rst_tb	  <= '1';
        ena_tb	  <= '0';
        Data_tb	  <= "0000";
        UpDwn_tb	  <= '0';
        Load_tb	  <= '0';
        WAIT FOR 50 ns;
        
        -- TEST VECTOR 2 Nothing
        rst_tb	  <= '0';
        ena_tb	  <= '0';
        Data_tb	  <= "0000";
        UpDwn_tb	  <= '0';
        Load_tb	  <= '0';
        WAIT FOR 50 ns;
        
        -- TEST VECTOR 3 UP
        rst_tb	  <= '0';
        ena_tb	  <= '1';
        Data_tb	  <= "0000";
        UpDwn_tb	  <= '1';
        Load_tb	  <= '0';
        WAIT FOR 200 ns;
        
        -- TEST VECTOR 4 DOWN
        rst_tb	  <= '0';
        ena_tb	  <= '1';
        Data_tb	  <= "0000";
        UpDwn_tb	  <= '0';
        Load_tb	  <= '0';
        WAIT FOR 200 ns;
        
        -- TEST VECTOR 5 LOAD #1
        rst_tb	  <= '0';
        ena_tb	  <= '1';
        Data_tb	  <= "0111";
        UpDwn_tb	  <= '1';
        Load_tb	  <= '1';
        WAIT FOR 200 ns;
        
        -- TEST VECTOR 6 COUNT UP FROM LOAD
        rst_tb	  <= '0';
        ena_tb	  <= '1';
        Data_tb	  <= "0000";
        UpDwn_tb	  <= '1';
        Load_tb	  <= '0';
        WAIT FOR 200 ns;
        
        -- TEST VECTOR 7 LOAD #2
        rst_tb	  <= '0';
        ena_tb	  <= '1';
        Data_tb	  <= "1110";
        UpDwn_tb	  <= '1';
        Load_tb	  <= '1';
        WAIT FOR 200 ns;
        
        -- TEST VECTOR 8 COUNT DOWN FROM LOAD
        rst_tb	  <= '0';
        ena_tb	  <= '1';
        Data_tb	  <= "0000";
        UpDwn_tb	  <= '0';
        Load_tb	  <= '0';
        WAIT FOR 200 ns;
        
    END PROCESS;
    
END ARCHITECTURE;
```
## Testbenches Verilog
### TestBench Verilog Code Up - Down Counters
```
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
```

### TestBench VHDL Code UpDownLoad Counter
```
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
```

## Simulation
<p align="center">
    <b>
       Simulation Results for Counter Up
    </b>
</p>
<p align="center">
    <kbd>
        <img src="SynchBinCount_Img/SynchBinCountUp_VHDL_Simu.png" alt="SynchBinCountUp_VHDL_Simu"/>  
    </kbd>
</p>

<p align="center">
    <b>
       Simulation Results for Counter Down
    </b>
</p>
<p align="center">
    <kbd>
        <img src="SynchBinCount_Img/SynchBinCountDwn_VHDL_Simu.png" alt="SynchBinCountDwn_VHDL_Simu"/>  
    </kbd>
</p>

<p align="center">
    <b>
       Simulation Results for Counter Up/Down/Load
    </b>
</p>
<p align="center">
    <kbd>
        <img src="SynchBinCount_Img/SynchBinCountUpDwnLo_VHDL_Simu.png" alt="SynchBinCountUpDwnLo_VHDL_Simu"/>  
    </kbd>
</p>
