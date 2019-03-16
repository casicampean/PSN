					 library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use STD_LOGIC_ARITH.all;
use STD_LOGIC_UNSIGNED.all;

entity DEC_DISPLAY is
	port(I: in STD_LOGIC_VECTOR(7 downto 0);
	OUT1,OUT2,OUT3:out STD_LOGIC_VECTOR(3 downto 0));
end DEC_DISPLAY;

architecture DEC of DEC_DISPLAY is
component DISPLAY is
	port(CLK: in STD_LOGIC;
	D0: in STD_LOGIC_VECTOR(3 downto 0);
	D1: in STD_LOGIC_VECTOR(3 downto 0);
	D2: in STD_LOGIC_VECTOR(3 downto 0);
	D3: in STD_LOGIC_VECTOR(3 downto 0); 
	CAT: out STD_LOGIC_VECTOR(6 downto 0);
	AN: out STD_LOGIC_VECTOR(3 downto 0));
end component;

signal OUT4 : STD_LOGIC_VECTOR(3 DOWNTO 0) :="0000";
begin 
	process(I)
    variable NR1,NR2,NR3:STD_LOGIC_VECTOR(3 downto 0);
    variable C,X0,X1,X2:INTEGER;
	begin	 
		C:=conv_integer(I);
		X0:=C mod 10;
		NR1:=conv_std_logic_vector(X0,4); 
		X1:=(C/10)mod 10;
		NR2:=conv_std_logic_vector(X1,4); 
		X2:=(C/100)mod 10;
		NR3:=conv_std_logic_vector(X2,4); 
		OUT1<=NR1;
	    OUT2<=NR2;
	    OUT3<=NR3;
		
	end process;  


	
end DEC;