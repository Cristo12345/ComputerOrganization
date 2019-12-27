-- here we will make a 4 bit UNSIGNED adder using 4 of our 
-- full-bit-adder components
-- INPUT: two logic vectors of length 4
-- OUTPUT: a logic vector of length 4 and a carry-out

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fourBitAdder is
   port(op1, op2 : in unsigned(3 downto 0);
        Cin : in std_logic; 
        sum       : out unsigned(3 downto 0); 
        carry_out : out std_logic);
        
end entity fourBitAdder;
 
architecture arch of fourBitAdder is
  
  -- bring in our full-adder component
  component fullAdder
    port (A, B, Cin : in std_logic;
          S, Cout : out std_logic);
    end component;
    
   
  -- temp signals to store carry-outs of each adder
  signal c1, c2, c3 : std_logic; 
   

begin 
  adder1: fullAdder port map(A => op1(0), B => op2(0) , Cin => Cin, S => sum(0), Cout => c1 );
  adder2: fullAdder port map(A => op1(1), B => op2(1) , Cin => c1, S => sum(1), Cout => c2 );
  adder3: fullAdder port map(A => op1(2), B => op2(2) , Cin => c2, S => sum(2), Cout => c3 );
  adder4: fullAdder port map(A => op1(3), B => op2(3) , Cin => c3, S => sum(3), Cout => carry_out );
end arch;
