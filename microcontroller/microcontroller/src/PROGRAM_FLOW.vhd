library IEEE;
use	IEEE.STD_LOGIC_1164.all;

entity PFC is
	port(INSTR , ADR : in STD_LOGIC_VECTOR(7 downto 0);
	Zero , Carry : in STD_LOGIC;
	ADR_OUT : out STD_LOGIC_VECTOR(7 downto 0);
	ENABLE , LOAD , M_STIVA, M_SELECT: out STD_LOGIC);
end PFC;

architecture PROGRAM_FLOW of PFC is
begin
	process(INSTR,ADR,ZERO,CARRY)
	begin 
		if( INSTR(1 downto 0)="01" or INSTR(1 downto 0)="11") then
			M_SELECT<='0';	 
		elsif( INSTR(1 downto 0)="00" ) then
			M_SELECT<='1';  
		end if;	
		
		case(INSTR(7 downto 4))is
			when "1000" => LOAD<='1';  --NECONDITIONAT
			when "1001" =>
			case INSTR(3 downto 2) is
				when "00" =>LOAD<=not(ZERO);--if zero
				when "01" =>LOAD<=ZERO;--if not zero
				when "10" =>LOAD<=not(CARRY);--if carry
				when "11" =>LOAD<=CARRY;--if not carry
					when others => LOAD<='0';
				end case;
			when others => LOAD<='0';ENABLE<='0';
			end case; 
			if(INSTR(7 downto 4)="1000" or INSTR(7 downto 4)="1001") then
				if(INSTR(1 downto 0)="00" or INSTR(1 downto 0)="11") then --verificam daca este o instr de tip call sau RETURN
					ENABLE<='1';
				end if;
				M_STIVA<=INSTR(0);--INsTR(0)=1 atunci facem Call, adica stiva va face PUSH, PUSH='1';
								  --INsTR(0)=0 atunci facem Return, adica stiva va face POP, PUSH='0';
				if INSTR(0)='1' then
						ADR_OUT<=ADR;--retinem adresa pentru call sau jump
					elsif INSTR(0)='0' then
						ADR_OUT<="XXXXXXXX";
				end if;
			end if;

		end process;
end PROGRAM_FLOW;
				
				
				
	