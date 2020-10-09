----------------------------------------------------------------------------------
-- Out Register
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Output_Register is
    Port ( result       : in STD_LOGIC_VECTOR (15 downto 0);        --16-bit result
           store_enable : in STD_LOGIC;                             --enable bit to store result
           clock        : in STD_LOGIC;                             --clock
           store        : out STD_LOGIC_VECTOR (15 downto 0);       --16-bit output to store result
           data_out     : out STD_LOGIC_VECTOR (15 downto 0));      --16-bit external data output
end Output_Register;

architecture Behavioral of Output_Register is

begin

process(clock)
begin

--on a rising edge clock and if the store enable bit is high,
--store the result.
--else, output the result externally 

    if clock = '1' and clock'event then
        if store_enable = '1' then
           store <= result;
        else
           data_out <= result;
        end if;
    end if;

end process;
end Behavioral;