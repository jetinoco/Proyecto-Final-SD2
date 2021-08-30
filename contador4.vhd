LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY contador4 IS
	PORT(reloj, borrar, cargar, habilcnt, descendente : IN STD_LOGIC;
		 dato_ent : IN STD_LOGIC_VECTOR(3 downto 0);
		 Q : OUT STD_LOGIC_VECTOR (3 downto 0);
		ct_term : OUT STD_LOGIC);
END contador4;

ARCHITECTURE sol OF contador4 IS
SIGNAL conteo: STD_LOGIC_VECTOR(3 downto 0);  -- define un bus de 4 bits
BEGIN
	PROCESS(reloj,borrar,descendente)
	BEGIN
		if borrar='1' then conteo<="0000"; -- borrar asíncrona
  		elsif (reloj'event and reloj='1') then -- flanco ascendente?
			if cargar='1' then conteo<=dato_ent; --carga en paralelo
			elsif habilcnt='1' then    -- habilitado?
				if descendente='0' then conteo<=conteo+1; --incremento
				else conteo<=conteo-1; --decremento
				end if;
			end if;
		end if;
		if (((conteo="0000" and descendente='1')) OR ((conteo="1111" and descendente='0'))) AND habilcnt='1'
			then ct_term<='1';
		else ct_term<='0';
		end if;
		q<=conteo; --transfiere el contenido del registro a las salidas
	END PROCESS;
END sol;