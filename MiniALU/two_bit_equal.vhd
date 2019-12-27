library ieee;
use ieee.std_logic_1164.all;

entity two_bit_equal is
	port ( a, b	: in std_logic_vector(1 downto 0);
		aeqb	: out std_logic);
end two_bit_equal;

architecture arch of two_bit_equal is
	-- telling compiler which component from library we are using
	component equal
	port (
		I0, I1 : in std_logic;
		Eq	: out std_logic);
	end component;
	signal e0, e1: std_logic;

	begin
	-- instantiates two one-bit comparators
	H1: equal port map(i0=>a(0), i1=>b(0), eq=>e0);
	H2: equal port map(i0=>a(1), i1=>b(1), eq=>e1);

	aeqb <= e0 and e1;

end arch;

	

--ORIGINAL Method - using only logical operators

--architecture arch of two_bit_equal is
--signal p0, p1, p2, p3 : std_logic;
--begin
--aeqb <= p0 or p1 or p2 or p3;
--p0 <= (a(0) and b(0)) and (a(1) and b(1));
--p1 <= (a(0) and b(0)) and ((not a(1)) and (not b(1)));
--p2 <= ((not a(0)) and (not b(0))) and ((not a(1)) and (not b(1)));
--p3 <= ((not a(0)) and (not b(0))) and (a(1) and b(1));

--end arch;


