library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity mmu is
	port( 
	--For NORMAL use
	reset_n : in std_logic;
	clk : in std_logic;
	--For loading instruction buffer
	load_buffer : in std_logic;
	--For TB use
	--So we can read out register file
	is_end : in std_logic;
	read_reg : in std_logic_vector(4 downto 0);
	out_end_reg : out std_logic_vector(127 downto 0);
	--So we can view the signals at each stage
	PC_out : out std_logic_vector(5 downto 0);
	if_instr, id_instr, ex_instr, wb_instr : out std_logic_vector(24 downto 0);
	is_forward_inp1, is_forward_inp2, is_forward_inp3 : out std_logic;
	id_reg1, id_reg2, id_reg3, id_mux_inp1, id_mux_inp2, id_mux_inp3, fwd_mux_inp, write_back_data : out std_logic_vector(127 downto 0);
	alu_inp1, alu_inp2, alu_inp3, alu_outp : out std_logic_vector(127 downto 0);
	is_write_en : out std_logic;
	rd : out std_logic_vector(4 downto 0)
	);
end mmu;

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
		is_end => is_end, read_reg => read_reg, out_end_reg => out_end_reg,
		instruction => IF_ID_instr_out, write_en => EX_WB_Reg_wr_en, write_reg => EX_WB_regdest, 
		write_data => EX_WB_and_fwd_reg, reg1 => reg_file_reg1, reg2 => reg_file_reg2, reg3 => reg_file_reg3
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
	
	--IF signals
	if_instr <= instr_buffer_out;
	PC_out <= PC;	 
	
	--ID signals
	id_instr <= IF_ID_instr_out;
	id_reg1 <= reg_file_reg1;
	id_reg2 <= reg_file_reg2;
	id_reg3 <= reg_file_reg3;

	--EX/FWD signals
	id_mux_inp1 <= mux_reg1;
	id_mux_inp2 <= mux_reg2;
	id_mux_inp3 <= mux_reg3;
	ex_instr <= ID_EX_instr_out;
	is_forward_inp1 <= EX_WB_reg1;
	is_forward_inp2 <= EX_WB_reg2;
	is_forward_inp3 <= EX_WB_reg3;
	fwd_mux_inp <= EX_WB_and_fwd_reg;
	alu_inp1 <= alu_reg1;
	alu_inp2 <= alu_reg2;
	alu_inp3 <= alu_reg3;
	alu_outp <= alu_out;  
	
	--WB signals
	wb_instr <= EX_WB_instr_out;
	is_write_en <= EX_WB_Reg_wr_en;
	rd <= EX_WB_regdest;
	write_back_data <= EX_WB_and_fwd_reg;
	
	
end structural;
