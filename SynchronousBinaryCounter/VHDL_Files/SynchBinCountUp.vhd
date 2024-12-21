--************** Synchronous Binary Counter Up **************--
--***********************************************************--

--******************* LIBRARY DEFINITION ********************--
--***********************************************************--
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

--***************** ENITY = Inputs Outputs ******************--
--***********************************************************--
ENTITY SynchBinCountUp IS
	GENERIC	(	Nbits				:	INTEGER	:= 4);	-- # of bits to used
	PORT 		(	clk			: 	IN		STD_LOGIC;		-- Clock Input
					rst			: 	IN		STD_LOGIC;		--	Reset Input
					ena			: 	IN		STD_LOGIC;		--	Enable Input
					counter		: 	OUT	STD_LOGIC_VECTOR(Nbits-1 DOWNTO 0)-- Data Output
				);
END ENTITY;

ARCHITECTURE rt1 OF SynchBinCountUp IS

--******************* Auxiliary cables **********************--
--***********************************************************--
-- Cables used in "Module Instantiation"	
	SIGNAL negate			:	STD_LOGIC_VECTOR (Nbits-1 DOWNTO 0); -- Negative of Output
	SIGNAL enables			:	STD_LOGIC_VECTOR (Nbits-1 DOWNTO 0); -- Enables for each Register
	SIGNAL qout				:	STD_LOGIC_VECTOR (Nbits-1 DOWNTO 0); -- Output Aux Variables
	
-- Cables used in "Module Parameterization"
	CONSTANT ZEROS			:	UNSIGNED (Nbits-1 DOWNTO 0)	:=	(OTHERS => '0'); -- Aux Var -> Set All to Zero
	SIGNAL count_s			:	UNSIGNED (Nbits-1 DOWNTO 0);	-- Aux Var for counting
	SIGNAL count_next		:	UNSIGNED (Nbits-1 DOWNTO 0);	-- Aux Var for counting

BEGIN

--***************** Module Instantiation ********************--
--***********************************************************--
--DUT0: ENTITY work.my_dff
--PORT MAP (	clk	=>    clk,
--				rst	=>    rst,
--				ena	=>		enables(0),
--				d		=> 	negate(0),
--				q		=>    qout(0));
--				
--DUT1: ENTITY work.my_dff
--PORT MAP (	clk	=>    clk,
--				rst	=>    rst,
--				ena	=>		enables(1),
--				d		=> 	negate(1),
--				q		=>    qout(1));
--				
--DUT2: ENTITY work.my_dff
--PORT MAP (	clk	=>    clk,
--				rst	=>    rst,
--				ena	=>		enables(2),
--				d		=> 	negate(2),
--				q		=>    qout(2));
--
--DUT3: ENTITY work.my_dff
--PORT MAP (	clk	=>    clk,
--				rst	=>    rst,
--				ena	=>		enables(3),
--				d		=> 	negate(3),
--				q		=>    qout(3));
--
---- Combinatorial Logic
--counter    <= qout;
--negate	  <= NOT qout;
--
--enables(0) <= ena;
--enables(1) <= qout(0);
--enables(2) <= qout(1) AND qout(0);
--enables(3) <= qout(2) AND qout(1) AND qout(0);

--********** Parameterized description of Counter ***********--
--***********************************************************--
--
	-- NEXT STATE LOGIC
	count_next	<=		(OTHERS => '0')	WHEN	(rst = '1')		ELSE
							count_s + 1			WHEN	(ena = '1')		ELSE
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
