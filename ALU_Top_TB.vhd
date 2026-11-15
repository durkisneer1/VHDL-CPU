library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_Top_TB is
end ALU_Top_TB;

architecture Behavioral of ALU_Top_TB is
    component ALU_Top is
        port (
            Reg_A : in STD_LOGIC_VECTOR(63 downto 0);
            Reg_B : in STD_LOGIC_VECTOR(63 downto 0);
            Carry_In : in STD_LOGIC;
            opcode : in STD_LOGIC_VECTOR(6 downto 0);
            funct3 : in STD_LOGIC_VECTOR(2 downto 0);
            funct7 : in STD_LOGIC_VECTOR(6 downto 0);
            Op_Sel : out STD_LOGIC_VECTOR(3 downto 0);
            ALU_Out : out STD_LOGIC_VECTOR(63 downto 0);
            Carry_Out : out STD_LOGIC
        );
    end component;

    signal Reg_A_sig : STD_LOGIC_VECTOR(63 downto 0) := (others => '0');
    signal Reg_B_sig : STD_LOGIC_VECTOR(63 downto 0) := (others => '0');
    signal Carry_In_sig : STD_LOGIC := '0';
    signal opcode_sig : STD_LOGIC_VECTOR(6 downto 0) := (others => '0');
    signal funct3_sig : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal funct7_sig : STD_LOGIC_VECTOR(6 downto 0) := (others => '0');
    signal Op_Sel_sig : STD_LOGIC_VECTOR(3 downto 0);
    signal ALU_Out_sig : STD_LOGIC_VECTOR(63 downto 0);
    signal Carry_Out_sig : STD_LOGIC;
begin
    uut : ALU_Top
        port map (
            Reg_A => Reg_A_sig,
            Reg_B => Reg_B_sig,
            Carry_In => Carry_In_sig,
            opcode => opcode_sig,
            funct3 => funct3_sig,
            funct7 => funct7_sig,
            Op_Sel => Op_Sel_sig,
            ALU_Out => ALU_Out_sig,
            Carry_Out => Carry_Out_sig
        );

    stimulus : process
    begin
        -- TC 1
        Reg_A_sig <= x"000000000000000A";
        Reg_B_sig <= x"0000000000000007";
        Carry_In_sig <= '0';
        opcode_sig <= "0110011";
        funct3_sig <= "000";
        funct7_sig <= "0000000";
        wait for 10 ns;
        
        -- TC 2
        Reg_A_sig <= x"0000000000000014";
        Reg_B_sig <= x"0000000000000008";
        Carry_In_sig <= '0';
        opcode_sig <= "0110011";
        funct3_sig <= "000";
        funct7_sig <= "0100000";
        wait for 10 ns;
        
        -- TC 3
        Reg_A_sig <= x"FF00FF00FF00FF00";
        Reg_B_sig <= x"0FF00FF00FF00FF0";
        Carry_In_sig <= '0';
        opcode_sig <= "0110011";
        funct3_sig <= "111";
        funct7_sig <= "0000000";
        wait for 10 ns;
        
        -- TC 4
        Reg_A_sig <= x"FFFFFFFFFFFFFFF0";
        Reg_B_sig <= x"0000000000000004";
        Carry_In_sig <= '0';
        opcode_sig <= "0110011";
        funct3_sig <= "101";
        funct7_sig <= "0000000";
        wait for 10 ns;
        
        -- TC 5
        Reg_A_sig <= x"FFFFFFFFFFFFFFF0";
        Reg_B_sig <= x"0000000000000004";
        Carry_In_sig <= '0';
        opcode_sig <= "0110011";
        funct3_sig <= "101";
        funct7_sig <= "0100000";
        wait for 10 ns;
        
        -- TC 6
        Reg_A_sig <= x"0000000000000100";
        Reg_B_sig <= x"0000000000000001";
        Carry_In_sig <= '0';
        opcode_sig <= "0010011";
        funct3_sig <= "000";
        funct7_sig <= "0000000";
        wait for 10 ns;
        
        wait;
    end process stimulus;
end Behavioral;
