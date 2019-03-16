library	IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;	
use IEEE.NUMERIC_STD.ALL;

entity ALU is
	port (CIN : in STD_LOGIC;
	COD : in STD_LOGIC_VECTOR(4 downto 0);
	A : in STD_LOGIC_VECTOR(7 downto 0); 
	B : in STD_LOGIC_VECTOR(7 downto 0);	
	Y_ALU : out STD_LOGIC_VECTOR(7 downto 0);
	carry,zero_flag:out STD_LOGIC);
end ALU;

architecture ALU1 of ALU is

begin
	process(A,B,COD)
	variable carry_aux : STD_LOGIC_VECTOR(7 downto 0);
	variable y_rez : STD_LOGIC_VECTOR(7 downto 0);
	variable zero_aux :STD_LOGIC;
	variable car : STD_LOGIC :='1';
	begin
		carry<='0';	
		zero_aux :='0';
		case COD is   
			
			--logic group
			when "00000"=> 
				y_rez:=B;
				carry <= CIN;
			
			when "00001" =>
				y_rez := A and B;
				carry <= '0';
			
			when "00010" => 
				y_rez := A or B;
				carry <= '0';
			
			when "00011" =>
				y_rez := A xor B;
				carry <= '0';  
			
			--aritmetic group
			
			when "00100" =>
				y_rez :=  A + B;	 
			
				carry_aux(0) :=A(0) and B(0);
			
				for j in 1 to 7 loop
					carry_aux(j) := (A(j) and B(j)) or (A(j) and carry_aux(j-1)) or (B(j) and carry_aux(j-1));
				end loop;
				carry <= carry_aux(7);
			
			when "00101" =>  
				y_rez :=  A + B + car; 
			
				carry_aux(0) := (A(0) and B(0)) or (A(0) and car) or (B(0) and car);
			
				for j in 1 to 7 loop
					carry_aux(j) := (A(j) and B(j)) or (A(j) and carry_aux(j-1)) or (B(j) and carry_aux(j-1));
				end  loop;
				carry <= carry_aux(7);			
			
			when "00110" =>
				y_rez := A - B;
			
				if (TO_INTEGER(UNSIGNED(A)) < TO_INTEGER(UNSIGNED(B))) then
					carry <= '1';
				else
					carry <= '0';
				end if; 
				
			when "00111" =>
				y_rez := A - B - car;  
			
				if (TO_INTEGER(UNSIGNED(A)) < TO_INTEGER(UNSIGNED(B))) then
					carry <= '1';
				else
					carry <= '0';
				 
				end if;
			--shift and rotate right
			when "01000" =>
				carry <= A(0);
				for k in 7 downto 1 loop
					y_rez(k-1) := A(k);
				end loop;
				y_rez(7):='0';	   --SR0
			when "01001" =>
				carry <= A(0);
				for k in 7 downto 1 loop
					y_rez(k-1) := A(k);
				end loop;
				y_rez(7):='1';		--SR1
			when "01010" =>
				carry <= A(0);
				for k in 7 downto 1 loop
					y_rez(k-1) := A(k);
				end loop;
				y_rez(7):=y_rez(6);	   --SRX
			when "01011" =>
				carry <= A(0);
				for k in 7 downto 1 loop
					y_rez(k-1) := A(k);	  --SRA
				end loop;
				y_rez(7):=car;	
			when "01100" =>			  
				carry <= A(0);
				for k in 7 downto 1 loop
					y_rez(k-1) := A(k);
				end loop;
				y_rez(7):=A(0);	 		 --ROTATE RIGHT
				
			--shift and  rotate left	 
			
			when "01101" =>
				carry <= A(7);
				for k in 6 downto 0 loop
					y_rez(k+1) := A(k);
				end loop;
				y_rez(0):='0';				  --SL0
			when "01110" =>
				carry <= A(7);
				for k in 6 downto 0 loop
					y_rez(k+1) := A(k);
				end loop;
				y_rez(0):='1'; 				 --SL1
			when "01111" =>
				carry <= A(7);
				for k in 6 downto 0 loop
					y_rez(k+1) := A(k);
				end loop;
				y_rez(0):=A(0);				  --SLX
			when "10000" =>
				carry <= A(7);
				for k in 6 downto 0 loop
					y_rez(k+1) := A(k);
				end loop;
				y_rez(0):=car; 				  --SLA
			when "10001" =>				
				carry <= A(7);
				for k in 6 downto 0 loop
					y_rez(k+1) := A(k);
				end loop;
				y_rez(0):=A(7);				   --ROTATE LEFT
			 when "11000" =>
			 	y_rez:=B;
			when others => y_rez:="00000000";
		end case; 
		
		for i in 0 to 7 loop
		zero_aux := zero_aux or y_rez(i);  
		end loop; 
		
	zero_flag<= not(zero_aux);
	Y_ALU <= y_rez;
 end process;
end ALU1;
