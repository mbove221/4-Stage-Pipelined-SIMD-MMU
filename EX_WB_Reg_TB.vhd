-------------------------------------------------------------------------------
--
-- Title       : EX_WB_Reg_TB
-- Design      : alu
-- Author      : Michael
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:/Users/Michael/Desktop/Stony Brook University/Fall 2024/ESE 345/Project/ESE_345_Project/alu/src/EX_WB_Reg_TB.vhd
-- Generated   : Sat Nov 30 06:34:22 2024
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
--{entity {EX_WB_Reg_TB} architecture {testbench}}

library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity EX_WB_Reg_TB is
end EX_WB_Reg_TB;

--}} End of automatically maintained section

architecture testbench of EX_WB_Reg_TB is
signal alu_out_wb_in, data_output : std_logic_vector(127 downto 0);
signal instruction_in, instruction_out : std_logic_vector(24 downto 0);
signal reg_dest : std_logic_vector(4 downto 0);
signal clk, write_en : std_logic;
constant period : time := 20ns;
begin
	UUT : entity EX_WB_Reg port map(
		alu_out_wb_in => alu_out_wb_in, instruction_in => instruction_in, clk => clk,
		reg_dest => reg_dest, data_output => data_output, write_en => write_en, instruction_out => instruction_out
		);
		
	stimulus : process
	begin
		clk <= '0';
		alu_out_wb_in <= x"5915" & x"1987" & x"1741" & x"9811" & x"1234" & x"1234" & x"2861" & x"6181";
		instruction_in <= "0111111111111111111111110"; --write_en should generate
		wait for period/2;
		clk <= '1';
		wait for period/2;
		clk <= '0';
		instruction_in <= "1100000000000000000000000"; --write_en should not generate
		alu_out_wb_in <= x"8761" & x"6151" & x"7141" & x"1865" & x"1247" & x"5811" & x"4716" & x"4681";
		wait for period/2;
		clk <= '1';
		wait for period/2;
		clk <= '0';
		wait for period/2;
		std.env.finish;
	end process;
	-- Enter your statements here --

end testbench;
