library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity register_file is
port (clk : in std_logic;
	REG1 : in std_logic_vector (3 downto 0);--adresa primului reg
	REG2 : in std_logic_vector (3 downto 0);--a 2-a adresa
	WRITE:in STD_LOGIC;--daca el este activat, atunci se scrie in reg de scriere  
	--RESET : IN STD_LOGIC;
	W_DATA : in std_logic_vector (7 downto 0);--ce scriem in registru
	RD1 : out std_logic_vector (7 downto 0);--datele din primul reg
	RD2 : out std_logic_vector (7 downto 0));--datele din al 2-lea reg
end register_file;

architecture REG of register_file is
type REGISTRII is array (0 to 15) of std_logic_vector(7 downto 0);
signal reg_file : REGISTRII:=(
0=>"00010111", --23
1=>"00000110", --6
2=>"00011000", --24
3=>"01001110",	--78
4=>"10001010",  --138
5=>"10100100",	--164
6=>"00101111",  --47
7=>"01001011",	--75
8=>"10100111", --167
9=>"01011010", --90
10=>"11010101",--213
11=>"00101011",--43
12=>"01100100", --100
13=>"00100001",	--33
14=>"01110010",	--114
15=>"01000000",	--64
others=>"00000000");
begin
	
process(CLK,REG1,REG2) 
begin
	if rising_edge(CLK) then 
		if WRITE = '1' then
			reg_file(conv_integer(REG1)) <= W_DATA;
		end if;
		end if;
end process;
RD1 <= reg_file(conv_integer(REG1));
RD2 <= reg_file(conv_integer(REG2));
end REG;