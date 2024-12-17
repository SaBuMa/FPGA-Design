--********* Synchronous Binary Counter UP/Down/Load *********--
--***********************************************************--

--******************* LIBRARY DEFINITION ********************--
--***********************************************************--
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

--***************** ENITY = Inputs Outputs ******************--
--***********************************************************--
ENTITY SynchBinCountUD IS
	GENERIC	(	Nbits				:	INTEGER	:= 4);
	PORT 		(	clk			: 	IN		STD_LOGIC;
					rst			: 	IN		STD_LOGIC;
					ena			: 	IN		STD_LOGIC;
					Data			: 	IN		STD_LOGIC_VECTOR(Nbits-1 DOWNTO 0);
					UpDwn			: 	IN		STD_LOGIC;
					Load			: 	IN		STD_LOGIC;
					counter		: 	OUT	STD_LOGIC_VECTOR(Nbits-1 DOWNTO 0));
END ENTITY;

--************ INTERCONNECTION BETWEEN SIGNALS **************--
--***********************************************************--
ARCHITECTURE rt1 OF SynchBinCountUD IS

--******************* Auxiliary cables **********************--
--***********************************************************--
	CONSTANT ONES			:	UNSIGNED (Nbits-1 DOWNTO 0)	:=	(OTHERS => '1');
	CONSTANT ZEROS			:	UNSIGNED (Nbits-1 DOWNTO 0)	:=	(OTHERS => '0');
	-- SIGNAL count_s		:	INTEGER RANGE 0 to (2**N-1);
	
	SIGNAL count_s			:	UNSIGNED (Nbits-1 DOWNTO 0);
	SIGNAL count_next		:	UNSIGNED (Nbits-1 DOWNTO 0);
	
	SIGNAL negate			:	STD_LOGIC_VECTOR (Nbits-1 DOWNTO 0);
	SIGNAL aux_a,aux_b	:	STD_LOGIC_VECTOR (Nbits-1 DOWNTO 0); -- Auxiliary Variables
	SIGNAL enables			:	STD_LOGIC_VECTOR (Nbits-1 DOWNTO 0);
	SIGNAL ec0,ec1			:	STD_LOGIC_VECTOR (Nbits-1 DOWNTO 0);

--******************** Module Description *******************--
--***********************************************************--
BEGIN

--***************** Module Instantiation ********************--
--***********************************************************--

DUT0: ENTITY work.my_dff
PORT MAP (	clk	=>    clk,
				rst	=>    rst,
				ena	=>		enables(0),
				d		=> 	ec1(0),
				q		=>    ec0(0));
				
DUT1: ENTITY work.my_dff
PORT MAP (	clk	=>    clk,
				rst	=>    rst,
				ena	=>		enables(1),
				d		=> 	ec1(1),
				q		=>    ec0(1));
				
DUT2: ENTITY work.my_dff
PORT MAP (	clk	=>    clk,
				rst	=>    rst,
				ena	=>		enables(2),
				d		=> 	ec1(2),
				q		=>    ec0(2));

DUT3: ENTITY work.my_dff
PORT MAP (	clk	=>    clk,
				rst	=>    rst,
				ena	=>		enables(3),
				d		=> 	ec1(3),
				q		=>    ec0(3));


aux_a(0)	<=	ec0(0) AND ec0(1);
aux_a(1)	<=	negate(0) AND negate(1);
aux_a(2)	<=	(ec0(0) AND ec0(1) AND ec0(2));
aux_a(3)	<=	(negate(0) AND negate(1) AND negate(2));

-- Output			
counter <= ec0;

-- Negative of output
negate	<=	NOT ec0;

-- Data to all registers
ec1	<=	Data		WHEN Load = '1'	ELSE
			negate;
			
-- Logic Gates to enable Up/Down count on Registe 1			
aux_b(0)		<= ec0(0) 	WHEN UpDwn = '1'	ELSE	
					negate(0);
					
-- Logic Gates to enable Up/Down count on Registe 2		
aux_b(1)		<= aux_a(0)			WHEN UpDwn = '1'	ELSE
					aux_a(1);
					
-- Logic Gates to enable Up/Down count on Registe 3			
aux_b(2)		<= aux_a(2)			WHEN UpDwn = '1'	ELSE
					aux_a(3);
					
-- Enables for each of the registers
enables(0)	<= Load OR ena;

enables(1)	<= '1'			WHEN Load = '1'	ELSE
					aux_b(0);

enables(2)	<= '1'			WHEN Load = '1'	ELSE
					aux_b(1);
			
enables(3)	<= '1'			WHEN Load = '1'	ELSE
					aux_b(2);
--********** Parameterized description of Counter ***********--
--***********************************************************--
--
--	-- NEXT STATE LOGIC
--	count_next	<=		(OTHERS => '0')	WHEN	(rst = '1')							ELSE
--							UNSIGNED(Data)		WHEN	(ena = '1' AND Load = '1')		ELSE
--							count_s + 1			WHEN	(ena = '1' AND UpDwn = '1')	ELSE
--							count_s - 1			WHEN	(ena = '1' AND UpDwn = '0')	ELSE
--							count_s;
--	PROCESS (clk,rst)
--		VARIABLE	temp	:	UNSIGNED(Nbits-1 DOWNTO 0);
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
