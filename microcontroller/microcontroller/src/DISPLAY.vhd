library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

entity DISPLAY is
	port(CLK: in STD_LOGIC;
	I:in STD_LOGIC_VECTOR(7 downto 0);
	CAT: out STD_LOGIC_VECTOR(6 downto 0);
	AN: out STD_LOGIC_VECTOR(3 downto 0));
end DISPLAY;

architecture DISPLAY_7 of DISPLAY is

component HEX_TO_7SEG is
	port(X : in STD_LOGIC_VECTOR (3 downto 0);
         LED : out STD_LOGIC_VECTOR (6 downto 0));
end component HEX_TO_7SEG;	

component DEC_DISPLAY is
	port(I: in STD_LOGIC_VECTOR(7 downto 0);
	OUT1,OUT2,OUT3:out STD_LOGIC_VECTOR(3 downto 0));
end component; 

component INV_DIV is
	port (clk_div :in STD_LOGIC;
	clk_out : out STD_LOGIC);
end component;

signal clk_div : STD_LOGIC;
signal count:STD_LOGIC_VECTOR(1 downto 0);
signal selection:STD_LOGIC_VECTOR(1 downto 0);
signal outMUX:STD_LOGIC_VECTOR(3 downto 0);	 
signal D0,D1,D2,D3:STD_LOGIC_VECTOR(3 downto 0);

begin 
invdiv : INV_DIV port map(CLK,clk_div);
counter: process(clk_div)
begin
	if((clk_div='1' and clk_div'event)) then 
		count <= count+1;
	end if;
end process;

selection<=count(1 downto 0);

catMUX: process (selection)
begin
case selection is
    when "00" => outMUX<=D0;
    when "01" => outMUX<=D1;
    when "10" => outMUX<=D2;
    when others => outMUX<=D3;
end case;
end process;

anMUX: process (selection)
begin
case selection is
    when "00" => AN<="1110";
    when "01" => AN<="1101";
    when "10" => AN<="1011";
    when others => AN<="0111";
end case;
end process;

HEXConverter: HEX_TO_7SEG port map(outMUX, CAT);  
CIFRE:DEC_DISPLAY port map(I,D0,D1,D2);

end DISPLAY_7;
