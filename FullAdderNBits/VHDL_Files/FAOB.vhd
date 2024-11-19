--******************* LIBRARY DEFINITION ********************--
--***********************************************************--
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL; -- Used to implement the adder
											-- In a compact description

--***************** ENITY = Inputs Outputs ******************--
--***********************************************************--
ENTITY FAOB IS PORT 
( 
	A_in, B_in, C_in	: IN STD_LOGIC; 
	Q_out, C_out		: OUT STD_LOGIC 
);
END FAOB;

--************ INTERCONNECTION BETWEEN SIGNALS **************--
--***********************************************************--
ARCHITECTURE behavioral OF FAOB IS

--******************* Auxiliary cables **********************--
--***********************************************************--
	SIGNAL e0, e1, e2, e3	: STD_LOGIC;
	SIGNAL aux		 			: STD_LOGIC_VECTOR(1 downto 0);

--******************** Module Description *******************--
--***********************************************************--
BEGIN

Output_Q_out:		Q_out <= e1 XOR C_in;

Output_C_out:		C_out <= e3 OR e2;

e1 <= A_in XOR B_in;
e2 <= A_in AND B_in;
e3 <= e1 AND C_in;


--************* Compact description of Adder ****************--
--***********************************************************--

--  aux <= ('0' & A_in) + ('0' & B_in) + C_in;
--  Q_out    <= aux(0); -- 1st bit
--  C_out    <= aux(1); -- 2nd bit

END ARCHITECTURE behavioral;