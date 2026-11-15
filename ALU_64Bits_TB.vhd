library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_64Bits_TB is
end ALU_64Bits_TB;

architecture Behavioral of ALU_64Bits_TB is
    component ALU_64Bits is
        port (
            Reg_A : in STD_LOGIC_VECTOR(63 downto 0);
            Reg_B : in STD_LOGIC_VECTOR(63 downto 0);
            Op_Sel : in STD_LOGIC_VECTOR(3 downto 0);
            Carry_In : in STD_LOGIC;
            ALU_Out : out STD_LOGIC_VECTOR(63 downto 0);
            Carry_Out : out STD_LOGIC
        );
    end component;

    signal Reg_A_sig : STD_LOGIC_VECTOR(63 downto 0) := (others => '0');
    signal Reg_B_sig : STD_LOGIC_VECTOR(63 downto 0) := (others => '0');
    signal Op_Sel_sig : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal Carry_In_sig : STD_LOGIC := '0';
    signal ALU_Out_sig : STD_LOGIC_VECTOR(63 downto 0);
    signal Carry_Out_sig : STD_LOGIC;
begin
    uut : ALU_64Bits
        port map (
            Reg_A => Reg_A_sig,
            Reg_B => Reg_B_sig,
            Op_Sel => Op_Sel_sig,
            Carry_In => Carry_In_sig,
            ALU_Out => ALU_Out_sig,
            Carry_Out => Carry_Out_sig
        );

    stimulus : process
    begin
        -- TC1: ADD  5 + 3 = 8
        Op_Sel_sig   <= "0000";
        Carry_In_sig <= '0';
        Reg_A_sig    <= x"0000000000000005";
        Reg_B_sig    <= x"0000000000000003";
        wait for 10 ns;

        -- TC2: ADD  7FFFFFFFFFFFFFFF + 0 + Carry_In(1) = 8000000000000000
        Op_Sel_sig   <= "0000";
        Carry_In_sig <= '1';
        Reg_A_sig    <= x"7FFFFFFFFFFFFFFF";
        Reg_B_sig    <= x"0000000000000000";
        wait for 10 ns;

        -- TC3: SUB  3 - 5 = -2 = FFFFFFFFFFFFFFFE (borrow -> Carry_Out = 0)
        Op_Sel_sig   <= "0001";
        Carry_In_sig <= '0';
        Reg_A_sig    <= x"0000000000000003";
        Reg_B_sig    <= x"0000000000000005";
        wait for 10 ns;

        -- TC4: AND  FFFFFFFF00000000 and 0F0F0F0F0F0F0F0F = 0F0F0F0F00000000
        Op_Sel_sig   <= "0100";
        Carry_In_sig <= '0';
        Reg_A_sig    <= x"FFFFFFFF00000000";
        Reg_B_sig    <= x"0F0F0F0F0F0F0F0F";
        wait for 10 ns;

        -- TC5: OR   FFFFFFFF00000000 or 00000000FFFFFFFF = FFFFFFFFFFFFFFFF
        Op_Sel_sig   <= "0101";
        Carry_In_sig <= '0';
        Reg_A_sig    <= x"FFFFFFFF00000000";
        Reg_B_sig    <= x"00000000FFFFFFFF";
        wait for 10 ns;

        -- TC6: SRA  FFFFFFFFFFFFFFF0 >>> 4 = FFFFFFFFFFFFFFFF (sign-fill)
        Op_Sel_sig   <= "1010";
        Carry_In_sig <= '0';
        Reg_A_sig    <= x"FFFFFFFFFFFFFFF0";
        Reg_B_sig    <= x"0000000000000004";
        wait for 10 ns;

        -- TC7: SRL  FFFFFFFFFFFFFFF0 >> 4 = 0FFFFFFFFFFFFFFF (zero-fill)
        Op_Sel_sig   <= "1001";
        Carry_In_sig <= '0';
        Reg_A_sig    <= x"FFFFFFFFFFFFFFF0";
        Reg_B_sig    <= x"0000000000000004";
        wait for 10 ns;

        -- TC8: SLL  1 << 63 (B(5:0) = 111111) = 8000000000000000
        Op_Sel_sig   <= "1000";
        Carry_In_sig <= '0';
        Reg_A_sig    <= x"0000000000000001";
        Reg_B_sig    <= x"000000000000003F";
        wait for 10 ns;

        -- TC9: XOR  AAAAAAAAAAAAAAAA xor 5555555555555555 = FFFFFFFFFFFFFFFF
        Op_Sel_sig   <= "0110";
        Carry_In_sig <= '0';
        Reg_A_sig    <= x"AAAAAAAAAAAAAAAA";
        Reg_B_sig    <= x"5555555555555555";
        wait for 10 ns;

        -- TC10: ADDI  00000000000000FF + 1 = 0000000000000100
        Op_Sel_sig   <= "0010";
        Carry_In_sig <= '0';
        Reg_A_sig    <= x"00000000000000FF";
        Reg_B_sig    <= x"0000000000000000";   -- don't care
        wait for 10 ns;

        -- TC11: SUBI  0 - 1 = FFFFFFFFFFFFFFFF (borrow -> Carry_Out = 0)
        Op_Sel_sig   <= "0011";
        Carry_In_sig <= '0';
        Reg_A_sig    <= x"0000000000000000";
        Reg_B_sig    <= x"0000000000000000";   -- don't care
        wait for 10 ns;

        -- TC12: NOT  not 00000000000000FF = FFFFFFFFFFFFFF00
        Op_Sel_sig   <= "0111";
        Carry_In_sig <= '0';
        Reg_A_sig    <= x"00000000000000FF";
        Reg_B_sig    <= x"0000000000000000";   -- don't care
        wait for 10 ns;

        -- TC13: SEQ  DEADBEEFCAFEBABE = DEADBEEFCAFEBABE -> 0000000000000001
        Op_Sel_sig   <= "1011";
        Carry_In_sig <= '0';
        Reg_A_sig    <= x"DEADBEEFCAFEBABE";
        Reg_B_sig    <= x"DEADBEEFCAFEBABE";
        wait for 10 ns;

        wait;
    end process stimulus;
end Behavioral;
