-- made for 4-bit inputs on board

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity unsigned_nbit_adder is 
  
  -- setting variable n with a default value of 4
  generic(n : natural:= 4);
  port(op1, op2 : in std_logic_vector(n-1 downto 0);
        Cin : in std_logic; 
        
        -- input telling us if its signed or not - doesnt change operation just 
        -- representation of sum and flags
        signed: in std_logic;
        
        -- input option for sign extension. If this is 1, then our op2 will be 
        -- given by only 2 switches as the LSB and we must sign extend it
        extended_op2 : in std_logic;
        
        sum       : out std_logic_vector(n-1 downto 0); 
        carry_out : out std_logic;
        segDisplay : out std_logic_vector(55 downto 0);
        
        -- also adding some flags
        neg_flag : out std_logic;
        zero_flag : out std_logic;
        overflow_flag : out std_logic);
  end entity unsigned_nbit_adder;
  
  architecture arch of unsigned_nbit_adder is 
    
    component fullAdder
       port (A, B, Cin : in std_logic;
       S, Cout : out std_logic);
    end component;
    
    component ssd is
        port (
		is_signed  : IN STD_LOGIC;
		bit_num    : IN STD_LOGIC_VECTOR (n - 1 DOWNTO 0);
		ssd_out    : OUT STD_LOGIC_VECTOR (55 DOWNTO 0)
	);
    end component;
    
    component extension_four_bit is
	     port ( b : in std_logic_vector(1 downto 0);
	       sign: in std_logic;
	       res: out std_logic_vector(3 downto 0));
    end component;
    
    -- instead of making a c1, c2, c3 to keep track of each adder's carry,
    -- we'll make a vecotr of length n to keep it generic
    signal carrys: std_logic_vector(n downto 0);
    
    -- temp vector of 0's length n to check sum against for zero flag
    signal zeroCheck: std_logic_vector(n-1 downto 0) := (others => '0');
    
    -- had problems directly comparing sum to our vector of zero's, using a buffer
    -- signal seems to work
    signal sum_buff: std_logic_vector(n-1 downto 0);
    
    -- we will store our 2nd operand in a buffer variable as its value will change
    -- depending on if its being extended or not
    signal op2_buff_1: std_logic_vector(1 downto 0);
    signal op2_buff_2: std_logic_vector(n-1 downto 0);
    signal op2_buff_3: std_logic_vector(n-1 downto 0);
    
    begin
      
    carrys(0) <= Cin; -- first carry will come from our Cin input
    
    -- using our extension component in an if loop causes errors, so going to do everything 
    -- in very basic, inefficient way
    -- going to check if switch for extension is on. If it is, we are going to take the 4 LSBs of op2 
    -- and put them into a buffer vector. Then send that vector to our extension component. Then set our final
    -- op2 buffer as the returned vector and pass that into the adder. 
    -- If the switch is off then we just set the final buffer variable to op2 
    process(op2, op2_buff_1)
      begin
        for i in 0 to 1 loop
          op2_buff_1(i) <= op2(i);
      end loop;
    end process;
    
    extension: extension_four_bit port map (b => op2_buff_1, sign => signed, res=> op2_buff_2);
    
    -- assigning our final buffer variable to send to our adder based on the 'extended_op2' input
    process(op2, extended_op2, op2_buff_2, op2_buff_3)
      begin
        if extended_op2='1' then
          op2_buff_3 <= op2_buff_2;
        else
          op2_buff_3 <= op2;
        end if;
      end process;
          
    
                               
    
    adder: for i in 0 to n-1 generate
      adder_i: fullAdder port map (A => op1(i), B => op2_buff_3(i), Cin => carrys(i), S => sum_buff(i), Cout => carrys(i+1));
    end generate;
    
    
    -- calling our 7seg_display component to get a vector to send to the board's display
    -- then store all the display signals to our output for the 7 segment display
    display_decoder: ssd port map(bit_num => sum_buff, 
    is_signed=>signed,ssd_out=>segDisplay);
 
 
 
  -- check overflow and neg flags 
  process(signed, carrys, sum_buff)
  begin     
    if signed='0' then
      overflow_flag <= carrys(n);
      neg_flag <= '0';
    else  
      neg_flag <= sum_buff(n-1);
     overflow_flag <= carrys(n-1) xor carrys(n);
    end if;   
  end process;    
    
    --checking condition for zero flag
    zero_flag <= '1' when sum_buff = zeroCheck else '0';
    
    -- finally putting out all our outputs
    sum <= sum_buff;
    carry_out <= carrys(n);
    
  end arch;
