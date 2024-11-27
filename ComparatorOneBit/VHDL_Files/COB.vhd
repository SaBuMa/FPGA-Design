--******************* Comparator One Bit ********************--
--***********************************************************--

--******************* LIBRARY DEFINITION ********************--
--***********************************************************--
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL; -- Used to implement the adder
											-- In a compact description

--***************** ENITY = Inputs Outputs ******************--
--***********************************************************--
ENTITY COB IS PORT 
( 
	A_in, B_in				: IN STD_LOGIC; 
	AeqB, AgrtB, AlwrB	: OUT STD_LOGIC 
-- AeqB -> A = B // AgrtB -> A > B // AlwrB -> A < B
);
END COB;

--************ INTERCONNECTION BETWEEN SIGNALS **************--
--***********************************************************--
ARCHITECTURE behavioral OF COB IS

--******************* Auxiliary cables **********************--
--***********************************************************--
	SIGNAL e0, e1	: STD_LOGIC; -- e --> Equations
--	SIGNAL aux		: STD_LOGIC_VECTOR(1 downto 0);

--******************** Module Description *******************--
--***********************************************************--
BEGIN
-- Auxiliary Equations
e0		<= (NOT A_in) AND B_in; -- A < B
e1		<= (NOT B_in) AND A_in; -- A > B

AlwrB		<= e0;
AgrtB		<= e1;
AeqB		<= e0 XNOR e1;			-- A = B

--************* Compact description of Adder ****************--
--***********************************************************--

--AlwrB <= '1' WHEN  (A_in < B_in)  ELSE '0';
--AgrtB <= '1' WHEN  (A_in > B_in)  ELSE '0';
--AeqB 	<= '1' WHEN  (A_in = B_in)  ELSE '0';

END ARCHITECTURE behavioral;