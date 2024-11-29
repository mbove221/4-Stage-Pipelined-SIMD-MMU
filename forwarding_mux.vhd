-------------------------------------------------------------------------------
--
-- Title       : forwarding_mux
-- Design      : alu
-- Author      : Michael
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:/Users/Michael/Desktop/Stony Brook University/Fall 2024/ESE 345/Project/ESE_345_Project/alu/src/forwarding_mux.vhd
-- Generated   : Thu Nov 28 21:30:42 2024
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
--{entity {forwarding_mux} architecture {behavior}}

library ieee;
use ieee.std_logic_1164.all;

entity forwarding_mux is
	port(
	fwd_reg1, fwd_reg2, fwd_reg3 : in std_logic;
	fwd_reg : in std_logic_vector(127 downto 0);
	inp_reg1, inp_reg2, inp_reg3 : in std_logic_vector(127 downto 0);
	outp_reg1, outp_reg2, outp_reg3 : out std_logic_vector(127 downto 0)
	);
end forwarding_mux;

--}} End of automatically maintained section

architecture behavior of forwarding_mux is
begin
	forwarding : process(all)
		begin
		outp_reg1 <= inp_reg1;
		outp_reg2 <= inp_reg2;
		outp_reg3 <= inp_reg3;
		if(fwd_reg1 = '1') then
			outp_reg1 <= fwd_reg;
		end if;
		if(fwd_reg2 = '1') then
			outp_reg2 <= fwd_reg;
		end if;
		if(fwd_reg3 = '1') then
			outp_reg3 <= fwd_reg;
		end if;
   end process;
end behavior;
