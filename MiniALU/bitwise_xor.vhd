-- takes in two logic units  A and B, and performs xor on each bit
-- returns 1 if A xor B is true 

library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity bitwise_xor is
  port (A : in std_logic;
        B : in std_logic;
        is_xor : out std_logic);
end entity bitwise_xor;
  
architecture arch of bitwise_xor is
  
  begin
    
  is_xor <= A xor B;
    
  end arch;