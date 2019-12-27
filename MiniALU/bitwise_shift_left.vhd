-- takes in a 4-bit integer and shifts it to the left by one bit
-- we can do shift left by using our adder as shifting left is the equivalent of 
-- doubling the number

library IEEE;
use ieee.std_logic_1164.all;

entity bitwise_shift_left is
  port (A : in std_logic_vector(3 downto 0);
    -- shift = how many positions we will shift left by
        shift: in positive:=1;
        res : out std_logic_vector(3 downto 0));
  end entity bitwise_shift_left;
  
  architecture arch of bitwise_shift_left is
    
    component unsigned_nbit_adder
       port(op1, op2 : in std_logic_vector(3 downto 0);
        Cin : in std_logic;
		  signed: in std_logic;
		  extended_op2: in std_logic;
        sum       : out std_logic_vector(3 downto 0); 
        carry_out : out std_logic);
    end component;
    
    -- making a vector to hold our result
    signal res_buff : std_logic_vector(3 downto 0);
	 
	 signal A_buff: std_logic_vector(3 downto 0);
    
    
    begin 

     A_buff <= A;
     
      adder: for i in 0 to 0 generate
        adder_i: unsigned_nbit_adder port map(op1=>A, op2=>A_buff, Cin=>'0', signed=>'0', extended_op2=>'0',sum=>res_buff);
      end generate;
    
    res <= res_buff;
    
    
  end arch;