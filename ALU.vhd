----------------------------------------------------------------------------------
-- ALU
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity ALU is
    Port ( reg_1      : in STD_LOGIC_VECTOR (15 downto 0);          --16-bit input data
           reg_2      : in STD_LOGIC_VECTOR (15 downto 0);          --16-bit input data
           op         : in STD_LOGIC_VECTOR (7 downto 0);           --8-bit operation code
           enable_alu : in STD_LOGIC;                               --alu enable bit
           clock      : in STD_LOGIC;                               --clock
           result     : out STD_LOGIC_VECTOR (15 downto 0));        --16-bit output data
end ALU;

architecture Behavioral of ALU is

signal sig_reg_1  : STD_LOGIC_VECTOR (15 downto 0);                 --signal for register_1
signal sig_reg_2  : STD_LOGIC_VECTOR (15 downto 0);                 --signal for register_2
signal sig_result : STD_LOGIC_VECTOR (15 downto 0);                 --signal for the result

begin

--assigning register 1 and 2 input to signals
sig_reg_1 <= reg_1;
sig_reg_2 <= reg_2;

process(clock) is

begin

--on a rising edge clock and if the alu enable bit is enabled,
--perform the appropriate task depending on the value of the 
--operation 

if(clock'event and clock = '1') then
    if enable_alu = '1' then
        case op is
        when "00000000" => NULL;                                        --NOP
        when "00000001" => sig_result <= reg_1 + reg_2;                 --R1 + R2
        when "00000010" => sig_result <= reg_1 - reg_2;                 --R1 - R2
        when "00000011" => sig_result <= reg_2 - reg_1;                 --R2 - R1
        when "00000100" => sig_result <= reg_1 + '1';                   --R1 + 1
        when "00000101" => sig_result <= reg_2 + '1';                   --R2 + 1
        when "00000110" => sig_result <= reg_1 - '1';                   --R1 - 1
        when "00000111" => sig_result <= reg_2 - '1';                   --R2 - 1
    
        when "00001000" => sig_result <= '0' & reg_1 (15 downto 1);     --R1 shift right 
        when "00001001" => sig_result <= '0' & reg_2 (15 downto 1);     --R2 shift right
        when "00001010" => sig_result <= reg_1 (14 downto 0) & '0';     --R1 shift left
        when "00001011" => sig_result <= reg_2 (14 downto 0) & '0';     --R2 shift left
        
        when "00001100" => NULL;                                        --NOP
        when "00001101" => NULL;                                        --NOP
        when "00001110" => NULL;                                        --NOP
        when "00001111" => NULL;                                        --NOP
        
        when "00010000" => sig_result <= reg_1 and reg_2;               --R1 AND R2
        when "00010001" => sig_result <= reg_1 nand reg_2;              --R1 NAND R2
        when "00010010" => sig_result <= reg_1;                         --R1 OR R2
        when "00010011" => sig_result <= reg_1 nor reg_2;               --R1 NOR R2
        when "00010100" => sig_result <= reg_1 xor reg_2;               --R1 XOR R2
        when "00010101" => sig_result <= reg_1 xnor reg_2;              --R1 NXOR R2
        when "00010110" => sig_result <= not reg_1;                     --NOT R1
        when "00010111" => sig_result <= not reg_2;                     --NOT R2
        
        when others     => sig_result <= (others => 'X');                --NULL for rest of ops
    
        end case;
        
        --compare values in register 1 and 2
        --if values are the same, output all 1 bits
        --if values are different, output all 0 bits
        
        if op = "00100011" then 
            if reg_1 = reg_2 then
                sig_result <= "1111111111111111";
            else
            sig_result <= "0000000000000000";
            end if;
        end if;
        end if;
        
    end if;    
end process;

result <= sig_result;       --assign the signal result back to the port
end Behavioral;