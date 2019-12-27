library ieee;
use ieee.std_logic_1164.all;

entity test_equal is
end test_equal;

architecture arch_test of test_equal is 
component equal 
port (I0, I1 : in std_logic;
	Eq   : out std_logic);
end component;

signal p1, p0, pout : std_logic;
signal error        : std_logic := '0';
begin
uut: equal port map (I0 => p0, I1 => p1, Eq => pout);
process
begin
p0 <= '1';
p1 <= '0';
wait for 1 ns;
if (pout = '1') then 
	error <= '1';
end if;
wait for 200 ns;
p0 <= '1';
p1 <= '1';
wait for 1 ns;
if (pout = '0') then 
	error <= '1';
end if;
wait for 200 ns; 
p0 <= '0';
p1 <= '1';
wait for 1 ns; 
if (pout = '1') then 
	error <= '1';
end if;
wait for 200 ns;
p0 <= '0';
p1 <= '0';
wait for 1 ns;
if (pout = '0') then
	error <= '1';
end if;
wait for 200 ns;

if (error = '0') then 
	report "No errors detected. Simulation successful" severity
failure;
	else 
		report "Error detected" severity failure;
end if;

end process;
end arch_test;



