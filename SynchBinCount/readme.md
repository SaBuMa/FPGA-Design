# Synchronous Binary Counter
For this scenario, a **Synchronous Binary Counter** is being implemented using **logic gates**, **FlipFlops**, **"instantiation"**, and **Parametrization**.  
 Then through the use of **Quartus**, the circuit is going to be coded both in **VHDL** and **Verilog** languages. With the use of Quartus one can check the VHDL or Verilog code implementation does in fact recreate the circuit in question looking at the **RTL model** created by Quartus.

## Block Diagram and Truth Table
<p align="Center">
    <kbd>
        <img src="../SynchBinCount_Img/SynchBinCounter_Block.png" alt="Block Dia" width="380" />
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

## [VHDL](VHDL_Files)
### VHDL Code
For the code, **VHDL 2008** was used in order to allow comments using "--"  
```
--**************** Synchronous Binary Counter ***************--
--***********************************************************--

--******************* LIBRARY DEFINITION ********************--
--***********************************************************--
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

--***************** ENITY = Inputs Outputs ******************--
--***********************************************************--
ENTITY SynchBinCount IS
	GENERIC	(	N				:	INTEGER	:= 4);
	PORT 		(	clk			: 	IN		STD_LOGIC;
					rst			: 	IN		STD_LOGIC;
					ena			: 	IN		STD_LOGIC;
					counter		: 	OUT	STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END ENTITY;

--************ INTERCONNECTION BETWEEN SIGNALS **************--
--***********************************************************--
ARCHITECTURE rt1 OF SynchBinCount IS

--******************* Auxiliary cables **********************--
--***********************************************************--
	CONSTANT ONES			:	UNSIGNED (N-1 DOWNTO 0)	:=	(OTHERS => '1');
	CONSTANT ZEROS			:	UNSIGNED (N-1 DOWNTO 0)	:=	(OTHERS => '0');
	-- SIGNAL count_s		:	INTEGER RANGE 0 to (2**N-1);
	
	SIGNAL count_s			:	UNSIGNED (N-1 DOWNTO 0);
	SIGNAL count_next		:	UNSIGNED (N-1 DOWNTO 0);
	
	SIGNAL e1,e2			:	STD_LOGIC;
	SIGNAL e0,e3			:	STD_LOGIC_VECTOR (N-1 DOWNTO 0);

--******************** Module Description *******************--
--***********************************************************--
BEGIN

--***************** Module Instantiation ********************--
--***********************************************************--
DUT0: ENTITY work.my_dff
PORT MAP (	clk	=>    clk,
				rst	=>    rst,
				ena	=>		ena,
				d		=> 	e3(0),
				q		=>    e0(0));
				
DUT1: ENTITY work.my_dff
PORT MAP (	clk	=>    clk,
				rst	=>    rst,
				ena	=>		e0(0),
				d		=> 	e3(1),
				q		=>    e0(1));
				
DUT2: ENTITY work.my_dff
PORT MAP (	clk	=>    clk,
				rst	=>    rst,
				ena	=>		e1,
				d		=> 	e3(2),
				q		=>    e0(2));

DUT3: ENTITY work.my_dff
PORT MAP (	clk	=>    clk,
				rst	=>    rst,
				ena	=>		e2,
				d		=> 	e3(3),
				q		=>    e0(3));

counter <= e0;
e1 <= e0(1) AND e0(0);
e2 <=	e0(2) AND e0(1) AND e0(0);
e3	<=	NOT e0;

--********** Parameterized description of Counter ***********--
--***********************************************************--
--
--	-- NEXT STATE LOGIC
--	count_next	<=		(OTHERS => '0')	WHEN	(rst = '1')		ELSE
--							count_s + 1			WHEN	(ena = '1')		ELSE
--							count_s;
--	PROCESS (clk,rst)
--		VARIABLE	temp	:	UNSIGNED(N-1 DOWNTO 0);
--	BEGIN
--		IF(rst = '1') THEN
--			temp :=	(OTHERS => '0');
--		ELSIF (rising_edge(clk)) THEN
--			IF (ena = '1') THEN
--				temp := count_next;
--			END IF;
--		END IF;
--		counter <=	STD_LOGIC_VECTOR(temp);
--		count_s <=	temp;
--	END PROCESS;


END ARCHITECTURE;
```
[comment]: <> (To make a reference to a parent folder, used when the images are within a parent folder od the Readme.md file one must use ".." as represented below)
### VHDL RTL
**1.** This first image represent the **Synchronous Binary Counter**  using **D-Type FlipFlops** and **Instantiation**
<p align="center">
    <kbd>
        <img src="../SynchBinCount_Img/SynchBinCount_FlipFlop.png" alt="SynchBinCount_FlipFlop" width="500"/> 
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
        <img src="../SynchBinCount_Img/SynchBinCount_Parameterized.png" alt="SynchBinCount_Parameterized" width="500"/>  
    </kbd>
</p>
<p align="center">
    <b>
       RTL Parameterized Description
    </b>
</p>

## [Verilog](Verilog_Files)
## Verilog Code
```

```
## Verilog RTL
**1.** This first image represent the **Binary Counter** in a Gate Level description using **Instantiation**
<p align="center">
    <kbd>
        <img src="CNB_Img/CNB_Verilog_GateLevel.png" alt="CNB_Verilog_GateLevel" width="500"/>
    </kbd>
</p>
<p align="center">
    <b>
       RTL Gate Level Instantiation
    </b>
</p>

**2.** This second image represent the **Binary Counter** in a Gate Level description using the **Generate Block**
<p align="center">
    <kbd>
        <img src="CNB_Img/CNB_Verilog_Generate.png" alt="CNB_Verilog_Generate" width="500"/>
    </kbd>
</p>
<p align="center">
    <b>
       RTL Gate Level Generate Block
    </b>
</p>

**3.** Finally describing the **Binary Counter** in a compact way
<p align="center">
    <kbd>
        <img src="CNB_Img/CNB_Verilog_Compact.png" alt="CNB_Verilog_Compact" width="500"/>  
    </kbd>
</p>
<p align="center">
    <b>
       RTL Compact Description
    </b>
</p>

## TestBench Configuration
### TestBench Code
```
--******************* LIBRARY DEFINITION ********************--
--***********************************************************--
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
------------------------------------
ENTITY SynchBinCount_tb IS
	GENERIC	(	N				:	INTEGER	:= 4);
	
	END ENTITY;
------------------------------------
ARCHITECTURE rt1 OF SynchBinCount_tb IS

--********************* Signals to Test *********************--
--***********************************************************--
	SIGNAL	clk_tb      	: STD_LOGIC := '0';
	SIGNAL	rst_tb			: STD_LOGIC;
	SIGNAL	ena_tb			: STD_LOGIC;
	SIGNAL	counter_tb		: STD_LOGIC_VECTOR(N-1 DOWNTO 0);

	
BEGIN
--CLOCK GENERATION:------------------------
	clk_tb <= not clk_tb after 10ns; -- 50MHz clock generation

--************** Instatiating Device Under Test *************--
--***********************************************************--
DeviceUnderTest:	ENTITY work.SynchBinCount
	PORT MAP(	clk		=>	clk_tb,
					rst		=> rst_tb,
					ena		=>	ena_tb,
					counter	=> counter_tb
					);
	
--************** Input Test Signals Generation **************--
--***********************************************************--
signal_generation: PROCESS
	BEGIN
		-- TEST VECTOR 1
		rst_tb	  <= '1';
		ena_tb	  <= '0';
		WAIT FOR 50 ns;
		
		-- TEST VECTOR 2
		rst_tb	  <= '0';
		ena_tb	  <= '1';
		WAIT FOR 200 ns;
		
		-- TEST VECTOR 3
		rst_tb	  <= '0';
		ena_tb	  <= '1';
		WAIT FOR 200 ns;
		
		-- TEST VECTOR 4
		rst_tb	  <= '0';
		ena_tb	  <= '1';
		WAIT FOR 200 ns;
		
		-- TEST VECTOR 5
		rst_tb	  <= '0';
		ena_tb	  <= '1';
		WAIT FOR 200 ns;
		
	END PROCESS;
	
END ARCHITECTURE;
```

## Simulation
<p align="center">
    <kbd>
        <img src="../SynchBinCount_Img/SynchBinCount_Simu.png" alt="SynchBinCount_Simu" width="500"/>  
    </kbd>
</p>
<p align="center">
    <b>
       Simulation Results
    </b>
</p>
