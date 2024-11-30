-------------------------------------------------------------------------------
--
-- Title       : mmu
-- Design      : alu
-- Author      : Michael
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:/Users/Michael/Desktop/Stony Brook University/Fall 2024/ESE 345/Project/ESE_345_Project/alu/src/mmu.vhd
-- Generated   : Fri Nov 29 17:55:04 2024
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
--{entity {mmu} architecture {structural}}

library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity mmu is
	port(
	reset_n : in std_logic;
	clk : in std_logic;
	load_buffer : in std_logic;
	outp_reg : out std_logic_vector(127 downto 0)
	);
end mmu;

--}} End of automatically maintained section

architecture structural of mmu is
signal PC : std_logic_vector(5 downto 0);
signal EX_WB_Reg_wr_en, EX_WB_reg1, EX_WB_reg2, EX_WB_reg3: std_logic;
signal instr_buffer_out, IF_ID_instr_out, ID_EX_instr_out, EX_WB_instr_out : std_logic_vector(24 downto 0);
signal reg_file_reg1, reg_file_reg2, reg_file_reg3, reg_file_regdest, EX_WB_Reg_data : std_logic_vector(127 downto 0);
signal mux_reg1, mux_reg2, mux_reg3, alu_reg1, alu_reg2, alu_reg3, alu_out, EX_WB_and_fwd_reg: std_logic_vector(127 downto 0);
signal EX_WB_regdest : std_logic_vector(4 downto 0);
begin
	U1 : entity program_counter port map(
		reset_n => reset_n, clk => clk, PC => PC
		);	  
		
	U2 : entity instruction_buffer port map(
		PC => PC, load_buffer => load_buffer, output => instr_buffer_out
		); 
		
	U3 : entity IF_ID_Reg port map(
		instruction_in => instr_buffer_out, clk => clk, instruction_out => IF_ID_instr_out
		);
		
	U4 : entity reg_file port map(
		instruction => IF_ID_instr_out, write_en => EX_WB_Reg_wr_en, write_reg => EX_WB_regdest, 
		write_data => EX_WB_and_fwd_reg, reg1 => reg_file_reg1, reg2 => reg_file_reg2, reg3 => reg_file_reg3,
		reg_dest => reg_file_regdest
		);
		
	U5 : entity ID_EX_Reg port map(
		reg1_in => reg_file_reg1, reg2_in => reg_file_reg2, reg3_in => reg_file_reg3,
		instruction_in => IF_ID_instr_out, clk => clk, reg1_out => mux_reg1, reg2_out => mux_reg2, reg3_out => mux_reg3,
		instruction_out => ID_EX_instr_out);	
		
	U6 : entity forwarding_mux port map(
		fwd_reg1 => EX_WB_reg1, fwd_reg2 => EX_WB_reg2, fwd_reg3 => EX_WB_reg3, fwd_reg => EX_WB_and_fwd_reg, 
		inp_reg1 => mux_reg1, inp_reg2 => mux_reg2, inp_reg3 => mux_reg3, outp_reg1 => alu_reg1,
		outp_reg2 => alu_reg2, outp_reg3 => alu_reg3
		);	
		
	U7 : entity alu port map(
		instruction => ID_EX_instr_out, inp1 => alu_reg1, inp2 => alu_reg2, inp3 => alu_reg3, outp => alu_out
		);
		
	U8 : entity EX_WB_Reg port map(
		alu_out_wb_in => alu_out, instruction_in => ID_EX_instr_out, clk => clk, reg_dest => EX_WB_regdest,
		data_output => EX_WB_and_fwd_reg, write_en => EX_WB_Reg_wr_en, instruction_out => EX_WB_instr_out
		);
		
	U9 : entity forwarding_unit port map(
		instruction_ex => ID_EX_instr_out, instruction_wb => EX_WB_instr_out, fwd_reg1 => EX_WB_reg1,
		fwd_reg2 => EX_WB_reg2, fwd_reg3 => EX_WB_reg3
		);
					  
   outp_reg <= EX_WB_and_fwd_reg;
end structural;
