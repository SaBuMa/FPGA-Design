--******************* Comparator One Bit ********************--
--***********************************************************--

--******************* LIBRARY DEFINITION ********************--
--***********************************************************--
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL; -- Used to implement the adder
											-- In a compact description
USE IEEE.STD_LOGIC_MISC.ALL;		-- Used for vector reduction

--***************** ENITY = Inputs Outputs ******************--
--***********************************************************--
ENTITY CNB IS 
GENERIC	(	Nbits			:	INTEGER := 4); -- Number of bits for
--															the circuit
PORT
( 	
	A_N, B_N							: IN STD_LOGIC_VECTOR(Nbits-1 DOWNTO 0); 
	AeqB_N, AgrtB_N, AlwrB_N	: OUT STD_LOGIC
-- AeqB -> A = B // AgrtB -> A > B // AlwrB -> A < B
);
END CNB;

--************ INTERCONNECTION BETWEEN SIGNALS **************--
--***********************************************************--
ARCHITECTURE behavioral OF CNB IS

--******************* Auxiliary cables **********************--
--***********************************************************--
	SIGNAL e0, e1, e2	: STD_LOGIC_VECTOR(Nbits-1 DOWNTO 0); 
-- 		 e --> Auxiliary Equations

--******************** Module Description *******************--
--***********************************************************--
BEGIN

--***************** Module Instantiation ********************--
--***********************************************************--

--ComparatorOneBit_0: ENTITY work.COB
--	PORT MAP(	
--				A_in 				=> A_N(0),
--				B_in				=> B_N(0),
--				AlwrB				=> e0(0),
--				AgrtB 			=> e1(0),
--				AeqB 				=> e2(0)
--	);
--	
--ComparatorOneBit_1: ENTITY work.COB
--	PORT MAP(	
--				A_in 				=> A_N(0),
--				B_in				=> B_N(0),
--				AlwrB				=> e0(1),
--				AgrtB 			=> e1(1),
--				AeqB 				=> e2(1)
--	);
--	
--ComparatorOneBit_2: ENTITY work.COB
--	PORT MAP(	
--				A_in 				=> A_N(0),
--				B_in				=> B_N(0),
--				AlwrB				=> e0(2),
--				AgrtB 			=> e1(2),
--				AeqB 				=> e2(2)
--	);
--	
--ComparatorOneBit_3: ENTITY work.COB
--	PORT MAP(	
--				A_in 				=> A_N(0),
--				B_in				=> B_N(0),
--				AlwrB				=> e0(3),
--				AgrtB 			=> e1(3),
--				AeqB 				=> e2(3)
--	);
--	
--AlwrB_N <= OR_REDUCE(e0);	
--AgrtB_N <= OR_REDUCE(e1);
--AeqB_N  <= AND_REDUCE(e2); 

	
--******************** Generate Module ***********************--
--***********************************************************--

-- Designing the generate function for each adder

Gen_proc : for i in 0 to (Nbits-1) generate
ComparatorOneBit: ENTITY work.COB
	PORT MAP(
				A_in 				=> A_N(i),
				B_in				=> B_N(i),
				AlwrB				=> e0(i),
				AgrtB 			=> e1(i),
				AeqB 				=> e2(i)
	);
  end generate Gen_proc;

 -- Assigning 
AlwrB_N <= OR_REDUCE(e0);	
AgrtB_N <= OR_REDUCE(e1);
AeqB_N  <= AND_REDUCE(e2); 

--************* Compact description of Adder ****************--
--***********************************************************--

--AlwrB_N <= '1' WHEN  (A_N < B_N)  ELSE '0';
--AgrtB_N <= '1' WHEN  (A_N > B_N)  ELSE '0';
--AeqB_N  <= '1' WHEN  (A_N = B_N)  ELSE '0';

END ARCHITECTURE behavioral;