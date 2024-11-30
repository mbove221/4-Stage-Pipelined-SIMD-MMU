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
	alu_out_wb_in : in std_logic_vector(127 downto 0);
	instruction_in : in std_logic_vector (24 downto 0);
	clk : in std_logic;
	reg_dest : out std_logic_vector(4 downto 0);
	data_output : out std_logic_vector(127 downto 0);
	write_en : out std_logic;
	instruction_out : out std_logic_vector(24 downto 0)
	);
end EX_WB_Reg;

--}} End of automatically maintained section

architecture behavior of EX_WB_Reg is
begin
	write_back : process(clk)
	begin
		write_en <= '0';
		if(rising_edge(clk)) then
			instruction_out <= instruction_in;
			reg_dest <= instruction_in(4 downto 0);
			data_output <= alu_out_wb_in;
		end if;
		if((instruction_in(24) = '0' or instruction_in(24 downto 23) = "10") or ((instruction_in(24 downto 23) = "11") and instruction_in(18 downto 15) /= "0000")) then
			write_en <= '1';
		end if;
	end process;
end behavior;
