library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity test_half_adder is
end test_half_adder;

architecture arch_test of test_half_adder is
  component halfAdder
    port(A, B : in std_logic;
        S, C : out std_logic);
  end component;
  
  signal x, y: std_logic:='0';
  signal Sum, Cout : std_logic;
  
  signal error: std_logic:='0';
  
begin
  uut: halfAdder port map(A=>x, B=>y, C=>Cout, S=>Sum);
    process
      begin
        x<='0';
        y<='0';
        wait for 1ns;
        if (not (Cout = '0' and Sum = '0')) then
          error<='1';
        end if;
        wait for 200ns;
        
        x<='1';
        y<='0';
        wait for 1ns;
        if (not (Cout = '0' and Sum = '1')) then
          error<='1';
        end if;
        wait for 200ns;
        
        x<='0';
        y<='1';
        wait for 1ns;
        if (not (Cout = '0' and Sum = '1')) then
          error<='1';
        end if;
        wait for 200ns;
        
        x<='1';
        y<='1';
        wait for 1ns;
        if (not (Cout = '1' and Sum = '0')) then
          error<='1';
        end if;
        wait for 200ns;
        
        
        if (error = '0') then
	       report "No errors detected. Simulation successful" severity failure;
        else 
	       report "Error detected" severity failure;
        end if;
    end process;
end arch_test;
        
        
  