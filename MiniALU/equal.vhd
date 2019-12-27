Library ieee;
use ieee.std_logic_1164.all;

entity equal is 
	port ( I0, I1 : in std_logic;
		Eq, Eqnot	: out std_logic);
end equal;


architecture arch of equal is
	begin 
	EQ <= I0 xnor I1;
	EQnot <= I0 xor I1;
end arch;

-- ORIGINAL method of using logical operators - can save time using xnor
--architecture arch of equal is 
--	signal p0, p1 : std_logic;
--	begin
--	EQ <= p0 or p1; 
--	p0 <= (not I0) and (not I1);
--	p1 <= I0 and I1;
--end arch;


