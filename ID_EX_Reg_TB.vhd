-------------------------------------------------------------------------------
--
-- Title       : ID_EX_Reg_TB
-- Design      : alu
-- Author      : Michael
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:/Users/Michael/Desktop/Stony Brook University/Fall 2024/ESE 345/Project/ESE_345_Project/alu/src/ID_EX_Reg_TB.vhd
-- Generated   : Sat Nov 30 06:10:11 2024
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
--{entity {ID_EX_Reg_TB} architecture {testbench}}

library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity ID_EX_Reg_TB is
end ID_EX_Reg_TB;

--}} End of automatically maintained section

architecture testbench of ID_EX_Reg_TB is
signal clk : std_logic;
signal instruction_in, instruction_out : std_logic_vector(24 downto 0);
signal reg1_in, reg2_in, reg3_in, reg1_out, reg2_out, reg3_out : std_logic_vector(127 downto 0);
signal period : time := 20 ns;
begin
	UUT : entity ID_EX_Reg port map(
		reg1_in => reg1_in, reg2_in => reg2_in, reg3_in => reg3_in, instruction_in => instruction_in, clk => clk,
		reg1_out => reg1_out, reg2_out => reg2_out, reg3_out => reg3_out, instruction_out => instruction_out
		);
	test : process
	begin
		clk <= '0';
		reg1_in <= x"5915" & x"1987" & x"1741" & x"9811" & x"1234" & x"1234" & x"2861" & x"6181";
		reg2_in <= x"8761" & x"6151" & x"7141" & x"1865" & x"1247" & x"5811" & x"4716" & x"4681";
		reg3_in <= (others => '1');
		instruction_in <= "0111111111111111111111110";
		wait for period;
		clk <= '1';
		wait for period;
		clk <= '0';	
		reg1_in <= (others => '1');
		reg2_in <= x"5915" & x"1987" & x"1741" & x"9811" & x"1234" & x"1234" & x"2861" & x"6181";
		reg3_in <= x"8761" & x"6151" & x"7141" & x"1865" & x"1247" & x"5811" & x"4716" & x"4681";
		wait for period;
		clk <= '1';
		wait for period;
		clk <= '0';
		wait for period;
		std.env.finish;
	end process;

	-- Enter your statements here --

end testbench;
