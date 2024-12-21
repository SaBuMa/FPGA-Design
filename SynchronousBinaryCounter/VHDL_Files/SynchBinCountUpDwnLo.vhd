--********* Synchronous Binary Counter UP/Down/Load *********--
--***********************************************************--

--******************* LIBRARY DEFINITION ********************--
--***********************************************************--
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

--***************** ENITY = Inputs Outputs ******************--
--***********************************************************--
ENTITY SynchBinCountUPDwnLo IS
	GENERIC	(	Nbits				:	INTEGER	:= 4);	-- # of bits to used
	PORT 		(	clk			: 	IN		STD_LOGIC;		-- Clock Input
					rst			: 	IN		STD_LOGIC;		--	Reset Input
					ena			: 	IN		STD_LOGIC;		--	Enable Input
					Data			: 	IN		STD_LOGIC_VECTOR(Nbits-1 DOWNTO 0); -- Data Input
					UpDwn			: 	IN		STD_LOGIC;		--	Up or Down Selector (Up=1)(Down=0)
					Load			: 	IN		STD_LOGIC;		--	Load Signal
					counter		: 	OUT	STD_LOGIC_VECTOR(Nbits-1 DOWNTO 0)); -- Data Output
END ENTITY;

--************ INTERCONNECTION BETWEEN SIGNALS **************--
--***********************************************************--
ARCHITECTURE rt1 OF SynchBinCountUPDwnLo IS

--******************* Auxiliary cables **********************--
--***********************************************************--

-- Cables used in "Module Instantiation"	
	SIGNAL negate			:	STD_LOGIC_VECTOR (Nbits-1 DOWNTO 0); -- Negative of Output
	SIGNAL aux_a,aux_b	:	STD_LOGIC_VECTOR (Nbits-1 DOWNTO 0); -- Auxiliary Variables
	SIGNAL enables			:	STD_LOGIC_VECTOR (Nbits-1 DOWNTO 0); -- Enables for each Register
	SIGNAL datain			:	STD_LOGIC_VECTOR (Nbits-1 DOWNTO 0); -- Input Aux Variables
	SIGNAL qout				:	STD_LOGIC_VECTOR (Nbits-1 DOWNTO 0); -- Output Aux Variables
	
-- Cables used in "Module Parameterization"
	CONSTANT ZEROS			:	UNSIGNED (Nbits-1 DOWNTO 0)	:=	(OTHERS => '0'); -- Aux Var -> Set All to Zero
	SIGNAL count_s			:	UNSIGNED (Nbits-1 DOWNTO 0);	-- Aux Var for counting
	SIGNAL count_next		:	UNSIGNED (Nbits-1 DOWNTO 0);	-- Aux Var for counting
	
--******************** Module Description *******************--
--***********************************************************--
BEGIN

--***************** Module Instantiation ********************--
--***********************************************************--

--DUT0: ENTITY work.my_dff
--PORT MAP (	clk	=>    clk,
--				rst	=>    rst,
--				ena	=>		enables(0),
--				d		=> 	datain(0),
--				q		=>    qout(0));
--				
--DUT1: ENTITY work.my_dff
--PORT MAP (	clk	=>    clk,
--				rst	=>    rst,
--				ena	=>		enables(1),
--				d		=> 	datain(1),
--				q		=>    qout(1));
--				
--DUT2: ENTITY work.my_dff
--PORT MAP (	clk	=>    clk,
--				rst	=>    rst,
--				ena	=>		enables(2),
--				d		=> 	datain(2),
--				q		=>    qout(2));
--
--DUT3: ENTITY work.my_dff
--PORT MAP (	clk	=>    clk,
--				rst	=>    rst,
--				ena	=>		enables(3),
--				d		=> 	datain(3),
--				q		=>    qout(3));
--
---- Combinatorial Logic
--aux_a(0)	<=	qout(0) AND qout(1) AND ena;
--aux_a(1)	<=	negate(0) AND negate(1) AND ena;
--aux_a(2)	<=	(qout(0) AND qout(1) AND qout(2) AND ena);
--aux_a(3)	<=	(negate(0) AND negate(1) AND negate(2) AND ena);
--
---- Output			
--counter <= qout;
--
---- Negative of output
--negate	<=	NOT qout;
--
---- Data to all registers
--datain	<=	Data		WHEN Load = '1'	ELSE
--			negate;
--			
---- Logic Gates to enable Up/Down count on Registers			
--aux_b(0)		<= (qout(0) AND ena) 	WHEN UpDwn = '1'	ELSE	
--					(negate(0) AND ena);
--					
--aux_b(1)		<= aux_a(0)			WHEN UpDwn = '1'	ELSE
--					aux_a(1);
--		
--aux_b(2)		<= aux_a(2)			WHEN UpDwn = '1'	ELSE
--					aux_a(3);
--					
---- Enables for each of the registers
--enables(0)	<= Load OR ena;
--
--enables(1)	<= '1'			WHEN Load = '1'	ELSE
--					aux_b(0);
--
--enables(2)	<= '1'			WHEN Load = '1'	ELSE
--					aux_b(1);
--			
--enables(3)	<= '1'			WHEN Load = '1'	ELSE
--					aux_b(2);
					
--********** Parameterized description of Counter ***********--
--***********************************************************--
--
	-- NEXT STATE LOGIC
	count_next	<=		(OTHERS => '0')	WHEN	(rst = '1')							ELSE
							UNSIGNED(Data)		WHEN	(ena = '1' AND Load = '1')		ELSE
							count_s + 1			WHEN	(ena = '1' AND UpDwn = '1')	ELSE
							count_s - 1			WHEN	(ena = '1' AND UpDwn = '0')	ELSE
							count_s;
	PROCESS (clk,rst)
		VARIABLE	reg1	:	UNSIGNED(Nbits-1 DOWNTO 0);
	BEGIN
		IF(rst = '1') THEN
			reg1 :=	(OTHERS => '0');
		ELSIF (rising_edge(clk)) THEN
			IF (ena = '1') THEN
				reg1 := count_next;
			END IF;
		END IF;
		counter <=	STD_LOGIC_VECTOR(reg1);
		count_s <=	reg1;
	END PROCESS;


END ARCHITECTURE;
