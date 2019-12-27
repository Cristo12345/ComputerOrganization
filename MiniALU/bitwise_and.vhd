-- take in two logic units and returns 1 if both are 1

library IEEE;
use ieee.std_logic_1164.all;

entity bitwise_and is
  port (A, B: in std_logic;
        C: out std_logic:='0');
 end bitwise_and;
 
 architecture arch of bitwise_and is
   begin
     C <= B when A = '1';
  end arch;
      