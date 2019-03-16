library	IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MUX is
	port(Y_MUX, I2	: in STD_LOGIC_VECTOR(7 downto 0);
	Y : out STD_LOGIC_VECTOR(7 downto 0);
	S : in STD_LOGIC);
end MUX;

architecture MUX2_1 of MUX is
begin
	process(S, Y_MUX, I2)
	begin
		case S is
			when '0' => Y <= Y_MUX;
			when '1' => Y <= I2; 
			when others => Y <="00000000";
		end case;
	end process;
end MUX2_1;