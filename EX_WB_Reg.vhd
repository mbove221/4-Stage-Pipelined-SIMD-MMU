-------------------------------------------------------------------------------
--
-- Title       : EX_WB_Reg
-- Design      : alu
-- Author      : Michael
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:/Users/Michael/Desktop/Stony Brook University/Fall 2024/ESE 345/Project/ESE_345_Project/alu/src/EX_WB_Reg.vhd
-- Generated   : Thu Nov 28 21:22:15 2024
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
--{entity {EX_WB_Reg} architecture {behavior}}

library ieee;
use ieee.std_logic_1164.all;

entity EX_WB_Reg is
	port(
	alu_input : in std_logic_vector(127 downto 0);
	instruction_in : in std_logic_vector (24 downto 0);
	reg_dst : out std_logic_vector(4 downto 0);
	data_output : out std_logic_vector(127 downto 0);
	write_en : out std_logic;
	instruction_out : out std_logic_vector(24 downto 0)
	);
end EX_WB_Reg;

--}} End of automatically maintained section

architecture behavior of EX_WB_Reg is
begin

	-- Enter your statements here --

end behavior;
