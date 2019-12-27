-- here we will make a full adder using two half adders
-- Input: logic units A, B, and Cin (Cin will represent carry in)
-- Output: Sum and Cout, same as half adder

library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity fullAdder is
  PORT (A, B, Cin : in std_logic;
        S, Cout : out std_logic);
end fullAdder;

architecture arch of fullAdder is
  component halfAdder
    port (A, B : in std_logic;
          S, C : out std_logic);
  end component;
        
signal H0_CARRY, H0_SUM, H1_CARRY: std_logic;

begin
  -- instantiates two half bit adders
  H0: halfAdder port map (A => A,      B => B,   S => H0_SUM, C => H0_CARRY);
  H1: halfAdder port map (A => H0_SUM, B => Cin, S => S,    C => H1_CARRY);

  Cout <= H0_CARRY or H1_CARRY;
end arch;