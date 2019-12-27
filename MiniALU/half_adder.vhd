-- Here we will design a one bit half adder
-- Input: two logic signals representing the bits to be added (A & B)
-- Output: Sum and Cout
--         Sum = A xnor B (sum will only be 1 if only one of the bits is 1)
--         Cout = A and B (the carry out if both A and B are 1)

library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity halfAdder is
  Port (A, B : in std_logic;
        S, C : out std_logic);
end halfAdder;

architecture arch of halfAdder is 
  begin
  S <= A xor B;
  C <= A and B;
end arch;