library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_Top is
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
end ALU_Top;

architecture Behavioral of ALU_Top is
    -- Declare internal signals here.
begin
    u_ALUControl : entity work.ALUControl
        port map (
            opcode => opcode,
            funct3 => funct3,
            funct7 => funct7,
            Op_Sel => Op_Sel
        );

    u_ALU_64Bits : entity work.ALU_64Bits
        port map (
            Reg_A => Reg_A,
            Reg_B => Reg_B,
            Op_Sel => Op_Sel,
            Carry_In => Carry_In,
            ALU_Out => ALU_Out,
            Carry_Out => Carry_Out
        );
end Behavioral;
