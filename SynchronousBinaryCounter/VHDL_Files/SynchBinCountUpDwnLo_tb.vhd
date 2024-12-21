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