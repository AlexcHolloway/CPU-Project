----------------------------------------------------------------------------------
-- ROM
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity ROM is
    Port ( address     : in STD_LOGIC_VECTOR (7 downto 0):= "00000000";     --8-bit address input, initial value of 0
           clock       : in STD_LOGIC;                                      --clock
           instruction : out STD_LOGIC_VECTOR (27 downto 0));               --28-bit instruction output
end ROM;

architecture Behavioral of ROM is

begin

process(address)
begin

    --on a rising edge clock, when the inputted address value changes,
    --set the instruction values accordingly

    if(clock = '1') then
        case address is
        when "00000000" => instruction <= "00000000" & "0000000000000000" & "0000";     --nop
        when "00000001" => instruction <= "00000000" & "0000000000000000" & "0000";     --nop    
        when "00000010" => instruction <= "00011001" & "0000000000000001" & "0000";     --load #1 rega    
        when "00000011" => instruction <= "00000000" & "0000000000000000" & "0000";     --nop   
        when "00000100" => instruction <= "00011001" & "0000000000000010" & "0001";     --load #2 regb
        when "00000101" => instruction <= "00000000" & "0000000000000000" & "0000";     --nop    
        when "00000110" => instruction <= "00010000" & "0000000000000000" & "0100";     --add rega, regb
        when "00000111" => instruction <= "00000000" & "0000000000000000" & "0000";     --nop
        
        when "00001000" => instruction <= "00011110" & "0000000000000000" & "0010";     --store result reg c
        when "00001001" => instruction <= "00000000" & "0000000000000000" & "0000";
        when "00001010" => instruction <= "00000000" & "0000000000000000" & "0000";
        when "00001011" => instruction <= "00000000" & "0000000000000000" & "0000";
        when "00001100" => instruction <= "00000000" & "0000000000000000" & "0000";
        when "00001101" => instruction <= "00000000" & "0000000000000000" & "0000";
        when "00001110" => instruction <= "00000000" & "0000000000000000" & "0000";
        when "00001111" => instruction <= "00000000" & "0000000000000000" & "0000";
        
        when "00010000" => instruction <= "00000000" & "0000000000000000" & "0000";     
        when "00010001" => instruction <= "00000000" & "0000000000000000" & "0000";     
        when "00010010" => instruction <= "00000000" & "0000000000000000" & "0000";     
        when "00010011" => instruction <= "00000000" & "0000000000000000" & "0000";     
        when "00010100" => instruction <= "00000000" & "0000000000000000" & "0000";     
        when "00010101" => instruction <= "00000000" & "0000000000000000" & "0000";     
        when "00010110" => instruction <= "00000000" & "0000000000000000" & "0000";
        when "00010111" => instruction <= "00000000" & "0000000000000000" & "0000";
        
        when "00011000" => instruction <= "00000000" & "0000000000000000" & "0000";
        when "00011001" => instruction <= "00000000" & "0000000000000000" & "0000";
        when "00011010" => instruction <= "00000000" & "0000000000000000" & "0000";
        when "00011011" => instruction <= "00000000" & "0000000000000000" & "0000";
        when "00011100" => instruction <= "00000000" & "0000000000000000" & "0000";
        when "00011101" => instruction <= "00000000" & "0000000000000000" & "0000";
        when "00011110" => instruction <= "00000000" & "0000000000000000" & "0000";
        when "00011111" => instruction <= "00000000" & "0000000000000000" & "0000";
        
        --the remainder of the ROM is empty but can have a total of 256 
        --different instructions
        
        when others     => instruction <= (others => 'X');      --assign the instruction a null value for all other address values
        end case;
    end if;
end process;
end Behavioral;
