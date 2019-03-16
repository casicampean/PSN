library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MEMORIE is
port(ADR: in STD_LOGIC_VECTOR(7 downto 0);
INSTR_OUT: out STD_LOGIC_VECTOR(15 downto 0));
end MEMORIE;

architecture MEM of MEMORIE is
type tip_mem is array(255 downto 0) of STD_LOGIC_VECTOR(15 downto 0);

signal MEM:tip_mem := 
(
0=>"0000001000000001", --LOAD 1	  		
1=>"1000001100000011", --call 3
2=>"0000011000000000",--LOAD 0
--3=>"1000100100001010", --JUMP TO 10
 		

3=>"0001011001001101", --AND 47 77 00001101 (13)
4=>"0010011001001101",--OR 47 77 1101111 (111)	
5=>"0011011001001101",--XOR 47 111 1100010(98)  
6=>"0100110001100100",--ADD S12=100 01100100+KK=100 =200(11001000)
7=>"0101100000110111", --ADDCY S8 167 10100111=+KK=55 =222 11011110
8=>"0110100100101000",--SUB SX=90 01011010-KK 00101000=40 =50(00110010)
--9=>"1000000010000000",--RETURN(ADR JUMP NECOND)	
9=>"0111001100010111",--SUBCY 78 01001110-23 00010111=55-1	   s3
--11=>"1001101100001101",--CALL CONDITIONAT 13
10=>"1001100100001110",--JUMP CONDITIONAL 
11=>"0000001000000001", --LOAD 1
12=>"0000001000000001", --LOAD 1	 
13=>"0000001000000001", --LOAD 1

14=>"1100000100100000",--LOAD S1 S2 --24
15=>"1100110010100001",--AND 01100100 (100) 213 11010101 (68)1000100
16=>"1100110010100010",--OR 11110101(245)
17=>"1100110010100011",--XOR 10110001 177
18=>"1100010001110100",--ADD 138(10001010)+75 01001011=213 11010101	  s4  s7
19=>"1100110011100101", --ADDCY 100 01100100+114 01110010=214 11010110  s10  s14
20=>"1100101111010110",--SUB 43 -33 00100001=10 00001010	 s11 s13
21=>"1100010100100111",--SUBCY 164 10100100-24 01000000=100 01100100	139   s5  s2

	
--21=>"1001100010000000",	--RETURN(ADR JUMP COND) 12


22=>"1101001100001110",--SR0	 s3	  --39	27
23=>"1101011000001111",--SR1	 s6	 151 97
24=>"1101100100001010",--SRX	 s9	 45 2D
25=>"1101110000001000",--SRA	s12	 178 B2
26=>"1101111100001100",--RR	s15	  32 20

27=>"1001110100000111",--JMP INVALID
28=>"1101001100000110",--SL0	  s3
29=>"1101011000000111",--SL1	  s6
30=>"1101100100000100",--SLX	  s9
31=>"1101110000000000",--SLA	  s12
32=>"1101111100000011",--RL	 s15
others=>"0000000000000000");


begin  

process(ADR)
begin

INSTR_OUT<=MEM(conv_integer(ADR));
end process;
end architecture MEM;

