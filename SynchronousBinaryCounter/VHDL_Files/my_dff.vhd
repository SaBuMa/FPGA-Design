--******************* LIBRARY DEFINITION ********************--
--***********************************************************--
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

--***************** ENITY = Inputs Outputs ******************--
--***********************************************************--
ENTITY my_dff IS
	PORT(	clk	:	IN		STD_LOGIC;
			rst	:	IN		STD_LOGIC;
			ena	:	IN		STD_LOGIC;
			d		:	IN		STD_LOGIC;
			q		:	OUT	STD_LOGIC
		 ); 

END my_dff;

--**************** Parameterized description ****************--
--***********************************************************--
ARCHITECTURE rtl OF my_dff IS
begin
	dffprn: PROCESS(clk,rst,d)
	BEGIN
		IF(rst='1') THEN
				q<='0';	
		ELSIF (rising_edge(clk)) THEN
				IF(ena ='1') THEN
					q<=d;
				END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE;