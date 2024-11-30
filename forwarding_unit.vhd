-------------------------------------------------------------------------------
--
-- Title       : forwarding_unit
-- Design      : alu
-- Author      : Michael
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:/Users/Michael/Desktop/Stony Brook University/Fall 2024/ESE 345/Project/ESE_345_Project/alu/src/forwarding_unit.vhd
-- Generated   : Thu Nov 28 21:37:24 2024
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
--{entity {forwarding_unit} architecture {behavior}}

library ieee;
use ieee.std_logic_1164.all;

entity forwarding_unit is
	port(
	instruction_ex, instruction_wb : in std_logic_vector(24 downto 0);
	fwd_reg1, fwd_reg2, fwd_reg3 : out std_logic
	);
end forwarding_unit;

--}} End of automatically maintained section

architecture behavior of forwarding_unit is
begin
	compare : process(all)
	begin
		fwd_reg1 <= '0';
		fwd_reg2 <= '0';
		fwd_reg3 <= '0';
		case instruction_ex(24) is
			when '0' => 
				if(instruction_ex(4 downto 0) = instruction_wb(4 downto 0)) then
					fwd_reg1 <= '1';
				end if;
			when '1' =>
				if (instruction_ex(23) = '0') then
					if (instruction_ex(19 downto 15) = instruction_wb(4 downto 0)) then
						fwd_reg3 <= '1';
					end if;
					if (instruction_ex(14 downto 10) = instruction_wb(4 downto 0)) then
						fwd_reg2 <= '1';
					end if;
					if (instruction_ex(9 downto 5) = instruction_wb(4 downto 0)) then
						fwd_reg1 <= '1';
					end if;
				elsif (instruction_ex(23) = '1') then
					if (instruction_ex(14 downto 10) = instruction_wb(4 downto 0) and (instruction_ex(18 downto 15) /= "0000" and instruction_wb(18 downto 15) /= "0000")) then
						fwd_reg2 <= '1';
					end if;
					if (instruction_ex(9 downto 5) = instruction_wb(4 downto 0) and (instruction_ex(18 downto 15) /= "0000" and instruction_wb(18 downto 15) /= "0000")) then
						fwd_reg1 <= '1';
					end if;
				end if;
			when others =>
		end case;
	end process;
end behavior;
