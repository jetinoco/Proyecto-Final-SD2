library ieee;
use ieee.std_logic_1164.all;

entity comparador_de_4bits is
	generic (n: integer := 4);
	port ( A,B: in std_logic_vector(n-1 downto 0);
		 MAYOR,IGUAL,MENOR: out std_logic);
end comparador_de_4bits;

architecture sol of comparador_de_4bits is
begin
	MAYOR <= '1' when (A>B) else '0';
	IGUAL <= '1' when (A=B) else '0';
	MENOR <= '1' when (A<B) else '0';
end sol;