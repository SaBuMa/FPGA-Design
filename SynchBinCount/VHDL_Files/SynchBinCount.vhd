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
	GENERIC	(	Nbits				:	INTEGER	:= 4);
	PORT 		(	clk			: 	IN		STD_LOGIC;
					rst			: 	IN		STD_LOGIC;
					ena			: 	IN		STD_LOGIC;
					counter		: 	OUT	STD_LOGIC_VECTOR(Nbits-1 DOWNTO 0));
END ENTITY;

--************ INTERCONNECTION BETWEEN SIGNALS **************--
--***********************************************************--
ARCHITECTURE rt1 OF SynchBinCount IS

--******************* Auxiliary cables **********************--
--***********************************************************--
	CONSTANT ONES			:	UNSIGNED (Nbits-1 DOWNTO 0)	:=	(OTHERS => '1');
	CONSTANT ZEROS			:	UNSIGNED (Nbits-1 DOWNTO 0)	:=	(OTHERS => '0');
	-- SIGNAL count_s		:	INTEGER RANGE 0 to (2**N-1);
	
	SIGNAL count_s			:	UNSIGNED (Nbits-1 DOWNTO 0);
	SIGNAL count_next		:	UNSIGNED (Nbits-1 DOWNTO 0);
	
	SIGNAL e1,e2			:	STD_LOGIC;
	SIGNAL e0,e3			:	STD_LOGIC_VECTOR (Nbits-1 DOWNTO 0);

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
