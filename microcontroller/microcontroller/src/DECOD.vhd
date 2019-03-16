library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DECODIFICATOR is
port(INSTR_IN:in STD_LOGIC_VECTOR(15 downto 0);
CLK:in STD_LOGIC;
CONST , JCR:out STD_LOGIC_VECTOR(7 downto 0);
ADR : out STD_LOGIC_VECTOR(7 downto 0);
COD:out STD_LOGIC_VECTOR(4 downto 0);
REG1:out STD_LOGIC_VECTOR(3 downto 0);
REG2:out STD_LOGIC_VECTOR(3 downto 0); 
k_sel : out STD_LOGIC);
end DECODIFICATOR;

architecture DEC of DECODIFICATOR is

begin
process(INSTR_IN,CLK)
begin
--2 registrii

if INSTR_IN(15 downto 12)="1100" then
COD<="0" & INSTR_IN(3 downto 0);
REG1<=INSTR_IN(11 downto 8);
REG2<=INSTR_IN(7 downto 4);
CONST<="00000000";
JCR<="00000000";
end if;



-- registru si constanta

if INSTR_IN(15 downto 12) <="0111" then
COD<="0" & INSTR_IN(15 downto 12);
REG1<=INSTR_IN(11 downto 8);
CONST<=INSTR_IN(7 downto 0);
REG2<="0000";
JCR<="00000000";
end if;


if INSTR_IN(15 downto 12)="1101" and INSTR_IN(7 downto 3)="00001" then--shift right
REG1<=INSTR_IN(11 downto 8);
JCR<="00000000";
case INSTR_IN(2 downto 0) is
	when "110" => COD<="01000";--sr0
	when "111" => COD<="01001";--sr1
	when "010" => COD<="01010";--srx
	when "000" => COD<="01011";--sra
	when "100" => COD<="01100";--rr	 
	when others =>COD<="01000";	--sr0
end case;
end if;

if INSTR_IN(15 downto 12)="1101" and INSTR_IN(7 downto 3)="00000" then--shift left
REG1<=INSTR_IN(11 downto 8); 
JCR<="00000000";
case INSTR_IN(2 downto 0) is
	when "110" => COD<="01101";--sl0
	when "111" => COD<="01110";--sl1
	when "100" => COD<="01111";--slx
	when "000" => COD<="10000";--sla
	when "011" => COD<="10001";--rl	 
	when others =>COD<="01101";--sl0
end case;
end if;
--program control group

if ((INSTR_IN(15 downto 12)="1000") or (INSTR_IN( 15 downto 12)="1001")) then --JUMP/CALL/RETURN
	ADR<=INSTR_IN(7 downto 0);
	JCR<=INSTR_IN(15 downto 8); 
	CONST<="00000000"; 
	COD<="11000";
end if;
	
if(INSTR_IN(15 downto 12)="1100") then
	k_sel <='1';
else
	k_sel <='0';
end if;
end process;


end DEC;