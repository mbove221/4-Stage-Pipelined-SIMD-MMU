-------------------------------------------------------------------------------
--
-- Title       : program_counter
-- Design      : alu
-- Author      : Michael
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:/Users/Michael/Desktop/Stony Brook University/Fall 2024/ESE 345/Project/ESE_345_Project/alu/src/program_counter.vhd
-- Generated   : Thu Nov 28 21:04:44 2024
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
--{entity {program_counter} architecture {program_counter}}

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity program_counter is 
	port(			  
	reset_n : std_logic;
	clk : in std_logic;
	PC : out std_logic_vector(5 downto 0)
	);
end program_counter;

--}} End of automatically maintained section

architecture behavior of program_counter is
begin
	process(clk, reset_n)
	begin
		if(reset_n = '0') then
			PC <= (others => '0');
		elsif(rising_edge(clk)) then	 
			PC <= std_logic_vector(to_unsigned(to_integer(unsigned(PC)) + 1, 6));
		end if;
	end process;

end behavior;
