library	IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Numarator is
	port (CLK , RESET , LOAD :in STD_LOGIC;
	LOAD_ADR : in STD_LOGIC_VECTOR(7 downto 0);
	IN_adresa : out STD_LOGIC_VECTOR(7 downto 0));
end Numarator;

architecture Count of Numarator is 

begin				  	 
	
	process(clk,reset) 
	variable aux : STD_LOGIC_VECTOR(7 downto 0);
	begin		   
		if(reset='1') then 
			aux:="00000000";
		elsif(clk'event and clk='1') then
			if (LOAD='1') then
			  aux:=LOAD_ADR;
			elsif (LOAD='0')then 
				if(aux<"00100001") then
					aux:=aux+1;
				else
				aux:="00000000";
				end if;
		   end if;
		end if;
		IN_adresa <= aux;
	end process; 
	
end Count;
