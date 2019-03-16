library IEEE;
use IEEE.STD_LOGIC_1164.all; 

entity HEX_TO_7SEG is
	port(X: in STD_LOGIC_VECTOR(3 downto 0);
	LED: out STD_LOGIC_VECTOR(6 downto 0));
end HEX_TO_7SEG;

architecture DECOD of HEX_TO_7SEG is
begin
	process(X)
	begin
		case X is
			when X"1" => LED <="1111001";  --1
			when X"2" => LED <="0100100";  --2
			when X"3" => LED <="0110000";  --3
			when X"4" => LED <="0011001";  --4
			when X"5" => LED <="0010010";  --5
			when X"6" => LED <="0000010";  --6
			when X"7" => LED <="1111000";  --7
			when X"8" => LED <="0000000";  --8
			when X"9" => LED <="0010000";  --9
			when others => LED <="1000000"; --0 
		end case;
	end process;
end DECOD;

         
         
         