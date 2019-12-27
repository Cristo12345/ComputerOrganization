library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity nbit_comparator is
  generic(n : natural:= 4);
	port ( a, b	: in std_logic_vector(n-1 downto 0);
		aeqb	: out std_logic);
end nbit_comparator;

architecture arch of nbit_comparator is
  
  component equal is
		port (I0, I1 : in std_logic;
		Eq: out std_logic);
	end component;
	
	signal allTrue : std_logic_vector(n-1 downto 0);
	
	signal eqVector : std_logic_vector(n-1 downto 0);
	
	signal aeqb_buff : std_logic;
	
	
  begin
    -- to avoid problems with reading outputs in VHDL, I will create a vector of n length 
    -- (allTrue) of all 1's to check against another vector holding our bit comparison 
    -- values (eqVector), bit by bit
    process(allTrue)
      begin
        for i in 0 to n-1 loop
         allTrue(i) <= '1';
        end loop;
    end process;
    
    -- generating a one bit comparator for each bit in A and B
    comparator: for i in 0 to n-1 generate
      comparator_i: equal port map(I0 => a(i), I1 => b(i), Eq => eqVector(i));
    end generate;
    
    -- setting our output to allTrue = eqVector
    process(eqVector, aeqb_buff, allTrue)
      begin
        if eqVector = allTrue then
          aeqb_buff <= '1';
        else 
          aeqb_buff <= '0';
        end if;
      end process;
      
      aeqb <= aeqb_buff;
    end arch;