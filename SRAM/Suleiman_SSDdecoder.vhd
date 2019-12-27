-------------------------------------------------
--===============================================
--ALTERA DE-2 BOARD SEVEN SEGMENT DISPLAY DECODER
--===============================================
--PLEASE DO NOT REMOVE THIS CREDITING COMMENT
--THE CODE BELOW IS THE ORIGINAL WORK OF
--AYUSHYA AMITABH
--October 2019
--===============================================
--MADE FOR USE ON THE ALTERA DE-2 BOARD
--===============================================
--To use this simply pass in two inputs:
--1. is_signed - indicates if bit_num is signed
--2. bit_num - logic vector of the number
--
--** Make sure to change the generic n here to
-- match the length of your logic vector.
--
--Recommended use along with 'ssd_pins.txt' to
--allow complete control of all the hex displays.
--===============================================
-------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
ENTITY Suleiman_SSDdecoder IS
	GENERIC (n : INTEGER := 8);
	PORT
	(
		is_signed  : IN STD_LOGIC;
		bit_num    : IN STD_LOGIC_VECTOR (n - 1 DOWNTO 0);
		ssd_out    : OUT STD_LOGIC_VECTOR (55 DOWNTO 0)
	);
END Suleiman_SSDdecoder;
ARCHITECTURE arch OF Suleiman_SSDdecoder IS
	SIGNAL ssd_temp : STD_LOGIC_VECTOR (55 DOWNTO 0);
BEGIN
	PROCESS (is_signed, bit_num)
	VARIABLE temp : INTEGER RANGE 0 TO 9 := 0;
	VARIABLE numb : INTEGER;
	VARIABLE sign_loc : INTEGER;
	VARIABLE sign : INTEGER;
	VARIABLE trigger: INTEGER;
	BEGIN
		ssd_temp <= "11111111111111111111111111111111111111111111111111111111";
		IF is_signed = '1' THEN
		  trigger := 1;
			numb := to_integer(signed(bit_num));
			IF numb < 0 THEN
				--ssd_temp(55 DOWNTO 49) <= "0111111"; -- first display is a negative sign
				numb := ABS numb;
				sign := 1;
			ELSE
				--ssd_temp(55 DOWNTO 49) <= "0111001"; -- first display is a positive sign
				sign := 0;
			END IF;
		ELSE
		  trigger :=0;
			--ssd_temp(55 DOWNTO 49) <= "1111111"; -- empty the sign display
			numb := to_integer(unsigned(bit_num));
		END IF;
		FOR i IN 0 TO 6
			LOOP
			EXIT WHEN numb = 0 AND i > 0;
			sign_loc := i;
			temp := numb MOD 10;
			numb := numb / 10;
			CASE temp IS
				WHEN 0 => ssd_temp((7 * i) + 6 DOWNTO (7 * i)) <= "1000000"; -- "0"
				WHEN 1 => ssd_temp((7 * i) + 6 DOWNTO (7 * i)) <= "1111001"; -- "1"
				WHEN 2 => ssd_temp((7 * i) + 6 DOWNTO (7 * i)) <= "0100100"; -- "2"
				WHEN 3 => ssd_temp((7 * i) + 6 DOWNTO (7 * i)) <= "0110000"; -- "3"
				WHEN 4 => ssd_temp((7 * i) + 6 DOWNTO (7 * i)) <= "0011001"; -- "4"
				WHEN 5 => ssd_temp((7 * i) + 6 DOWNTO (7 * i)) <= "0010010"; -- "5"
				WHEN 6 => ssd_temp((7 * i) + 6 DOWNTO (7 * i)) <= "0000010"; -- "6"
				WHEN 7 => ssd_temp((7 * i) + 6 DOWNTO (7 * i)) <= "1111000"; -- "7"
				WHEN 8 => ssd_temp((7 * i) + 6 DOWNTO (7 * i)) <= "0000000"; -- "8"
				WHEN 9 => ssd_temp((7 * i) + 6 DOWNTO (7 * i)) <= "0010000"; -- "9"
			END CASE;
		END LOOP;
		if (trigger = 1) then
		if (sign=0) then
		ssd_temp((7 * sign_loc) + 13 DOWNTO (7 * sign_loc)+7) <= "0111001";
		else
		ssd_temp((7 * sign_loc) + 13 DOWNTO (7 * sign_loc)+7) <= "0111111";
		end if;
		end if;
		  
	END PROCESS;
	ssd_out <= ssd_temp;
END arch;