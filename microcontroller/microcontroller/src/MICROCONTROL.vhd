library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity proc is
	port(RESET_M : IN STD_LOGIC;
	CLOCK : in STD_LOGIC;
	anod : out STD_LOGIC_VECTOR(3 downto 0);
 	catod : out STD_LOGIC_VECTOR(6 downto 0));
end proc;

architecture arh_proc of proc is

component Numarator is
	port (CLK , RESET , LOAD :in STD_LOGIC;
	LOAD_ADR : in STD_LOGIC_VECTOR(7 downto 0);
	IN_adresa : out STD_LOGIC_VECTOR(7 downto 0));
end component;

component ALU is
	port (CIN : in STD_LOGIC;
	COD : in STD_LOGIC_VECTOR(4 downto 0);
	A : in STD_LOGIC_VECTOR(7 downto 0); 
	B : in STD_LOGIC_VECTOR(7 downto 0);	
	Y_ALU : out STD_LOGIC_VECTOR(7 downto 0);
	carry,zero_flag:out STD_LOGIC);
end component;

component register_file is
port (clk : in std_logic;
	REG1 : in std_logic_vector (3 downto 0);--adresa primului reg
	REG2 : in std_logic_vector (3 downto 0);--a 2-a adresa
	WRITE:in STD_LOGIC;--daca el este activat, atunci se scrie in reg de scriere  
	W_DATA : in std_logic_vector (7 downto 0);--ce scriem in registru
	RD1 : out std_logic_vector (7 downto 0);--datele din primul reg
	RD2 : out std_logic_vector (7 downto 0));--datele din al 2-lea reg
end component;	

component DECODIFICATOR is
port(INSTR_IN:in STD_LOGIC_VECTOR(15 downto 0);
	CLK:in STD_LOGIC;
	CONST,JCR:out STD_LOGIC_VECTOR(7 downto 0);	
	ADR : out STD_LOGIC_VECTOR(7 downto 0);
	COD:out STD_LOGIC_VECTOR(4 downto 0);
	REG1:out STD_LOGIC_VECTOR(3 downto 0);
	REG2:out STD_LOGIC_VECTOR(3 downto 0);
	k_sel : out STD_LOGIC);
end component;

component MUX is
	port(Y_MUX, I2	: in STD_LOGIC_VECTOR(7 downto 0);
	S : in STD_LOGIC;
	Y : out STD_LOGIC_VECTOR(7 downto 0));
end component; 

component div is
	port (clk_div :in STD_LOGIC;
	clk_out : out STD_LOGIC);
end component;

component STIVA is
	port(PUSH , ENABLE , RESET : in STD_LOGIC;
	ADR_IN : in STD_LOGIC_VECTOR(7 downto 0);
	ADR_OUT: out STD_LOGIC_VECTOR(7  downto 0));
end component;

component PFC is
	port(INSTR , ADR : in STD_LOGIC_VECTOR(7 downto 0);
	Zero , Carry : in STD_LOGIC;
	ADR_OUT : out STD_LOGIC_VECTOR(7 downto 0);
	ENABLE , LOAD , M_STIVA , M_SELECT : out STD_LOGIC);
end component;	

component MEMORIE is
port(ADR: in STD_LOGIC_VECTOR(7 downto 0);
INSTR_OUT: out STD_LOGIC_VECTOR(15 downto 0));
end component; 

component DISPLAY is
	port(CLK: in STD_LOGIC;
	I:in STD_LOGIC_VECTOR(7 downto 0);
	CAT: out STD_LOGIC_VECTOR(6 downto 0);
	AN: out STD_LOGIC_VECTOR(3 downto 0));
end component;

signal ROM_OUT : STD_LOGIC_VECTOR(15 DOWNTO 0);
signal CONST_ALU , ADRESA_IN , REG_OR_CONST ,ADR_DECOD , PFC_OR_STACK : STD_LOGIC_VECTOR(7 DOWNTO 0);
signal COD_ALU : STD_LOGIC_VECTOR(4 DOWNTO 0); 
signal REG1_FILE,REG2_FILE : STD_LOGIC_VECTOR(3 DOWNTO 0);
signal K_SELECT , clk_div , ENABLE_STACK , LOAD_COUNT , ENABLE_STACK_MODE , P_S: STD_LOGIC;   
signal REGISTER1_OUT , REGISTER2_OUT, Y_OUT , COUNTER_LOAD , LOAD_FROM_STACK , JCR_S: STD_LOGIC_VECTOR(7 DOWNTO 0); 
signal CARRY_OUT , ZERO_FLAG : STD_LOGIC;   
signal CIN : STD_LOGIC:='0'; 



begin 
	--P0 : div port map (CLOCK , clk_div);	
	
	P1 : MEMORIE port map( ADRESA_IN , ROM_OUT );
	
	P2 : Numarator port	map (CLOCK  , RESET_M , LOAD_COUNT , PFC_OR_STACK ,  ADRESA_IN);    		  
	
	P3 : DECODIFICATOR port map(ROM_OUT, CLOCK , CONST_ALU , JCR_S ,ADR_DECOD, COD_ALU, REG1_FILE , REG2_FILE ,K_SELECT);	
	
	P4 : PFC port map ( JCR_S , ADR_DECOD , ZERO_FLAG , CIN , COUNTER_LOAD , ENABLE_STACK , LOAD_COUNT , ENABLE_STACK_MODE , P_S);
	
	PDA : MUX port  map(COUNTER_LOAD , LOAD_FROM_STACK , P_S , PFC_OR_STACK);
	
	P5 : register_file port map(CLOCK  ,REG1_FILE , REG2_FILE , K_SELECT , REGISTER1_OUT , REGISTER1_OUT , REGISTER2_OUT);
	
    P6 : STIVA port map(ENABLE_STACK_MODE , ENABLE_STACK , RESET_M , ADRESA_IN , LOAD_FROM_STACK);
	
    P7 : MUX port  map ( CONST_ALU , REGISTER2_OUT , K_SELECT ,  REG_OR_CONST);	   
	
	P8 : ALU port map (CIN, COD_ALU , REGISTER1_OUT , REG_OR_CONST ,Y_OUT ,CARRY_OUT, ZERO_FLAG); 	
	
	--PF : DISPLAY port map(CLOCK , Y_OUT , catod , anod); 
	
	
	
end arh_proc;



