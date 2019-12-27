-- here we will take in a 2 bit vector and extend it to 4 bits
-- we must also take in a SIGNED signal to know if we are doing 
-- signed or unsigned extension

-- we will have a signed/unsigned input signal to decide what kind of sign extension we will do
-- UNSIGEND: simply fill remaining bits with 0's 
-- SIGNED: extend MSB

library ieee;
use ieee.std_logic_1164.all;

entity extension_four_bit is
	port ( b : in std_logic_vector(1 downto 0);
	       
	       -- input signal telling us if its sign or unsigned, 0 for unsigned
	       sign: in std_logic;
	       
	       --result of our sign extension to output
	       res: out std_logic_vector(3 downto 0));

end extension_four_bit;

architecture arch of extension_four_bit is 
	
	-- we will store our new vector (sign extended b) here
  signal extended_b : std_logic_vector(3 downto 0);

	begin

  -- assigning our input's four bits to the LSB's of our new vector
  extended_b(1) <= b(1);
  extended_b(0) <= b(0);
  
  -- if signed extend b by MSB, else by zeros

    extended_b(2) <= b(1) when sign = '1' else '0';
    extended_b(3) <= b(1) when sign = '1' else '0';
	
	res <= extended_b;
	

end arch;





