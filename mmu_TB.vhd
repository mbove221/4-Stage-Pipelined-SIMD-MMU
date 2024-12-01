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

library std;
use std.textio.all; 

entity mmu_TB is
end mmu_TB;

--}} End of automatically maintained section

architecture testbench of mmu_TB is
--For NORMAL use
signal reset_n : std_logic;
signal clk : std_logic;
--For loading instruction buffer
signal load_buffer : std_logic;
--For TB use
--So we can read out register file
signal is_end : std_logic;
signal read_reg : std_logic_vector(4 downto 0);
signal out_end_reg : std_logic_vector(127 downto 0);
--So we can view the signals at each stage
signal PC_out : std_logic_vector(5 downto 0);
signal if_instr, id_instr, ex_instr, wb_instr : std_logic_vector(24 downto 0);
signal is_forward_inp1, is_forward_inp2, is_forward_inp3 : std_logic;
signal id_reg1, id_reg2, id_reg3, id_mux_inp1, id_mux_inp2, id_mux_inp3, fwd_mux_inp, write_back_data : std_logic_vector(127 downto 0);
signal alu_inp1, alu_inp2, alu_inp3, alu_outp : std_logic_vector(127 downto 0);
signal is_write_en : std_logic;
signal rd : std_logic_vector(4 downto 0);  
constant period : time := 20 ns;

begin

	UUT : entity mmu port map(
	PC_out => PC_out, reset_n => reset_n, clk => clk, load_buffer => load_buffer, is_end => is_end, read_reg => read_reg, out_end_reg => out_end_reg,
	if_instr => if_instr, id_instr => id_instr, ex_instr => ex_instr, wb_instr => wb_instr, is_forward_inp1 => is_forward_inp1,
	is_forward_inp2 => is_forward_inp2, is_forward_inp3 => is_forward_inp3, id_reg1 => id_reg1, id_reg2 => id_reg2, id_reg3 => id_reg3,
	id_mux_inp1 => id_mux_inp1, id_mux_inp2 => id_mux_inp2, id_mux_inp3 => id_mux_inp3, fwd_mux_inp => fwd_mux_inp, write_back_data => write_back_data,
	alu_inp1 => alu_inp1, alu_inp2 => alu_inp2, alu_inp3 => alu_inp3, alu_outp => alu_outp, is_write_en => is_write_en, rd => rd
	);
	pipeline : process
	variable i : integer := 0;
	file output_file: text open write_mode is "results_file.txt";
	variable line_buffer : line;
	variable cycle_count : integer := 1;
	begin
		is_end <= '0';
		reset_n <= '0';
		load_buffer <= '1';
		clk <= '0';
		wait for period/2;
		write(line_buffer, string'("Cycle: " & to_string(cycle_count)));
		writeline(output_file, line_buffer);
		write(line_buffer, string'("First instruction fetch: " & to_string(if_instr)));
		writeline(output_file, line_buffer);
		write(line_buffer, string'("========================================================"));
		writeline(output_file, line_buffer);
		reset_n <= '1';
		load_buffer <= '0';
		wait for period/2;
		for i in 0 to 66 * 2 - 1 loop
			clk <= not clk;
			wait for period/2;
			if clk = '1' then
				cycle_count := cycle_count + 1;
				write(line_buffer, string'("Cycle: " & to_string(cycle_count)));
				writeline(output_file, line_buffer);
				
				write(line_buffer, string'(" "));
				writeline(output_file, line_buffer); 
				
				write(line_buffer, string'("==============Stage 1: IF stage=============="));
				writeline(output_file, line_buffer);
				write(line_buffer, string'("Instruction: " & to_string(if_instr)));
				
				writeline(output_file, line_buffer); 
				
				write(line_buffer, string'(" "));
				writeline(output_file, line_buffer); 
				
				write(line_buffer, string'("==============Stage 2: ID stage=============="));
				writeline(output_file, line_buffer);
				write(line_buffer, string'("Instruction: " & to_string(id_instr)));
				writeline(output_file, line_buffer);
				if(id_instr(24) = '0') then
					write(line_buffer, string'("Register 1 (" & integer'image(to_integer(unsigned(id_instr(4 downto 0)))) & "): " & to_hstring(id_reg1)));
					writeline(output_file, line_buffer);	
				else
					write(line_buffer, string'("Register 1 (" & integer'image(to_integer(unsigned(id_instr(9 downto 5)))) & "): " & to_hstring(id_reg1)));
					writeline(output_file, line_buffer);
				end if;
				write(line_buffer, string'("Register 2: (" & integer'image(to_integer(unsigned(id_instr(14 downto 10)))) & "): " & to_hstring(id_reg2)));
				writeline(output_file, line_buffer);
				write(line_buffer, string'("Register 3: (" & integer'image(to_integer(unsigned(id_instr(19 downto 15)))) & "): " & to_hstring(id_reg3)));
				writeline(output_file, line_buffer);
				
				write(line_buffer, string'(" "));
				writeline(output_file, line_buffer);  
				
				write(line_buffer, string'("==============Stage 3: EX/FWD stage=============="));
				writeline(output_file, line_buffer);
				write(line_buffer, string'("Instruction: " & to_string(ex_instr)));
				writeline(output_file, line_buffer);
				write(line_buffer, string'("ID Register 1: " & to_hstring(id_mux_inp1)));
				writeline(output_file, line_buffer);
				write(line_buffer, string'("ID Register 2: " & to_hstring(id_mux_inp2)));
				writeline(output_file, line_buffer);
				write(line_buffer, string'("ID Register 3: " & to_hstring(id_mux_inp3)));
				writeline(output_file, line_buffer);
				
				
				write(line_buffer, string'(" "));
				writeline(output_file, line_buffer); 
				
				write(line_buffer, string'("Forward Register: " & to_hstring(fwd_mux_inp)));
				writeline(output_file, line_buffer);
				write(line_buffer, string'("FWD 1: " & to_string(is_forward_inp1)));
				writeline(output_file, line_buffer);
				write(line_buffer, string'("FWD 2: " & to_string(is_forward_inp2)));
				writeline(output_file, line_buffer);
				write(line_buffer, string'("FWD 3: " & to_string(is_forward_inp3)));
				writeline(output_file, line_buffer);
				
				write(line_buffer, string'("ALU Input Register 1: " & to_hstring(alu_inp1)));
				writeline(output_file, line_buffer);
				write(line_buffer, string'("ALU Input Register 2: " & to_hstring(alu_inp2)));
				writeline(output_file, line_buffer); 
				write(line_buffer, string'("ALU Input Register 3: " & to_hstring(alu_inp3)));
				writeline(output_file, line_buffer);
				
				write(line_buffer, string'(" "));
				writeline(output_file, line_buffer);
				
				write(line_buffer, string'("ALU Output Register: " & to_hstring(alu_outp)));
				writeline(output_file, line_buffer); 
				
				write(line_buffer, string'(" "));
				writeline(output_file, line_buffer);
				
				write(line_buffer, string'("==============Stage 4: WB/FWD stage=============="));
				writeline(output_file, line_buffer);
				write(line_buffer, string'("Instruction: " & to_string(wb_instr)));
				writeline(output_file, line_buffer);
				write(line_buffer, string'("WB: " & to_string(is_write_en)));
				writeline(output_file, line_buffer);
				write(line_buffer, string'("Destination register: " & integer'image(to_integer(unsigned(rd)))));
				writeline(output_file, line_buffer);
				write(line_buffer, string'("Writeback Data: " & to_hstring(write_back_data)));
				writeline(output_file, line_buffer);
				
				write(line_buffer, string'(" "));
				writeline(output_file, line_buffer);
				write(line_buffer, string'("********DONE WITH CYCLE " & integer'image(cycle_count) & "********"));
				writeline(output_file, line_buffer);
				write(line_buffer, string'("*************************************"));
				writeline(output_file, line_buffer);
				
				write(line_buffer, string'(" "));
				writeline(output_file, line_buffer);
				
			end if;
		end loop;
		is_end <= '1';
		write(line_buffer, string'(" "));
		writeline(output_file, line_buffer);
		write(line_buffer, string'(" "));
		writeline(output_file, line_buffer);
		write(line_buffer, string'("********==============Final register file:==============********"));
		writeline(output_file, line_buffer);
		read_reg <= (others => '0');
		wait for period;
		for i in 0 to 2**5 - 1 loop
			read_reg <= std_logic_vector(to_unsigned(i, 5));
			wait for period;
			write(line_buffer, string'("Register " & integer'image(i) & ": " & to_hstring(out_end_reg)));
			writeline(output_file, line_buffer);
		end loop;
		file_close(output_file);
		std.env.finish;
	end process;
	
	
	

end testbench;
