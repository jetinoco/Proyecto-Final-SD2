library ieee;
use ieee.std_logic_1164.all;

entity numeros is
		port ( A,B: out std_logic_vector(3 downto 0));
end numeros;

architecture sol of numeros is
begin
	A<="0101";
	B<="1010";
end sol;