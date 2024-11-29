-------------------------------------------------------------------------------
--
-- Title       : ID_EX_Reg
-- Design      : alu
-- Author      : Michael
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:/Users/Michael/Desktop/Stony Brook University/Fall 2024/ESE 345/Project/ESE_345_Project/alu/src/ID_EX_Reg.vhd
-- Generated   : Thu Nov 28 12:36:38 2024
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
--{entity {ID_EX_Reg} architecture {behavioral}}

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ID_EX_Reg is
	port(
	reg1_in, reg2_in, reg3_in, reg_dest_in : in std_logic_vector(127 downto 0);
	instruction_in : in std_logic_vector(24 downto 0);
	clk : in std_logic;
	reg1_out, reg2_out, reg3_out, reg_dest_out : out std_logic_vector(127 downto 0);
	instruction_out : out std_logic_vector(24 downto 0)
	);
end ID_EX_Reg;

--}} End of automatically maintained section

architecture behavioral of ID_EX_Reg is
begin
	clock: process(clk)
	begin
		if(rising_edge(clk)) then
			reg1_out <= reg1_in;
			reg2_out <= reg2_in;
			reg3_out <= reg3_in;
			instruction_out <= instruction_in;
		end if;
	end process;
	-- Enter your statements here --

end behavioral;
