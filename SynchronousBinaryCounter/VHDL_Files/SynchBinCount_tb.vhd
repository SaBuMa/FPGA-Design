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