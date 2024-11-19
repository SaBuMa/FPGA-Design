--******************* LIBRARY DEFINITION ********************--
--***********************************************************--
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL; -- Used to implement the adder
											-- In a compact description

--***************** ENTITY = Inputs Outputs ******************--
--***********************************************************--
ENTITY FANB IS
	GENERIC	(	Nbits			:	INTEGER := 4);
	PORT 	(		A_N			:	in 	STD_LOGIC_VECTOR(Nbits-1 DOWNTO 0);
					B_N			: 	in 	STD_LOGIC_VECTOR(Nbits-1 DOWNTO 0);
					Cin			: 	in 	STD_LOGIC;
					Cout			: 	out 	STD_LOGIC;
					Q_N			: 	out 	STD_LOGIC_VECTOR(Nbits-1 DOWNTO 0)
				);
END ENTITY FANB;

--************ INTERCONNECTION BETWEEN SIGNALS **************--
--***********************************************************--

ARCHITECTURE behavioral OF FANB IS

--******************* Auxiliary cables **********************--
--***********************************************************--

	SIGNAL Co					: STD_LOGIC_VECTOR(Nbits-1 DOWNTO 0);
	SIGNAL aux					: STD_LOGIC_VECTOR(Nbits downto 0);

BEGIN
--***************** Module Instantiation ********************--
--***********************************************************--

--FullAdderOneBit_0: ENTITY work.FAOB
--	PORT MAP(	
--				A_in 				=> A_N(0),
--				B_in				=> B_N(0),
--				C_in				=> Cin,
--				C_out 				=> Co(0),
--				Q_out 				=> Q_N(0)
--	);
--	
--FullAdderOneBit_1: ENTITY work.FAOB
--	PORT MAP(
--				A_in 				=> A_N(1),
--				B_in 				=> B_N(1),
--				C_in				=> Co(0),
--				C_out			 	=> Co(1),
--				Q_out 				=> Q_N(1)
--	);
--	
--FullAdderOneBit_2: ENTITY work.FAOB
--	PORT MAP(
--				A_in 				=> A_N(2),
--				B_in 				=> B_N(2),
--				C_in 				=> Co(1),
--				C_out 				=> Co(2),
--				Q_out 				=> Q_N(2)
--	);
--	
--FullAdderOneBit_3: ENTITY work.FAOB
--	PORT MAP(
--				A_in 				=> A_N(3),
--				B_in 				=> B_N(3),
--				C_in  				=> Co(2),
--				C_out 				=> Cout,
--				Q_out 				=> Q_N(3)
--	);

--******************** Generate Module ***********************--
--***********************************************************--

---- First assign the Carry in to the auxiliary cable [0]
--aux(0) <= Cin; 
--
---- Designing the generate function for each adder
--
--Gen_proc : for i in 0 to (Nbits-1) generate
--FullAdderOneBit: ENTITY work.FAOB
--	PORT MAP(
--				A_in 				=> A_N(i),
--				B_in 				=> B_N(i),
--				C_in  			=> aux(i),
--				C_out 			=> aux(i+1),
--				Q_out 				=> Q_N(i)
--	);
--  end generate Gen_proc;
--
-- -- Assigning the last bit of the Auxiliary Cable to the Cout_N
--Cout <= aux(Nbits);
	
--****************** Compact Description ********************--
--***********************************************************--

  aux 		<= ('0' & A_N) + ('0' & B_N) + Cin;
  Q_N     <= aux (Nbits-1 downto 0); 	-- Nbits-1 bits
  Cout    <= aux (Nbits);          		-- Nbits bit
	
END ARCHITECTURE behavioral;