-------------------------------------------------------------------------------
--
-- Title       : forwarding_mux_TB
-- Design      : alu
-- Author      : Michael
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:/Users/Michael/Desktop/Stony Brook University/Fall 2024/ESE 345/Project/ESE_345_Project/alu/src/forwarding_mux_TB.vhd
-- Generated   : Sat Nov 30 12:04:25 2024
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
--{entity {forwarding_mux_TB} architecture {testbench}}

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity forwarding_mux_TB is
end forwarding_mux_TB;

--}} End of automatically maintained section

architecture testbench of forwarding_mux_TB is
signal fwd_reg1, fwd_reg2, fwd_reg3 : std_logic;
signal fwd_reg, inp_reg1, inp_reg2, inp_reg3, outp_reg1, outp_reg2, outp_reg3 : std_logic_vector(127 downto 0);
constant period : time := 20 ns;
type test_vector is record
	fwd_reg3 : std_logic;
	fwd_reg2 : std_logic;
	fwd_reg1 : std_logic;
	fwd_reg : std_logic_vector(127 downto 0);
	inp_reg1 : std_logic_vector(127 downto 0);
	inp_reg2 : std_logic_vector(127 downto 0);
	inp_reg3 : std_logic_vector(127 downto 0);
	outp_reg1 : std_logic_vector(127 downto 0);
	outp_reg2 : std_logic_vector(127 downto 0); 
	outp_reg3 : std_logic_vector(127 downto 0);
end record;
type test_vector_array is array(natural range<>) of test_vector;
constant test_vectors : test_vector_array := (
	('0', '0', '0', 					--(fwd_reg3, fwd_reg2, fwd_reg1)
	x"01234567899876543210123456789987", --fwd_reg 
	(others => '1'), 					--inp_reg1
	x"59151987174198111234123428616181",	--inp_reg2 
	x"87616151714118651247581147164681",	--inp_reg3
	(others => '1'), 					--outp_reg1
	x"59151987174198111234123428616181",	--outp_reg2 
	x"87616151714118651247581147164681"--outp_reg3 
	),
	('0', '0', '1', 					--(fwd_reg3, fwd_reg2, fwd_reg1)
	x"01234567899876543210123456789987", --fwd_reg 
	(others => '1'), 					--inp_reg1
	x"59151987174198111234123428616181",	--inp_reg2 
	x"87616151714118651247581147164681",	--inp_reg3
	x"01234567899876543210123456789987",	--outp_reg1
	x"59151987174198111234123428616181",	--outp_reg2 
	x"87616151714118651247581147164681"	--outp_reg3 
	),
	('0', '1', '0', 					--(fwd_reg3, fwd_reg2, fwd_reg1)
	x"01234567899876543210123456789987", --fwd_reg 
	(others => '1'), 					--inp_reg1
	x"59151987174198111234123428616181",	--inp_reg2 
	x"87616151714118651247581147164681",	--inp_reg3
	(others => '1'), 					--outp_reg1
	x"01234567899876543210123456789987",	--outp_reg2 
	x"87616151714118651247581147164681"	--outp_reg3 
	),
	('0', '1', '1', 					--(fwd_reg3, fwd_reg2, fwd_reg1)
	x"01234567899876543210123456789987", --fwd_reg 
	(others => '1'), 					--inp_reg1
	x"59151987174198111234123428616181",	--inp_reg2 
	x"87616151714118651247581147164681",	--inp_reg3
	x"01234567899876543210123456789987",	--outp_reg1
	x"01234567899876543210123456789987",	--outp_reg2 
	x"87616151714118651247581147164681"	--outp_reg3
	),
	('1', '0', '0', 					--(fwd_reg3, fwd_reg2, fwd_reg1)
	x"01234567899876543210123456789987", --fwd_reg 
	(others => '1'), 					--inp_reg1
	x"59151987174198111234123428616181",	--inp_reg2 
	x"87616151714118651247581147164681",	--inp_reg3
	(others => '1'), 					--outp_reg1
	x"59151987174198111234123428616181",	--outp_reg2 
	x"01234567899876543210123456789987"	--outp_reg3 
	),
	('1', '0', '1', 					--(fwd_reg3, fwd_reg2, fwd_reg1)
	x"01234567899876543210123456789987", --fwd_reg 
	x"01234567899876543210123456789987", --inp_reg1
	x"59151987174198111234123428616181",	--inp_reg2 
	x"87616151714118651247581147164681",	--inp_reg3
	x"01234567899876543210123456789987",	--outp_reg1
	x"59151987174198111234123428616181",	--outp_reg2 
	x"01234567899876543210123456789987"	--outp_reg3 
	),
	('1', '1', '0', 					--(fwd_reg3, fwd_reg2, fwd_reg1)
	x"01234567899876543210123456789987", --fwd_reg 
	(others => '1'), 					--inp_reg1
	x"59151987174198111234123428616181",	--inp_reg2 
	x"87616151714118651247581147164681",	--inp_reg3
	(others => '1'), 					--outp_reg1
	x"01234567899876543210123456789987",	--outp_reg2 
	x"01234567899876543210123456789987"	--outp_reg3 
	),
	('1', '1', '1', 					--(fwd_reg3, fwd_reg2, fwd_reg1)
	x"01234567899876543210123456789987", --fwd_reg 
	(others => '1'), 					--inp_reg1
	x"59151987174198111234123428616181",	--inp_reg2 
	x"87616151714118651247581147164681",	--inp_reg3
	x"01234567899876543210123456789987",	--outp_reg1
	x"01234567899876543210123456789987",	--outp_reg2 
	x"01234567899876543210123456789987"	--outp_reg3 
	)
	
);
begin
	UUT : entity forwarding_mux port map(
		fwd_reg1 => fwd_reg1, fwd_reg2 => fwd_reg2, fwd_reg3 => fwd_reg3, fwd_reg => fwd_reg, 
		inp_reg1 => inp_reg1, inp_reg2 => inp_reg2, inp_reg3 => inp_reg3, outp_reg1 => outp_reg1,
		outp_reg2 => outp_reg2, outp_reg3 => outp_reg3
		);
	stimulus : process
	begin
		for i in test_vectors'range loop
            fwd_reg1 <= test_vectors(i).fwd_reg1;
            fwd_reg2 <= test_vectors(i).fwd_reg2;
		   fwd_reg3 <= test_vectors(i).fwd_reg3;
		   fwd_reg <= test_vectors(i).fwd_reg;
		   inp_reg1 <= test_vectors(i).inp_reg1;
		   inp_reg2 <= test_vectors(i).inp_reg2;
		   inp_reg3 <= test_vectors(i).inp_reg3;
            
            wait for period;
           
            assert outp_reg1 = test_vectors(i).outp_reg1 
		   report "Iteration" & integer'image(i) & "Error with outp_reg1. Should be: " & to_string(test_vectors(i).outp_reg1) & " But is: " & to_string(outp_reg1) 
		   severity error;
		   assert outp_reg2 = test_vectors(i).outp_reg2 
		   report "Error with outp_reg2. Should be: " & to_string(test_vectors(i).outp_reg2) & " But is: " & to_string(outp_reg2) 
		   severity error;
		   assert outp_reg3 = test_vectors(i).outp_reg3 
		   report "Error with outp_reg3. Should be: " & to_string(test_vectors(i).outp_reg3) & " But is: " & to_string(outp_reg3) 
		   severity error;
        end loop;

        std.env.finish;
		std.env.finish;
	end process;
			

end testbench;
