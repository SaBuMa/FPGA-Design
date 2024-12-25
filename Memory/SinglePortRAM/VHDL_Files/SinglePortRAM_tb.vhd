--******************* LIBRARY DEFINITION ********************--
--***********************************************************--
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
------------------------------------
ENTITY SinglePortRAM_tb IS
	GENERIC	(	Data_Width				:	INTEGER	:= 8; -- Size of the data to be written in memory
					Addr_Width				:	INTEGER	:= 2	-- Size of the memory address
				);
	END ENTITY;
------------------------------------
ARCHITECTURE rt1 OF SinglePortRAM_tb IS

--******************** Testbench Signals ********************--
--***********************************************************--
	SIGNAL	clk_tb      	: STD_LOGIC := '1';
	SIGNAL	wr_rd_ena_tb	: STD_LOGIC;
	SIGNAL	addr_tb			: STD_LOGIC_VECTOR(Addr_Width-1 DOWNTO 0);
	SIGNAL	Data_write_tb	: STD_LOGIC_VECTOR(Data_Width-1 DOWNTO 0);
	SIGNAL	Data_read_tb	: STD_LOGIC_VECTOR(Data_Width-1 DOWNTO 0);

BEGIN
--CLOCK GENERATION:------------------------
	clk_tb <= not clk_tb after 10ns; -- 50MHz clock generation 
												-- Every 20 ns one full cycle

--************** Instatiating Device Under Test *************--
--***********************************************************--
DeviceUnderTest:	ENTITY work.SinglePortRAM
	PORT MAP(	clk			=>	clk_tb,
					wr_rd_ena	=> wr_rd_ena_tb,
					addr			=>	addr_tb,
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
		wr_rd_ena_tb	<= '0';
		addr_tb	  		<= "00";
		Data_write_tb	<= "00000000";
		WAIT FOR 40 ns;
		
		-- TEST VECTOR 2 Read pos#1
		wr_rd_ena_tb	<= '0';
		addr_tb	  		<= "01";
		Data_write_tb	<= "00000000";
		WAIT FOR 40 ns;
		
		-- TEST VECTOR 3 Read pos#2
		wr_rd_ena_tb	<= '0';
		addr_tb	  		<= "10";
		Data_write_tb	<= "00000000";
		WAIT FOR 40 ns;
		
		-- TEST VECTOR 4 Read pos#3
		wr_rd_ena_tb	<= '0';
		addr_tb	  		<= "11";
		Data_write_tb	<= "00000000";
		WAIT FOR 40 ns;
------------------------------------------------------------	
	-- Writing the memory
		-- TEST VECTOR 5 Wirte pos#0
		wr_rd_ena_tb	<= '1';
		addr_tb	  		<= "00";
		Data_write_tb	<= "00000110";
		WAIT FOR 40 ns;
		
		-- TEST VECTOR 6 Wirte pos#1
		wr_rd_ena_tb	<= '1';
		addr_tb	  		<= "01";
		Data_write_tb	<= "00000101";
		WAIT FOR 40 ns;
		
		-- TEST VECTOR 7 Wirte pos#2
		wr_rd_ena_tb	<= '1';
		addr_tb	  		<= "10";
		Data_write_tb	<= "00000100";
		WAIT FOR 40 ns;
		
		-- TEST VECTOR 8 Wirte pos#3
		wr_rd_ena_tb	<= '1';
		addr_tb	  		<= "11";
		Data_write_tb	<= "00000011";
		WAIT FOR 40 ns;
------------------------------------------------------------	
	-- Reading what was written	
		-- TEST VECTOR 9 Read pos#0
		wr_rd_ena_tb	<= '0';
		addr_tb	  		<= "00";
		Data_write_tb	<= "00000000";
		WAIT FOR 40 ns;
		
		-- TEST VECTOR 10 Read pos#1
		wr_rd_ena_tb	<= '0';
		addr_tb	  		<= "01";
		Data_write_tb	<= "00000000";
		WAIT FOR 40 ns;
		
		-- TEST VECTOR 11 Read pos#2
		wr_rd_ena_tb	<= '0';
		addr_tb	  		<= "10";
		Data_write_tb	<= "00000000";
		WAIT FOR 40 ns;
		
		-- TEST VECTOR 12 Read pos#3
		wr_rd_ena_tb	<= '0';
		addr_tb	  		<= "11";
		Data_write_tb	<= "00000000";
		WAIT FOR 40 ns;
	END PROCESS;
	
END ARCHITECTURE;