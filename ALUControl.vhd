library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALUControl is
    port (
        opcode : in STD_LOGIC_VECTOR(6 downto 0);
        funct3 : in STD_LOGIC_VECTOR(2 downto 0);
        funct7 : in STD_LOGIC_VECTOR(6 downto 0);
        Op_Sel : out STD_LOGIC_VECTOR(3 downto 0)
    );
end ALUControl;

architecture Behavioral of ALUControl is
    -- Declare internal signals here.
begin
    -- Add your design logic here.
process(all)
    variable funct10 : STD_LOGIC_VECTOR(9 downto 0);
begin
    Op_Sel <= "1111";
    funct10 := funct3 & funct7;

    case opcode is
        when "0010011" =>
            case funct3 is
                when "000" =>
                    Op_Sel <= "0000";
                when others => null;
            end case;
        when "0110011" =>
            case funct10 is
                when "0000000000" =>
                    Op_Sel <= "0000";
                when "1110000000" =>
                    Op_Sel <= "0100";
                when "1100000000" =>
                    Op_Sel <= "0101";
                when "1000000000" =>
                    Op_Sel <= "0110";
                when "0010000000" =>
                    Op_Sel <= "1000";
                when "1010000000" =>
                    Op_Sel <= "1001";
                when "0000100000" =>
                    Op_Sel <= "0001";
                when "1010100000" =>
                    Op_Sel <= "1010";
                when others => null;
            end case;
        when others => null;
    end case;
end process;

end Behavioral;
