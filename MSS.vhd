library ieee;
use ieee.std_logic_1164.all;

entity MSS is
port ( 	Clock, Resetn: IN STD_LOGIC;
			Encender, Start, RemojarSost, Delicado, Normal, Toallas, Jeans, Lleno, Tc: IN STD_LOGIC;
			Valvula, Centrifugar, Bomba, EnCnt, EnCntGir, Td0, Td1, Td2, Td3, Td4, ResetFF :OUT STD_LOGIC;
			Est: OUT STD_LOGIC_VECTOR(3 downto 0));
end MSS;

architecture proceso of MSS is
type estado is (E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12, E13,E14);
signal y: estado;
begin 
	process (Resetn, Clock)
	begin
	if Resetn='0' then y <= E1;
	elsif (Clock'event and Clock ='1') then 
		case y is
			when E1 => if Encender='1' then y <= E2; else y <= E1; end if;
			when E2 => if Encender='0' then y <= E3; else y <= E2; end if;
			when E3 => if Start='1' then y <= E4; else y <= E3; end if;
			when E4 => if Start='0' then y <= E5; else y <= E4; end if;
			
			when E5 => if Lleno='1' and RemojarSost='1' then y <= E6;
		              elsif Lleno ='1'and RemojarSost='0' then y<= E7;
						  else y<= E5; end if;
						  
			when E6 => if Tc='1' then y<= E7; else y<= E6; end if;
			
		
			when E7 => if Delicado='1' and Tc='1' then y<= E8; 
			           elsif Normal='1' and Tc='1' then y<= E8;
						  elsif Toallas='1' and Tc='1' then y<= E8;
						  elsif Jeans='1' and Tc='1' then y<= E8;
			           else y<= E7; end if;
			
			
			
			when E8 => if Delicado='1' and Tc='1' then y<= E9; 
			           elsif Normal='1' and Tc='1' then y<= E9;
						  elsif Toallas='1' and Tc='1' then y<= E9;
						  elsif Jeans='1' and Tc='1' then y<= E9;
			           else y<= E8; end if;
			
			
			when E9 => if Lleno='1' then y<=E10; else y<=E9; end if;
			
			
			
			when E10 => if Delicado='1' and Tc='1' then y<= E11; 
			            elsif Normal='1' and Tc='1' then y<= E11;
						   elsif Toallas='1' and Tc='1' then y<= E11;
						   elsif Jeans='1' and Tc='1' then y<= E11;
			            else y<= E10; end if;
			
			
			-- Este es el estado final en el programa Delicado
			
			
			when E11 => if Delicado='1' and Tc='1' then y<= E3; 
			            elsif Normal='1' and Tc='1' then y<= E12;
						   elsif Toallas='1' and Tc='1' then y<= E12;
						   elsif Jeans='1' and Tc='1' then y<= E12;
			            else y<= E11; end if;
			
			
			when E12 => if Lleno='1' then y<=E13; else y<=E12; end if;
			
			when E13 => if Normal='1' and Tc='1' then y<= E14;
						   elsif Toallas='1' and Tc='1' then y<= E14;
						   elsif Jeans='1' and Tc='1' then y<= E14;
			            else y<= E13; end if;
							
							
			
			
			when E14 => if Normal='1' and Tc='1' then y<= E3;
						   elsif Toallas='1' and Tc='1' then y<= E3;
						   elsif Jeans='1' and Tc='1' then y<= E3;
			            else y<= E14; end if;
			            
			
			
			
		end case;
	end if;
	end process;
	
	process (y)
	begin
	   Valvula<='0'; Centrifugar<='0'; Bomba<='0'; EnCnt<='0'; EnCntGir<='0'; Td0<='0'; Td1<='0'; Td2<='0'; Td3<='0'; Td4<='0'; ResetFF<='0';
		case y is
		   -- Para no obtener error al simular en Tina, cada estado debe tener al menos una asignacion de salida, por eso uso una variable Test sin usar
			when E1 => Est<="0001";
			
			when E2 => Est<="0010";
			
			when E3 => Est<="0011";
		
			when E4 => Est<="0100";
			
			when E5 => Est<="0101";Valvula<='1'; 
			
			when E6 => Est<="0110";EnCnt<='1'; Td1<='1'; Td2<='1'; Td3<='1'; Td4<='1'; 

			
			when E7 => Est<="0111";EnCnt<='1'; EnCntGir<='1';
			           if Delicado='1' then Td0<='1'; Td1<='1'; 
			           elsif Normal='1' then Td3<='1';
						  elsif Toallas='1' then Td3<='1'; Td2<='1';
						  elsif Jeans='1' then Td4<='1'; Td1<='1';
						  end if;
			
			
			
			when E8 => Est<="1000";EnCnt<='1'; Centrifugar<='1'; Bomba<='1';
			           if Delicado='1' then Td0<='1'; 
			           elsif Normal='1'  then Td1<='1';
						  elsif Toallas='1' then Td1<='1'; Td0<='1';
						  elsif Jeans='1' then Td2<='1'; end if;
			
			
			
			when E9 => Est<="1001";Valvula<='1';
			
			
			
			when E10 => Est<="1010";EnCnt<='1'; EnCntGir<='1';
			            if Delicado='1' then Td1<='1'; 
			            elsif Normal='1' then Td2<='1'; Td1<='1';
						   elsif Toallas='1' then Td3<='1'; Td1<='1'; Td0<='1';
						   elsif Jeans='1' then Td3<='1'; Td2<='1'; Td0<='1';end if;

			
			
			when E11 => Est<="1011";EnCnt<='1'; Centrifugar<='1'; Bomba<='1';
			            if Delicado='1' then Td1<='1'; 
			            elsif Normal='1' then Td1<='1';
						   elsif Toallas='1' then Td1<='1'; Td0<='1'; end if;
			
			
			
			when E12 => Est<="1100";Valvula<='1';
			
			
			
			when E13 => Est<="1101";EnCnt<='1'; EnCntGir<='1';
			            if Normal='1' then Td2<='1'; Td1<='1';
						   elsif Toallas='1' then Td3<='1'; Td1<='1'; Td0<='1';
						   elsif Jeans='1' then Td3<='1'; Td2<='1'; Td0<='1';end if;

			
			when E14 => Est<="1110";EnCnt<='1'; Centrifugar<='1'; Bomba<='1';
			            if Normal='1' then Td2<='1';
						   elsif Toallas='1' then Td1<='1'; Td0<='1';
						   elsif Jeans='1' then Td2<='1'; Td1<='1';end if;
			            if Tc='1' then ResetFF<='1'; end if; 
			
			
		end case;
	end process;
end proceso;