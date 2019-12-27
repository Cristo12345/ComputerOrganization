-- take in two n-bit integers (assumed to be signed) A and B
-- perform A STL B (1 if A < B, else 0)
-- Idea is to subtract B from A and if that value is less than 0 (MSB is 1), 
-- then A < B. We will use our full adder compnent to perform subtraction
-- We do this by inverting all of B's bits and then providing a Cin of 1 to the adder

-- working for unsigned

library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity set_less_than is 
  generic(n : natural:= 4);
  port (A, B : in std_logic_vector(n-1 downto 0);
        slt: out std_logic);
  end entity set_less_than;
  
  architecture arch of set_less_than is
    component fullAdder
       port (A, B, Cin : in std_logic;
       S, Cout : out std_logic);
    end component;
    
    -- vector to store result of our subtraction
    signal res : std_logic_vector(n-1 downto 0);
    
    -- vector to store our carrys for adders, first carryin will be 1 for subtraction
    signal carrys: std_logic_vector(n downto 0);
    
    -- invert of B, we add this to A to perform subtraction
    signal notB: std_logic_vector(n-1 downto 0);
    
    begin
      -- setting carryin of first adder to 1
      carrys(0) <= '1';
      
      -- setting notB to invert of B
      notB <= not B;
      
      -- perform A - B with full adder
      adder: for i in 0 to n-1 generate
      adder_i: fullAdder port map (A => A(i), B => notB(i), Cin => carrys(i), S => res(i), Cout => carrys(i+1));
    end generate;
    
-- cant just check MSB of result, very good chance there was overflow during arithmetic and MSB
-- is 0 for a negative result
-- cant just check if there was a Cout (carrys(n)) because carryOut doesnt imply anything about result
    slt <= res(n-1) and (not carrys(n));
  end;
  
