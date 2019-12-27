-- takes a 4-bit binary vector and shifts it to the right by n bits

library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bitwise_shift_right is
  port (A : in unsigned(3 downto 0);
    --how many positions we will shift right by
       shift: in positive:=1; 
       --shift: in positive:=1;
        res : out unsigned(3 downto 0));
  end entity bitwise_shift_right;
  
  architecture arch of bitwise_shift_right is
    begin
      res <= shift_right(unsigned(A), shift);
  end arch;