-------------------------------------------------------------------------------
--
-- Title       : instruction_buffer
-- Design      : alu
-- Author      : Michael
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:/Users/Michael/Desktop/Stony Brook University/Fall 2024/ESE 345/Project/ESE_345_Project/alu/src/instruction_buffer.vhd
-- Generated   : Thu Nov 28 11:14:30 2024
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
--{entity {instruction_buffer} architecture {behavioral}}
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library std;
use std.textio.all;


entity instruction_buffer is
	port(
	PC : in std_logic_vector(5 downto 0);
	load_buffer : in std_logic;
	output : out std_logic_vector(24 downto 0)
	);
end instruction_buffer;

--}} End of automatically maintained section

architecture behavioral of instruction_buffer is	
type instruction_file_type is array(0 to 63) of std_logic_vector(24 downto 0);
file fin : text;	 
signal instruction_file : instruction_file_type := (others => (others => '0'));
begin	
	read_file : process(load_buffer)
	variable file_vectors : line;
	variable is_done : boolean := false;
	variable i : integer := 0;
	variable fin_line : line; 
	variable instruction_file_var : std_logic_vector(24 downto 0);
	begin
		if(load_buffer) then
			file_open(fin, "file_vectors.txt", read_mode);
			while not endfile(fin) loop
				readline(fin, fin_line);
				read(fin_line, instruction_file_var); --store fin_line and store it in instruction_file(i)
				instruction_file(i) <= instruction_file_var;
				i := i + 1;
			end loop; 
			file_close(fin);
		end if;
	end process;
	
	fetch_instr : process(PC)
	begin
		output <= instruction_file(to_integer(unsigned(PC)));
	end process;
	
	
	-- Enter your statements here --

end behavioral;
