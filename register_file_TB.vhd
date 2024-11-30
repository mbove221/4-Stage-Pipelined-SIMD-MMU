library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity register_file_TB is
end register_file_TB;

architecture testbench of register_file_TB is

-- Define signals
signal period : time := 20 ns;
signal instruction : std_logic_vector(24 downto 0);
signal write_en : std_logic;
signal write_reg : std_logic_vector(4 downto 0);
signal write_data : std_logic_vector(127 downto 0);
signal reg1, reg2, reg3, reg_dest : std_logic_vector(127 downto 0);

-- Define test_vector with all relevant fields
type test_vector is record
	instruction : std_logic_vector(24 downto 0);
	write_en : std_logic;
	write_reg : std_logic_vector(4 downto 0);
	write_data : std_logic_vector(127 downto 0);
	reg1 : std_logic_vector(127 downto 0);
	reg2 : std_logic_vector(127 downto 0);
	reg3 : std_logic_vector(127 downto 0);
	reg_dest : std_logic_vector(127 downto 0);
end record;

-- Array of test_vectors for test cases
type test_vector_array is array(natural range<>) of test_vector;
constant test_vectors : test_vector_array := (
    (
        "0111111111111111111111110",  		-- instruction li $30, 7, 65535
        '1',                        			-- write_en
        "11110",                    			-- write_reg
        x"01234567899876543210123456789987", 	-- write_data
        x"01234567899876543210123456789987", 	-- reg1 (expected value)
        (others => '0'),           			-- reg2
        (others => '0'),            			-- reg3
        x"01234567899876543210123456789987"   -- reg_dest (expected value)
    ),
    (
        "0111111111111111111111111", 		-- instruction li $31, 7, 65535
        '0',                        			-- write_en
        "11111",                    			-- write_reg
        x"23456789987654321012345678998765", 	-- write_data
        (others => '0'),            			-- reg1
        (others => '0'),           	 		-- reg2
        (others => '0'),            			-- reg3
        (others => '0')             			-- reg_dest (expected value)
    ),
	(
	   "1100001011111100000100100", 		-- instruction or $4, $1, $30
        '1',                        			-- write_en
        "11111",                    			-- write_reg
        x"23456789987654321012345678998765", 	-- write_data
        (others => '0'),  					-- reg1
        x"01234567899876543210123456789987",  -- reg2
        (others => '0'),            			-- reg3
        (others => '0')             			-- reg_dest (expected value)
	),
	(
	   "1000011110000001111110100", 		-- instruction simals $20, $31, $0, $30
        '0',                        			-- write_en
        "11111",                    			-- write_reg
        x"56789987654321012345678998765432", 	-- write_data
        x"23456789987654321012345678998765",  -- reg1
        (others => '0'),  					-- reg2
        x"01234567899876543210123456789987",  -- reg3
        (others => '0')   					-- reg_dest (expected value)
	)
);

begin
    UUT : entity reg_file port map (
        instruction => instruction,
        write_en => write_en,
        write_reg => write_reg,
        write_data => write_data,
        reg1 => reg1,
        reg2 => reg2,
        reg3 => reg3,
        reg_dest => reg_dest
    );

    tb : process
    begin
        for i in test_vectors'range loop
            instruction <= test_vectors(i).instruction;
            write_en <= test_vectors(i).write_en;
            write_reg <= test_vectors(i).write_reg;
            write_data <= test_vectors(i).write_data;
            
            wait for period;
           
            assert reg1 = test_vectors(i).reg1 
		   report "Error with reg1. Should be: " & to_string(test_vectors(i).reg1) & " But is: " & to_string(reg1) 
		   severity error;
		   assert reg2 = test_vectors(i).reg2 
		   report "Error with reg2. Should be: " & to_string(test_vectors(i).reg2) & " But is: " & to_string(reg2) 
		   severity error;
		   assert reg3 = test_vectors(i).reg3 
		   report "Error with reg3. Should be: " & to_string(test_vectors(i).reg3) & " But is: " & to_string(reg3) 
		   severity error;
		   assert reg_dest = test_vectors(i).reg_dest 
		   report "Error with reg_dest. Should be: " & to_string(test_vectors(i).reg_dest) & " But is: " & to_string(reg_dest) 
		   severity error;
        end loop;

        std.env.finish;
    end process;

end testbench;
