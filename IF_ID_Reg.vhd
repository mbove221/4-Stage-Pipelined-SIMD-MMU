-------------------------------------------------------------------------------
--
-- Title       : IF_ID_Reg
-- Design      : alu
-- Author      : Michael
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:/Users/Michael/Desktop/Stony Brook University/Fall 2024/ESE 345/Project/ESE_345_Project/alu/src/IF_ID_Reg.vhd
-- Generated   : Thu Nov 28 12:51:10 2024
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
--{entity {IF_ID_Reg} architecture {behavioral}}

library ieee;
use ieee.std_logic_1164.all;

entity IF_ID_Reg is
	port(
	instruction_in : in std_logic_vector(24 downto 0);
	clk : in std_logic;
	instruction_out : out std_logic_vector(24 downto 0)
	);
end IF_ID_Reg;

--}} End of automatically maintained section

architecture behavioral of IF_ID_Reg is
begin
	process(all)
	begin
		if(rising_edge(clk)) then
			instruction_out <= instruction_in;
		end if;
	end process;

	-- Enter your statements here --

end behavioral;
