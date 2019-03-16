library	IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity div is
	port (clk_div :in STD_LOGIC;
	clk_out : out STD_LOGIC);
end div;

architecture div_frecventa of div is 
signal S: STD_LOGIC;
signal aux : integer:=1;
begin				  
	process(clk_div) 
	begin
	if(clk_div'event and clk_div='1') then
			aux<=aux+1;	 
			if (aux=100000000) then
				aux <= 1;
				S <= NOT(S);
			end if;
		end if;	 
	end process; 
clk_out <= S;
	
end div_frecventa;