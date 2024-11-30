-------------------------------------------------------------------------------
--
-- Title       : reg_file
-- Design      : alu
-- Author      : Michael
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:/Users/Michael/Desktop/Stony Brook University/Fall 2024/ESE 345/Project/ESE_345_Project/alu/src/register_file.vhd
-- Generated   : Thu Nov 28 10:27:30 2024
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
--{entity {reg_file} architecture {dataflow}}

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_file is
	port(
	instruction : in std_logic_vector(24 downto 0);
	write_en : in std_logic;
	write_reg : in std_logic_vector(4 downto 0);
	write_data : in std_logic_vector(127 downto 0);
	reg1, reg2, reg3, reg_dest : out std_logic_vector(127 downto 0)
	);
	
	
	
end reg_file;

--}} End of automatically maintained section

architecture dataflow of reg_file is
type registers is array(0 to 31) of std_logic_vector(127 downto 0);
signal register_file : registers := (others => (others => '0'));
begin
	write : process(write_en, write_reg, write_data) 
	begin
		if write_en = '1' then
			register_file(to_integer(unsigned(write_reg))) <= write_data;
		end if;
	end process;
	
	read : process(all)
	begin
		reg_dest <= register_file(to_integer(unsigned(instruction(4 downto 0))));
		reg1 <= register_file(to_integer(unsigned(instruction(9 downto 5))));
		reg2 <= register_file(to_integer(unsigned(instruction(14 downto 10))));
		reg3 <= register_file(to_integer(unsigned(instruction(19 downto 15))));
		
		if(instruction(24) = '0') then
			reg1 <= register_file(to_integer(unsigned(instruction(4 downto 0))));
		end if;
	end process;
	

	-- Enter your statements here --

end dataflow;
