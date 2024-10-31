-------------------------------------------------------------------------------
--
-- Title       : alu_TB
-- Design      : alu
-- Author      : Michael
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:/Users/Michael/Desktop/Stony Brook University/Fall 2024/ESE 345/Project/ESE_345_Project/alu/src/alu_tb.vhd
-- Generated   : Sat Oct 26 17:17:39 2024
-- From        : Interface description file
-- By          : ItfToHdl ver. 1.0
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--    and may be overwritten
--{entity {alu_tb} architecture {alu_tb}}

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.all;

entity alu_TB is
end alu_TB;

--}} End of automatically maintained section

architecture tb_architecture of alu_TB is
signal inp1, inp2, inp3, outp : std_logic_vector(127 downto 0);
signal instruction : std_logic_vector(24 downto 0);	
constant period : time := 20 ns;
begin 
	UUT : entity alu 
		port map(instruction => instruction, inp1 => inp1, inp2 => inp2, inp3 => inp3, outp => outp);
		STIMULUS : process
		variable upper_lim : integer;
		variable lower_lim : integer;
		variable ones : integer;
		begin 
			
		--START OF TB CODE FOR LI (0 - Leading bits)
--			--inp1(127 downto 0) <= (others => '0');
--			instruction <= '0' & "111" & x"DEAD" & "01110";
--			wait for period;
--			instruction <= '0' & "000" & x"BEEF" & "01110";
--			wait for period;
--			inp1(127 downto 124) <= (others => '1');
--			instruction <= '0' & "010" & x"FADE" & "01110";
--			wait for period;
		--END OF TB CODE FOR LI - VERIFIED
		
--START OF TEST CODE FOR SIGNED MA AND MS (10 - Leading bits)
		--START OF TB CODE FOR SI MA LOW WS	(000)
--			inp3 <= x"----" & x"0001" & x"----" & x"0001" & x"----" & x"0002" & x"----"	& x"0020";
--			inp2 <= x"----" & x"0001" & x"----" & x"8000" & x"----" & x"0002" & x"----" & x"0001";
--			inp1 <= x"7FFF" & x"FFFF" & x"8000" & x"0000" & x"8000" & x"0040" & x"0000" & x"0001";
--			instruction <= "10" & "000" & x"----" & "----";
--			wait for period; 
		--END OF TB CODE FOR SI MAL WS - VERIFIED
			
		--START OF TB CODE FOR SI MA HIGH WS (001)
--		    inp3 <= x"0001" & x"----" & x"0001" & x"----" & x"0002" & x"----" & x"0020" & x"----";
--			inp2 <= x"0001" & x"----" & x"8000" & x"----" & x"0002" & x"----" & x"0001" & x"----";
--			inp1 <= x"7FFF" & x"FFFF" & x"8000" & x"0000" & x"8000" & x"0040" & x"0000" & x"0001";
--			instruction <= "10" & "001" & x"----" & "----";
--			wait for period; 
		--END OF TB CODE FOR SI MA HIGH WS - VERIFIED 
			
		--START OF TB CODE FOR SI MS LOW WS	(010)
--		  instruction <= "10" & "010" & x"----" & "----";
--		  inp3 <= x"----" & x"0001" & x"----" & x"0001" & x"----" & x"0002" & x"----"	& x"0020";
--		  inp2 <= x"----" & x"FFFF" & x"----" & x"0001" & x"----" & x"0002" & x"----" & x"0001";
--		  inp1 <= x"7FFF" & x"FFFF" & x"8000" & x"0000" & x"8000" & x"0040" & x"0000" & x"0001";
--		  wait for period;
		--END OF TB CODE FOR SI MS LOW WS - RETEST 
			
		--START OF TB CODE FOR SI MS HIGH WS (011)
		 -- instruction <= "10" & "011" & x"----" & "----";
--		  inp3 <= x"0001" & x"----" & x"0001" & x"----" & x"0002" & x"----"	& x"0020" & x"----";
--		  inp2 <= x"FFFF" & x"----" & x"0001" & x"----" & x"0002" & x"----" & x"0001" & x"----";
--		  inp1 <= x"7FFF" & x"FFFF" & x"8000" & x"0000" & x"8000" & x"0040" & x"0000" & x"0001";
--		  wait for period;
		--END OF TB CODE FOR SI MS HIGH WS - RETEST

		--START OF TB CODE FOR SLI MA LOW WS (100)
--		    inp3 <= x"----" & x"----" & x"FFFF" & x"0000" & x"----" & x"----" & x"F000"	& x"0000";
--			inp2 <= x"----" & x"----" & x"8000" & x"0000" & x"----" & x"----" & x"0000" & x"0001";
--			inp1 <= x"7FFF" & x"FFFF" & x"FFFF" & x"0000" & x"8000" & x"0000" & x"0000" & x"0001";
--			instruction <= "10" & "100" & x"----" & "----";
--			wait for period;
--			instruction <= "10" & "100" & x"----" & "----";
--			inp3 <= x"----" & x"----" & x"0020" & x"0000" & x"----" & x"----" & x"0220"	& x"0000";
--			inp2 <= x"----" & x"----" & x"0000" & x"0002" & x"----" & x"----" & x"0000" & x"0001";
--			inp1 <= x"7000" & x"0000" & x"0000" & x"0000" & x"8000" & x"0000" & x"0000" & x"FFFF";
--			wait for period;
		--END OF TB CODE FOR SLI MA LOW WS - RETEST  
		
		--START OF TB CODE FOR SLI MA HIGH WS (101)
--			inp3 <= x"FFFF" & x"0000" & x"----" & x"----" & x"F000"	& x"0000" & x"----" & x"----";
--			inp2 <= x"8000" & x"0000" & x"----" & x"----" & x"0000" & x"0001" & x"----" & x"----";
--			inp1 <= x"7FFF" & x"FFFF" & x"FFFF" & x"0000" & x"8000" & x"0000" & x"0000" & x"0001";
--			instruction <= "10" & "101" & x"----" & "----";
--			wait for period;
--			instruction <= "10" & "101" & x"----" & "----";
--			inp3 <= x"0020" & x"0000" & x"----" & x"----" & x"0220"	& x"0000" & x"----" & x"----";
--			inp2 <= x"0000" & x"0002" & x"----" & x"----" & x"0000" & x"0001" & x"----" & x"----";
--			inp1 <= x"7000" & x"0000" & x"0000" & x"0000" & x"8000" & x"0000" & x"0000" & x"FFFF";
--			wait for period;
		--END OF TB CODE FOR SLI MA HIGH WS - RETEST
			
		--START OF TB CODE FOR SLI MS LOW WS (110)
--			instruction <= "10" & "110" & x"----" & "----";
--			inp3 <= x"----" & x"----" & x"0030" & x"0001" & x"----" & x"----" &  x"0FFF" & x"0020";
--			inp2 <= x"----" & x"----" & x"8020" & x"0001" & x"----" & x"----" & x"3210" & x"0001";
--			inp1 <= x"7FFF" & x"FFFF" & x"FFFF" & x"F123" & x"8000" & x"0040" & x"0000" & x"0001";
--			wait for period;
--			instruction <= "10" & "110" & x"----" & "----";
--			inp3 <= x"----" & x"----" & x"0020" & x"0000" & x"----" & x"----" & x"0000"	& x"4321";
--			inp2 <= x"----" & x"----" & x"0000" & x"0002" & x"----" & x"----" & x"0000" & x"0002";
--			inp1 <= x"7000" & x"0000" & x"0060" & x"0CE0" & x"C000" & x"0000" & x"0000" & x"FFFF";
--			wait for period;
		--END OF TB CODE FOR SLI MS LOW WS - RETEST
			
		--START OF TB CODE FOR SLI MS HIGH WS (111)
--			instruction <= "10" & "111" & x"----" & "----";
--			inp3 <= x"0030" & x"0001" & x"----" & x"----" &  x"0FFF" & x"0020" & x"----" & x"----";
--			inp2 <= x"8020" & x"0001" & x"----" & x"----" & x"3210" & x"0001" & x"----" & x"----";
--			inp1 <= x"7FFF" & x"FFFF" & x"FFFF" & x"F123" & x"8000" & x"0040" & x"0000" & x"0001";			
--			wait for period;
			instruction <= "10" & "111" & x"----" & "----";
			inp3 <= x"0020" & x"0000" & x"----" & x"----" & x"0000"	& x"4321" & x"----" & x"----";
			inp2 <= x"0000" & x"0002" & x"----" & x"----" & x"0000" & x"0002" & x"----" & x"----";
			inp1 <= x"7000" & x"0000" & x"0060" & x"0CE0" & x"C000" & x"0000" & x"0000" & x"FFFF";
			wait for period;
		--END OF TB CODE FOR SLI MS HIGH WS - RETEST
--END OF TEST CODE FOR SIGNED MA AND MS - ALL TESTS PASSED (RETEST)
	
--START OF TEST CODE FOR R3 INSTRUCTIONS 
		--START OF TB CODE FOR NOP (0000)
--			instruction <="11" & "----0000" & "-----" & "-----" & "-----";
--			wait for period;
		--END OF TB CODE FOR NOP -  
		
		--START OF TB CODE FOR SLHI	(0001)
--			inp1 <= (others => '1');
--			instruction <="11" & "----0001" & "-----" & "-----" & "-----"; 
--			for i in 0 to 7 loop
--				upper_lim := i*16 + 15;
--				lower_lim := i*16;
--				if(i /= 0) then
--					inp2(upper_lim downto lower_lim) <= std_logic_vector(to_unsigned((7-i)*2, 16));
--				else
--					inp2(upper_lim downto lower_lim) <= std_logic_vector(to_unsigned(15, 16));
--				end if;
--			end loop;
--			wait for period;
		--END OF TB CODE FOR SLHI - VERIFIED
			
		--START OF TB CODE FOR AU (0010)
--			instruction <="11" & "----0010" & "-----" & "-----" & "-----"; 
--			inp1 <= x"FFFFFFFF" & x"11110000" & x"FFFFFFFF"  & x"12345678"; 
--			inp2 <= x"FFFFFFFF"	& x"34567890" & x"00000001" 	& x"87654321";
--			wait for period;
		--END OF TB CODE FOR AU - VERIFIED
		
		--START OF TB CODE FOR CNT1H (0011)
--			instruction <="11" & "----0011" & "-----" & "-----" & "-----"; 
--			for i in 0 to 7 loop
--				upper_lim := i*16 + 15;
--				lower_lim := i*16;
--				ones := 0;
--				for j in i-1 downto 0 loop
--				 	ones := ones + 2**j;
--				end loop;
--				if (i /= 7) then
--					inp1(upper_lim downto lower_lim) <= std_logic_vector(to_unsigned(ones, 16));
--				else
--					inp1(upper_lim downto lower_lim) <= (others => '1');
--				end if;
--			end loop;
--			wait for period;
		--END OF TB CODE FOR CNT1H - VERIFIED
			
		--START OF TB CODE FOR AHS (0100)
			--instruction <="11" & "01110100" & "00000" & "00000" & "00000";
--			inp1 <= x"8010" & x"7FFF" & x"0011" & x"8010" & x"1000" & x"7FFF" & x"0011" & x"1010";
--			inp2 <= x"8010" & x"0001" & x"8100" & x"8010" & x"1111" & x"0000" & x"0F11" & x"0010";
--			wait for period;  
		--END OF TB CODE FOR AHS - NEEDS VERIFICATION
		   
		--START OF TB CODE FOR BITWISE AND (0101)
--			instruction <="11" & "01110101" & "00000" & "00000" & "00000";
--			inp1(127 downto 64) <= (others => '1');
--			inp1(63 downto 0) <= x"1010" & x"0101" & x"FF23" & x"0101"; 
--			inp2 <= x"F111" & x"0001" & x"8100" & x"8010" & x"FFFF" & x"FFFF" & x"0FFF" & x"0010";
--			wait for period;
		--END OF TB CODE FOR BITWISE AND - VERIFIED
		
		--START OF TB CODE FOR BROADCAST WORD (0110)
--			instruction <="11" & "----0110" & "-----" & "-----" & "-----";
--			inp1(127 downto 64) <= (others => '1');
--			inp1(63 downto 0) <= x"1010" & x"0101" & x"FF23" & x"0101"; 
--			wait for period;
		--END OF TB CODE FOR BROADCAST WORD - VERIFIED
		   
		--START OF TB CODE FOR MAX SIGNED WORD (0111)
--			instruction <="11" & "----0111" & "-----" & "-----" & "-----";
--			inp1 <= x"FFFFFFFF" & x"7FFFFFFF" & x"20000101" & x"80101010";
--			inp2 <= x"00000000" & x"80000000" & x"21010100" & x"81000000";
--			wait for period;
		--END OF TB CODE FOR MAX SIGNED WORD - VERIFIED
			
		--START OF TB CODE FOR MIN SIGNED WORD (1000)
--			instruction <="11" & "----1000" & "-----" & "-----" & "-----";
--			inp1 <= x"FFFFFFFF" & x"7FFFFFFF" & x"20000101" & x"80101010";
--			inp2 <= x"00000000" & x"80000000" & x"21010100" & x"81000000";
--			wait for period;
		--END OF TB CODE FOR MIN SIGNED WORD - VERIFIED
			
		--START OF TB CODE FOR MULTIPLY LOW UNSIGNED (1001)
--			instruction <="11" & "----1001" & "-----" & "-----" & "-----";
--			inp1 <= x"----FFFF" & x"----FFFF" & x"----1010" & x"----1111";
--			inp2 <= x"----FFFF" & x"----FFFF" & x"----1111" & x"----0001";
--			wait for period;
		--END OF TB CODE FOR MULTIPLY LOW UNSIGNED - VERIFIED
		
		--START OF TB CODE FOR MULTIPLY LOW BY CONSTANT UNSIGNED (1010)
--			instruction <="11" & "----1010" & "-----" & "-----" & "-----";
--			instruction(14 downto 10) <= "00010";
--			inp1 <= x"----0002" & x"----0010" & x"----0020" & x"----F000";
--			wait for period;
		--END OF TB CODE FOR MULTIPLY LOW BY CONSTANT UNSIGNED - VERIFIED
		
		--START OF TB CODE FOR BITWISE LOGICAL OR (1011)
			--instruction <="11" & "----1011" & "-----" & "-----" & "-----";
--		    inp1(127 downto 64) <= (others => '1');
--			inp1(63 downto 0) <= x"1010" & x"0101" & x"FF23" & x"0101"; 
--			inp2 <= x"F111" & x"0001" & x"8100" & x"8010" & x"0101" & x"0101" & x"0344" & x"0010";
--			wait for period;
		--END OF TB CODE FOR BITWISE LOGICAL OR - VERIFIED
		
		--START OF TB CODE FOR COUNT LEADING ZEROS IN HALFWORDS (1100)
--			instruction <= "11" & "----1100" & "-----" & "-----" & "-----";
--			inp1 <=  x"FFFF" & x"0000" & x"0100" & x"0620" & x"0101" & x"1111" & x"1011" & x"3210";
--			wait for period;
		--END OF TB CODE FOR COUNT LEADING ZEROS IN HALFWORDS - VERIFIED
			
		--START OF TB CODE FOR ROTATE LEFT BITS IN HALFWORDS (1101)
--			instruction <= "11" & "----1101" & "-----" & "-----" & "-----";
--			inp1 <= x"0100" & x"0100" & x"1001" & x"8001" & x"0101" & x"1010" & x"F002" & x"000F";
--			inp2 <= x"---0" & x"---F" & x"---4" & x"---1" & x"---3" & x"---5" & x"---1" & x"---F";
--			wait for period;
		--END OF TB CODE FOR ROTATE LEFT BITS IN HALFWORDS - VERIFIED
			
		--START OF TB CODE FOR SUBTRACT FROM WORD UNSIGNED (1110)
--			instruction <="11" & "----1110" & "-----" & "-----" & "-----"; 
--			inp1 <= x"FFFFFFFF" & x"11110000" & x"FFFFFFFF"  & x"12345678"; 
--			inp2 <= x"FFFFFFFE"	& x"34567890" & x"00000001" 	& x"87654321";
--			wait for period;
		--END OF TB CODE FOR SUBTRACT FROM WORD UNSIGNED - NEEDS VERIFICATION - CHECK IF SATURATION OR NORMAL UNSIGNED
		
		--START OF TB CODE FOR SUBTRACT FROM HALFWORD SATURATED (1111)
			--instruction <= "11" & "----1111" & "-----" & "-----" & "-----";
--			inp1 <= x"0001" & x"FFFF" & x"0010" & x"FFFF" & x"FFFF" & x"1111" & x"8001" & x"FFFF";
--			inp2 <= x"8000" & x"7FFF" & x"FFFE" & x"8001" & x"8010" & x"3210" & x"4321" & x"4321";
--			wait for period;
		--END OF TB CODE FOR SUBTRACT FROM HALFWORD SATURATED - VERIFIED
		std.env.finish;	
		end process;
		

end tb_architecture;
