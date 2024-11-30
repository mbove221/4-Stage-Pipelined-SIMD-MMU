-------------------------------------------------------------------------------
--
-- Title       : mmu_TB
-- Design      : alu
-- Author      : Michael
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:/Users/Michael/Desktop/Stony Brook University/Fall 2024/ESE 345/Project/ESE_345_Project/alu/src/mmu_TB.vhd
-- Generated   : Sat Nov 30 00:44:29 2024
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
--{entity {mmu_TB} architecture {testbench}}

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity mmu_TB is
end mmu_TB;

--}} End of automatically maintained section

architecture testbench of mmu_TB is
signal reset_n : std_logic;
signal clk : std_logic;
signal load_buffer : std_logic;
signal outp_reg : std_logic_vector(127 downto 0);
constant period : time := 50 ns;
begin

	UUT : entity mmu port map(
	reset_n => reset_n, clk => clk, load_buffer => load_buffer, outp_reg => outp_reg
	);
	pipeline : process
	variable i : integer := 0;
	begin
		reset_n <= '0';
		load_buffer <= '1';
		clk <= '0';
		wait for period;
		reset_n <= '1';
		load_buffer <= '0';
		wait for period;
		for i in 0 to 20 * 2 loop
			clk <= not clk;
			wait for period;
		end loop;
	end process;

end testbench;
