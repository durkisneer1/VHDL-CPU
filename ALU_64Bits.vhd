library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_64Bits is
    port (
        Reg_A : in STD_LOGIC_VECTOR(63 downto 0);
        Reg_B : in STD_LOGIC_VECTOR(63 downto 0);
        Op_Sel : in STD_LOGIC_VECTOR(3 downto 0);
        Carry_In : in STD_LOGIC;
        ALU_Out : out STD_LOGIC_VECTOR(63 downto 0);
        Carry_Out : out STD_LOGIC
    );
end ALU_64Bits;

architecture Behavioral of ALU_64Bits is
begin

process(all)
    variable temp_Sum : unsigned(64 downto 0);
begin
    ALU_Out <= (others => '0');
    Carry_Out <= '0';
    temp_Sum := to_unsigned(0, 65);

    case Op_Sel is
        when "0000" =>
            temp_Sum := ('0' & unsigned(Reg_A)) + ('0' & unsigned(Reg_B)) + (to_unsigned(0, 63) & Carry_In);
        when "0001" =>
            temp_Sum := ('0' & unsigned(Reg_A)) + ('0' & not unsigned(Reg_B)) + 1;
        when "0010" =>
            temp_Sum := ('0' & unsigned(Reg_A)) + 1;
        when "0011" =>
            temp_Sum := ('0' & unsigned(Reg_A)) + not to_unsigned(1, 64) + 1;
        when "0100" =>
            ALU_Out <= Reg_A and Reg_B;
        when "0101" =>
            ALU_Out <= Reg_A or Reg_B;
        when "0110" =>
            ALU_Out <= Reg_A xor Reg_B;
        when "0111" =>
            ALU_Out <= not Reg_A;
        when "1000" =>
            ALU_Out <= std_logic_vector(shift_left(unsigned(Reg_A), to_integer(unsigned(Reg_B(5 downto 0)))));
        when "1001" =>
            ALU_Out <= std_logic_vector(shift_right(unsigned(Reg_A), to_integer(unsigned(Reg_B(5 downto 0)))));
        when "1010" =>
            ALU_Out <= std_logic_vector(shift_right(signed(Reg_A), to_integer(unsigned(Reg_B(5 downto 0)))));
        when "1011" =>
            ALU_Out <= x"0000000000000001" when (Reg_A = Reg_B) else x"0000000000000000";
        when others => null;
    end case;
    
    if unsigned(Op_Sel) < 3 then
        ALU_Out <= std_logic_vector(temp_Sum(63 downto 0));
        Carry_Out <= temp_Sum(64);
    end if;
end process;

end Behavioral;
