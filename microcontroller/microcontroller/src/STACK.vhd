library	IEEE;
use	IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity STIVA is
	port(PUSH , ENABLE , RESET : in STD_LOGIC;
	ADR_IN : in STD_LOGIC_VECTOR(7 downto 0);
	ADR_OUT: out STD_LOGIC_VECTOR(7  downto 0));
end STIVA;

architecture STIVA_ARH of STIVA is
type memorie is array(0 to 14) of STD_LOGIC_VECTOR(0 to 7);

signal ADRESE : memorie;

begin
	process(PUSH , ENABLE , RESET , ADR_IN)
	variable POZ : integer:=14;
	begin
		if (RESET='1') then --are loc resetarea stivei
			for i in 0 to 14 loop
				ADRESE(i)<="00000000";
			end loop;	
	end if;
			if(ENABLE='1') then		  --daca avem CALL respectiv RETURN
				if(PUSH='1') then	  --inseram in stiva
					if(POZ>=1) THEN
						ADRESE(POZ)<=ADR_IN;
						POZ:=POZ-1;
					end if;
					ADR_OUT <= "ZZZZZZZZ"; --adresa o luam de la program flow
				else
					if(POZ < 14) then    --daca PUSH=0  atunci facem pop
						POZ:=POZ+1;
						ADR_OUT<=ADRESE(POZ) - 1 ;
					end if;
				end if;
			 elsif (ENABLE='0') then
				 ADR_OUT <= "ZZZZZZZZ";
			end if;
	end process;
end	STIVA_ARH;	