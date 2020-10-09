----------------------------------------------------------------------------------
--Program Counter
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Program_Counter is
    Port ( new_Address    : in STD_LOGIC_VECTOR (7 downto 0);                   --8-bit input for loading new address
           load_address   : in STD_LOGIC;                                       --enable bit to load new address
           clock          : in STD_LOGIC;                                       --clock
           clock_enable   : in STD_LOGIC;                                       --enable bit to increment
           output_address : out STD_LOGIC_VECTOR (7 downto 0) := "00000000");   --8-bit output address for the ROM
end Program_Counter;

architecture Behavioral of Program_Counter is

signal sig_increment : std_logic_vector(7 downto 0) := "00000000";              --signal to increment the addresses. initial value of 0

begin

process (clock)
begin

--on a rising edge clock and if the clock enable bit is high,
--if the load address bit is high then set the next address to
--the new_address from the instruction decoder,
--else if the load address bit is low, increment the address

    if clock = '1' and clock'event then
        if clock_enable = '1' then
            if load_address = '1' then
                sig_increment <= new_address;
            else
                sig_increment <= sig_increment + 1;
            end if;
        end if;
    end if;
end process;

output_address <= sig_increment;        --assign the value of the signal to the output address port

end Behavioral;