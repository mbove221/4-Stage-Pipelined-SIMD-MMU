-------------------------------------------------------------------------------
--
-- Title       : alu
-- Design      : alu
-- Author      : Michael
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:/Users/Michael/Desktop/Stony Brook University/Fall 2024/ESE 345/Project/ESE_345_Project/alu/src/alu.vhd
-- Generated   : Mon Oct 14 20:28:43 2024
-- From        : Interface description file
-- By          : ItfToHdl ver. 1.0
--
-------------------------------------------------------------------------------
--
-- Description : Behavioral architecture describing ALU implementation
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--{{ Section below this comment is automatically maintained
--    and may be overwritten
--{entity {alu} architecture {behavior}}



entity alu is
	generic(int64_max : integer := (2**63) - 1;
			int64_min : integer := -2**63;
			int32_max : integer := (2**31) -1;
			int32_min : integer := -2**31
			);
	port(
	instruction : in std_logic_vector(24 downto 0);
	inp1 : in std_logic_vector(127 downto 0);
	inp2 : in std_logic_vector(127 downto 0);
	inp3 : in std_logic_vector(127 downto 0);
	outp : out std_logic_vector(127 downto 0)	
	);
end alu;

--}} End of automatically maintained section

architecture behavior of alu is
begin
	ALU: process(all)
	variable load_index: integer; 
	variable product : integer;
	variable sum : integer;
	variable diff : integer;
	variable upper_64, lower_64 : integer; --upper and lower 64 bit limits
	variable upper_32, lower_32 : integer; --upper and lower 32 bit limits
	variable upper_16, lower_16 : integer; --upper and lower 16 bit limits
	variable inp1_var, inp2_var, inp3_var : std_logic_vector(127 downto 0);
	variable outp_var : std_logic_vector(127 downto 0);
	variable overflow_32 : std_logic_vector(31 downto 0);
	variable overflow_64 : std_logic_vector(63 downto 0);
	variable shift_amt : integer;
	variable ones_count : integer;
	variable leading_zeros : integer;
	variable unsigned_sum : unsigned(32 downto 0);
	variable unsigned_diff : unsigned(32 downto 0);
	
	
	variable upper_4, lower_4 : integer;
	begin
		inp1_var := inp1;
		inp2_var := inp2;
		inp3_var := inp3;
		if(instruction(24) = '0') then --Load Immediate
			load_index := (to_integer(unsigned(instruction(23 downto 21)))) * 16; --128bits/8possibilities = 16 bits (starts with 15 downto 0)
			inp1_var(load_index + 15 downto load_index) := instruction(20 downto 5);
			outp <= inp1_var;
		else --if reached, instruction(24) = 1
			if (instruction(23) = '0') then --R4-Instruction Format 
				case instruction(22 downto 20) is 
					when "000" => --Signed Integer Multiply-Add Low with Saturation

					for i in 0 to 3 loop
							upper_16 := i*32 + 15;
							lower_16 := i*32;
							upper_32 := i*32 + 31;
							lower_32 := i*32;
							outp_var(upper_32 downto lower_32) := std_logic_vector(signed(inp2_var(upper_16 downto lower_16)) * signed(inp3_var(upper_16 downto lower_16)));
							if(outp_var (upper_32) = inp1_var(upper_32)) then
								overflow_32 := std_logic_vector(signed(inp1_var(upper_32 downto lower_32)) + signed(outp_var(upper_32 downto lower_32)));
								if(overflow_32(31) /= inp1_var(upper_32)) then --if 2 negatives = positive or 2 positives = negative (possible overflow)
									outp(upper_32) <= not overflow_32(31);
									outp(upper_32 - 1 downto lower_32) <= (others => overflow_32(31));
								else
									outp(upper_32 downto lower_32) <= overflow_32;
								end if;
							else
								outp(upper_32 downto lower_32) <= std_logic_vector(signed(outp_var(upper_32 downto lower_32)) + signed(inp1_var(upper_32 downto lower_32)));
							end if;
						end loop;
						
					when "001" => --Signed Integer Multiply-Add High with Saturation
						for i in 0 to 3 loop 
							upper_16 := i*32 + 31;
							lower_16 := i*32 + 16;
							upper_32 := i*32 + 31;
							lower_32 := i*32;
							outp_var(upper_32 downto lower_32) := std_logic_vector(signed(inp2_var(upper_16 downto lower_16)) * signed(inp3_var(upper_16 downto lower_16)));
							product := to_integer(signed(outp_var(upper_32 downto lower_32)));
							if(outp_var (upper_32) = inp1_var(upper_32)) then
								overflow_32 := std_logic_vector(signed(inp1_var(upper_32 downto lower_32)) + signed(outp_var(upper_32 downto lower_32)));
								if(overflow_32(31) /= inp1_var(upper_32)) then --if 2 negatives = positive or 2 positives = negative (possible overflow)
									outp(upper_32) <= not overflow_32(31);
									outp(upper_32 - 1 downto lower_32) <= (others => overflow_32(31));
								else
									outp(upper_32 downto lower_32) <= overflow_32;
								end if;
							else
								outp(upper_32 downto lower_32) <= std_logic_vector(signed(outp_var(upper_32 downto lower_32)) + signed(inp1_var(upper_32 downto lower_32)));
							end if;
						end loop;
							
					when "010" => --Signed Integer Multiply-Subtract Low with Saturation 
						for i in 0 to 3 loop
							upper_16 := i*32 + 15;
							lower_16 := i*32;
							upper_32 := i*32 + 31;
							lower_32 := i*32;
							outp_var(upper_32 downto lower_32) := std_logic_vector(signed(inp2_var(upper_16 downto lower_16)) * signed(inp3_var(upper_16 downto lower_16)));
							product := to_integer(signed(outp_var(upper_32 downto lower_32)));
							if(outp_var (upper_32) /= inp1_var(upper_32)) then --compare if 2 opposite signs
								overflow_32 := std_logic_vector(signed(inp1_var(upper_32 downto lower_32)) - signed(outp_var(upper_32 downto lower_32)));
								if(overflow_32(31) /= inp1_var(upper_32)) then
									outp(upper_32) <= not overflow_32(31);
									outp(upper_32 - 1 downto lower_32) <= (others => overflow_32(31));
								else
									outp(upper_32 downto lower_32) <= overflow_32;
								end if;
							else
								outp(upper_32 downto lower_32) <= std_logic_vector(signed(inp1_var(upper_32 downto lower_32)) - signed(outp_var(upper_32 downto lower_32)));
							end if;
						end loop;
						
					when "011" => --Signed Integer Multiply-Subtract High with Saturation
						for i in 0 to 3 loop 
							upper_16 := i*32 + 31;
							lower_16 := i*32 + 16;
							upper_32 := i*32 + 31;
							lower_32 := i*32;
							outp_var(upper_32 downto lower_32) := std_logic_vector(signed(inp2_var(upper_16 downto lower_16)) * signed(inp3_var(upper_16 downto lower_16)));
							product := to_integer(signed(outp_var(upper_32 downto lower_32)));
							if(outp_var (upper_32) /= inp1_var(upper_32)) then
								overflow_32 := std_logic_vector(signed(inp1_var(upper_32 downto lower_32)) - signed(outp_var(upper_32 downto lower_32)));
								if(overflow_32(31) /= inp1_var(upper_32)) then --if opposite signs, subtraction results in same signs (possible overflow)
									outp(upper_32) <= not overflow_32(31);
									outp(upper_32 - 1 downto lower_32) <= (others => overflow_32(31));
								else
									outp(upper_32 downto lower_32) <= overflow_32;
								end if;
							else
								outp(upper_32 downto lower_32) <= std_logic_vector(signed(inp1_var(upper_32 downto lower_32)) - signed(outp_var(upper_32 downto lower_32)));
							end if;
						end loop;
					when "100" => --Signed Long Integer Multiply-Add Low with Saturation
						for i in 0 to 1 loop
							upper_32 := i*64 + 31;
							lower_32 := i*64;
							upper_64 := i*64 + 63;
							lower_64 := i*64;
							outp_var(upper_64 downto lower_64) := std_logic_vector(signed(inp2_var(upper_32 downto lower_32)) * signed(inp3_var(upper_32 downto lower_32)));
							if(outp_var (upper_64) = inp1_var(upper_64)) then
								overflow_64 := std_logic_vector(signed(inp1_var(upper_64 downto lower_64)) + signed(outp_var(upper_64 downto lower_64)));
								if(overflow_64(63) /= inp1_var(upper_64)) then --if 2 negatives = positive or 2 positives = negative (possible overflow)
									outp(upper_64) <= not overflow_64(63);
									outp(upper_64 - 1 downto lower_64) <= (others => overflow_64(63));
								else
									outp(upper_64 downto lower_64) <= overflow_64;
								end if;
							else
								outp(upper_64 downto lower_64) <= std_logic_vector(signed(outp_var(upper_64 downto lower_64)) + signed(inp1_var(upper_64 downto lower_64)));
							end if;
						end loop;
					when "101" => --Signed Long Integer Multiply-Add High with Saturation
						for i in 0 to 1 loop
							upper_32 := i*64 + 63;
							lower_32 := i*64 + 32;
							upper_64 := i*64 + 63;
							lower_64 := i*64;
							outp_var(upper_64 downto lower_64) := std_logic_vector(signed(inp2_var(upper_32 downto lower_32)) * signed(inp3_var(upper_32 downto lower_32)));
							if(outp_var (upper_64) = inp1_var(upper_64)) then
								overflow_64 := std_logic_vector(signed(inp1_var(upper_64 downto lower_64)) + signed(outp_var(upper_64 downto lower_64)));
								if(overflow_64(63) /= inp1_var(upper_64)) then --if 2 negatives = positive or 2 positives = negative (possible overflow)
									outp(upper_64) <= not overflow_64(63);
									outp(upper_64 - 1 downto lower_64) <= (others => overflow_64(63));
								else
									outp(upper_64 downto lower_64) <= overflow_64;
								end if;
							else
								outp(upper_64 downto lower_64) <= std_logic_vector(signed(outp_var(upper_64 downto lower_64)) + signed(inp1_var(upper_64 downto lower_64)));
							end if;
						end loop;
					when "110" => --Signed Long Integer Multiply-Subtract Low with Saturation
						for i in 0 to 1 loop
							upper_32 := i*64 + 31;
							lower_32 := i*64;
							upper_64 := i*64 + 63;
							lower_64 := i*64;
							outp_var(upper_64 downto lower_64) := std_logic_vector(signed(inp2_var(upper_32 downto lower_32)) * signed(inp3_var(upper_32 downto lower_32)));
							product := to_integer(signed(outp_var(upper_64 downto lower_64)));
							if(outp_var (upper_64) /= inp1_var(upper_64)) then
								outp <= (others => '1');
								overflow_64 := std_logic_vector(signed(inp1_var(upper_64 downto lower_64)) - signed(outp_var(upper_64 downto lower_64)));
								if(overflow_64(63) /= inp1_var(upper_64)) then --if 1 negatives - 1 positive or 1 positives - 1 negative (possible overflow)
									outp(upper_64) <= not overflow_64(63);
									outp(upper_64 - 1 downto lower_64) <= (others => overflow_64(63));
								else
									outp(upper_64 downto lower_64) <= overflow_64;
								end if;
							else  
								outp(upper_64 downto lower_64) <= std_logic_vector(signed(inp1_var(upper_64 downto lower_64)) - signed(outp_var(upper_64 downto lower_64)));
							end if;
						end loop;
					when "111" => --Signed Long Integer Multiply-Subtract High with Saturation
						for i in 0 to 1 loop
							upper_32 := i*64 + 63;
							lower_32 := i*64 + 32;
							upper_64 := i*64 + 63;
							lower_64 := i*64;
							outp_var(upper_64 downto lower_64) := std_logic_vector(signed(inp2_var(upper_32 downto lower_32)) * signed(inp3_var(upper_32 downto lower_32)));
							product := to_integer(signed(outp_var(upper_64 downto lower_64)));
							if(outp_var (upper_64) /= inp1_var(upper_64)) then
								outp <= (others => '1');
								overflow_64 := std_logic_vector(signed(inp1_var(upper_64 downto lower_64)) - signed(outp_var(upper_64 downto lower_64)));
								if(overflow_64(63) /= inp1_var(upper_64)) then --if 1 negatives - 1 positive or 1 positives - 1 negative (possible overflow)
									outp(upper_64) <= not overflow_64(63);
									outp(upper_64 - 1 downto lower_64) <= (others => overflow_64(63));
								else
									outp(upper_64 downto lower_64) <= overflow_64;
								end if;
							else  
								outp(upper_64 downto lower_64) <= std_logic_vector(signed(inp1_var(upper_64 downto lower_64)) - signed(outp_var(upper_64 downto lower_64)));
							end if;
						end loop;
					when others =>
				end case;
			elsif(instruction(23) = '1') then --R3-Instruction Format
				case instruction(18 downto 15) is
					when "0000" => --NOP
						outp <= (others => '0');
					when "0001" =>--SLHI 
						outp_var := inp1_var;
						for i in 0 to 7 loop
							upper_16 := i*16 + 15;
							lower_16 := i*16;
							upper_4 := i*16 + 3;
							lower_4 := i*16;
							shift_amt := to_integer(unsigned(inp2(upper_4 downto lower_4)));
							for i in 0 to shift_amt - 1 loop
								outp_var(upper_16 downto lower_16) := outp_var(upper_16-1 downto lower_16) & '0';
							end loop;
						end loop;
						outp <= outp_var;
					when "0010" => --AU
						for i in 0 to 3 loop
						    upper_32 := i * 32 + 31;
						    lower_32 := i * 32;						    
						    unsigned_sum := ('0' & unsigned(inp1(upper_32 downto lower_32))) + unsigned(inp2(upper_32 downto lower_32));						    
						    if unsigned_sum(32) = '1' then
						        outp(upper_32 downto lower_32) <= std_logic_vector(to_unsigned((2**32) - 1, 32));
						    else
						        outp(upper_32 downto lower_32) <= std_logic_vector(unsigned_sum(31 downto 0));
						    end if;
						end loop;

					when "0011" => --CNT1H
						for i in 0 to 7 loop
							ones_count := 0;
							upper_16 := i*16 + 15;
							lower_16 := i*16;
							for j in 0 to 15 loop
								if ((inp1(lower_16 + j)) = '1') then
									ones_count := ones_count + 1;
								end if;
							end loop;
							outp(upper_16 downto lower_16) <= std_logic_vector(to_unsigned(ones_count, 16));
						end loop;
					when "0100" => --AHS
						for i in 0 to 7 loop
							upper_16 := i*16 + 15;
							lower_16 := i*16;
							if(inp1_var (upper_16) = inp2_var(upper_16)) then
								outp_var(upper_16 downto lower_16) := std_logic_vector(signed(inp1_var(upper_16 downto lower_16)) + signed(inp2_var(upper_16 downto lower_16)));
								if(outp_var(upper_16) /= inp1_var(upper_16)) then
									outp(upper_16) <= inp1_var(upper_16);
									outp(upper_16 -1 downto lower_16) <= (others => not inp1_var(upper_16));
								else
									outp(upper_16 downto lower_16) <= outp_var(upper_16 downto lower_16);
								end if;
							else
								outp(upper_16 downto lower_16) <= std_logic_vector(signed(inp1_var(upper_16 downto lower_16)) + signed(inp2_var(upper_16 downto lower_16)));
							end if;
						end loop;
					when "0101" => --AND
						outp(127 downto 0) <= inp1(127 downto 0) and inp2(127 downto 0);
					when "0110" => --BCW
						for i in 0 to 3 loop
							upper_32 := i*32 + 31;
							lower_32 := i*32;
							outp(upper_32 downto lower_32) <= inp1(31 downto 0);
						end loop;
					when "0111" => --MAXWS
						for i in 0 to 3 loop
							upper_32 := i*32 + 31;
							lower_32 := i*32;
							if(signed(inp1(upper_32 downto lower_32)) > signed(inp2(upper_32 downto lower_32))) then
								outp(upper_32 downto lower_32) <= inp1(upper_32 downto lower_32);
							else
								outp(upper_32 downto lower_32) <= inp2(upper_32 downto lower_32);
							end if;
						end loop;
					when "1000" => --MINWS
						for i in 0 to 3 loop
							upper_32 := i*32 + 31;
							lower_32 := i*32;
							if(signed(inp1(upper_32 downto lower_32)) < signed(inp2(upper_32 downto lower_32))) then
								outp(upper_32 downto lower_32) <= inp1(upper_32 downto lower_32);
							else
								outp(upper_32 downto lower_32) <= inp2(upper_32 downto lower_32);
							end if;
						end loop;
					when "1001" => --MLHU
						for i in 0 to 3 loop
							upper_32 := i*32 + 31;
							lower_32 := i*32;
							upper_16 := i*32 + 15;
							lower_16 := i*32;
							outp(upper_32 downto lower_32) <= std_logic_vector(unsigned(inp1(upper_16 downto lower_16)) * unsigned(inp2(upper_16 downto lower_16)));
						end loop;
					when "1010" => --MLHCU **LITTLE UNSURE ABOUT THIS ONE IDK WHAT ASKING
						for i in 0 to 3 loop
							upper_32 := i*32 + 31;
							lower_32 := i*32;
							upper_16 := i*32 + 15;
							lower_16 := i*32;
							outp(upper_32 downto lower_32) <= std_logic_vector(unsigned(inp1(upper_16 downto lower_16)) * ("00000000000" & unsigned(instruction(14 downto 10))));
						end loop;
					when "1011" => --OR
						outp(127 downto 0) <= inp1(127 downto 0) or inp2(127 downto 0);
					when "1100" => --CLZH
						for i in 0 to 7 loop
							upper_16 := i*16 + 15;
							lower_16 := i*16;
							leading_zeros := 0;
							for j in 15 downto 0 loop
								exit when inp1(lower_16 + j) = '1';
								leading_zeros := leading_zeros + 1;
							end loop;
							outp(upper_16 downto lower_16) <= std_logic_vector(to_unsigned(leading_zeros, 16));
						end loop;
					when "1101" => --RLH
						outp_var := inp1;
						for i in 0 to 7 loop
							upper_16 := i*16 + 15;
							lower_16 := i*16;
							upper_4 := i*16 + 3;
							lower_4 := i*16;
							shift_amt := to_integer(unsigned(inp2(upper_4 downto lower_4)));
							for i in 0 to shift_amt - 1 loop
								outp_var(upper_16 downto lower_16) := outp_var(upper_16 -1 downto lower_16) & outp_var(upper_16);
							end loop;	
						end loop;
						outp <= outp_var;
					when "1110" => --SFWU
						 for i in 0 to 3 loop
						    upper_32 := i * 32 + 31;
						    lower_32 := i * 32;						    
						    unsigned_diff := unsigned(('0' & inp2(upper_32 downto lower_32))) - unsigned(inp1(upper_32 downto lower_32));
						    if unsigned_diff(32) = '1' then
						        outp(upper_32 downto lower_32) <= std_logic_vector(to_unsigned(0, 32));  -- Set to 0 on underflow
						    else
						        outp(upper_32 downto lower_32) <= std_logic_vector(unsigned_diff(31 downto 0));
						    end if;
						end loop;

					when "1111" => --SFHS
						for i in 0 to 7 loop
							upper_16 := i*16 + 15;
							lower_16 := i*16;
							if(inp1_var (upper_16) /= inp2_var(upper_16)) then
								outp_var(upper_16 downto lower_16) := std_logic_vector(signed(inp2_var(upper_16 downto lower_16)) - signed(inp1_var(upper_16 downto lower_16)));
								if(outp_var(upper_16) /= inp2_var(upper_16)) then
									outp(upper_16) <= not outp_var(upper_16);
									outp(upper_16 -1 downto lower_16) <= (others => outp_var(upper_16));
								else
									outp(upper_16 downto lower_16) <= outp_var(upper_16 downto lower_16);
								end if;
							else
								outp(upper_16 downto lower_16) <= std_logic_vector(signed(inp2_var(upper_16 downto lower_16)) - signed(inp1_var(upper_16 downto lower_16)));
							end if;
						end loop;
					when others =>
				end case;
			end if;
		end if;

	end process;

	-- Enter your statements here --
   
	
	
end behavior;
