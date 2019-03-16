library	IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity debounce is
	port(clk,reset: in STD_LOGIC;
	input : in STD_LOGIC_VECTOR(3 downto 0);
	output : out STD_LOGIC_VECTOR(3 downto 0));
end debounce;

architecture debouncer of debounce is
signal delay_1, delay_2, delay_3 : STD_LOGIC_VECTOR(3 downto 0);
begin
	process(clk,reset)
	begin
		if(reset = '1') then  
			
			delay_1 <= "0000";
			delay_2 <= "0000";
			delay_3 <= "0000";	
			
		elsif(clk'event and clk='1') then 
			
			delay_1 <= input;
			delay_2 <= delay_1;
			delay_3 <= delay_2;		  
			
		end if;
	end process;
	 
	output <= delay_1 and delay_2 and delay_3;
end debouncer;