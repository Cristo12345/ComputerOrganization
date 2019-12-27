-- here we will make a 8 bit UNSIGNED adder using 8 of our 
-- full-bit-adder components
-- INPUT: two logic vectors of length 8
-- OUTPUT: a logic vector of length 8 and a carry-out

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity eightBitAdder is
   port(op1, op2 : in unsigned(7 downto 0);
        Cin : in std_logic; 
        sum       : out unsigned(7 downto 0); 
        carry_out : out std_logic);
        
end entity eightBitAdder;
 
architecture arch of eightBitAdder is
  
  -- bring in our full-adder component
  component fullAdder
    port (A, B, Cin : in std_logic;
          S, Cout : out std_logic);
    end component;
    
   
  -- temp signals to store carry-outs of each adder
  signal c1, c2, c3, c4, c5, c6, c7 : std_logic; 
   

begin 
  adder1: fullAdder port map(A => op1(0), B => op2(0) , Cin => Cin, S => sum(0), Cout => c1 );
  adder2: fullAdder port map(A => op1(1), B => op2(1) , Cin => c1, S => sum(1), Cout => c2 );
  adder3: fullAdder port map(A => op1(2), B => op2(2) , Cin => c2, S => sum(2), Cout => c3 );
  adder4: fullAdder port map(A => op1(3), B => op2(3) , Cin => c3, S => sum(3), Cout => c4 );
  adder5: fullAdder port map(A => op1(4), B => op2(4) , Cin => c4, S => sum(4), Cout => c5 );
  adder6: fullAdder port map(A => op1(5), B => op2(5) , Cin => c5, S => sum(5), Cout => c6 );
  adder7: fullAdder port map(A => op1(6), B => op2(6) , Cin => c6, S => sum(6), Cout => c7 );
  adder8: fullAdder port map(A => op1(7), B => op2(7) , Cin => c7, S => sum(7), Cout => carry_out );
end arch;


