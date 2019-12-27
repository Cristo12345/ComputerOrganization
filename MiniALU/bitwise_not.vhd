-- inverts all bits of a logic vector - currently just for vector length 4
-- should be made to work with any length with a generic n

library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity bitwise_not is 
  port (A : in std_logic_vector(3 downto 0);
        res: out std_logic_vector(3 downto 0));
      end entity bitwise_not;
      
  architecture arch of bitwise_not is
    signal res_buff : std_logic_vector(3 downto 0);
    begin
    process(A)
      begin
        for i in 0 to 3 loop
          if A(i) = '1' then
            res_buff(i) <= '0';
          else
            res_buff(i) <= '1';
          end if;
        end loop;
      end process;
        
        res <= res_buff;
        
      end arch;