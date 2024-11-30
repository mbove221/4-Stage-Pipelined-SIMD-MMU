library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity forwarding_unit_TB is
end forwarding_unit_TB;

architecture testbench of forwarding_unit_TB is
signal instruction_ex, instruction_wb : std_logic_vector(24 downto 0);
signal fwd_reg1, fwd_reg2, fwd_reg3 : std_logic;
type test_vector is record
	instruction_ex : std_logic_vector(24 downto 0);
	instruction_wb : std_logic_vector (24 downto 0);
	fwd_reg1 : std_logic;
	fwd_reg2 : std_logic;
	fwd_reg3 : std_logic;
end record;

type test_vector_array is array(natural range<>) of test_vector;
constant test_vectors : test_vector_array := (
	(
	"1000000100001000010010100", --instruction_ex 
	"0111111111111111111100100", --instruction_wb
	'1',						  --fwd_reg1
	'1',						  --fwd_reg2
	'1'						  --fwd_reg3
	),
	(
	"1000000100001000010010100", --instruction_ex : nop
	"1100000000101001010010100", --instruction_wb : OR $20, $1, $31
	'0',						  --fwd_reg1
	'0',						  --fwd_reg2
	'0'						  --fwd_reg3
	),
	(
	"1100000101000011010010100", --instruction_ex : AND $20, $20, $1
	"1100001011111110000110100", --instruction_wb : OR $20, $1, $31
	'1',						  --fwd_reg1
	'0',						  --fwd_reg2
	'0'						  --fwd_reg3
	)
);

constant period : time := 20 ns;
begin
	UUT : entity forwarding_unit port map(
		instruction_ex => instruction_ex, instruction_wb => instruction_wb,
		fwd_reg1 => fwd_reg1, fwd_reg2 => fwd_reg2, fwd_reg3 => fwd_reg3
		);
	stimulus : process
	begin
		for i in test_vectors'range loop
			instruction_ex <= test_vectors(i).instruction_ex;
			instruction_wb <= test_vectors(i).instruction_wb;
			wait for period;
			
			assert fwd_reg1 = test_vectors(i).fwd_reg1
			report "Iteration: " & integer'image(i) & " Error with fwd_reg1. Should be: " & to_string(test_vectors(i).fwd_reg1) & " Actually is: " & to_string(fwd_reg1)
			severity error;
			
			assert fwd_reg2 = test_vectors(i).fwd_reg2
			report "Error with fwd_reg2. Should be: " & to_string(test_vectors(i).fwd_reg2) & " Actually is: " & to_string(fwd_reg2)
			severity error;
			
			assert fwd_reg3 = test_vectors(i).fwd_reg3
			report "Error with fwd_reg3. Should be: " & to_string(test_vectors(i).fwd_reg3) & " Actually is: " & to_string(fwd_reg3)
			severity error;
		end loop;
		std.env.finish;
	end process;
end testbench;
