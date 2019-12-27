-- returns 1 if either A or B (or both) are 1

library IEEE;
use ieee.std_logic_1164.all;

entity bitwise_or is
  port (A, B: in std_logic;
        C: out std_logic:='1');
  end entity bitwise_or;
      
  architecture arch of bitwise_or is
    begin
      C <= B when A='0' else '1';
  end arch;