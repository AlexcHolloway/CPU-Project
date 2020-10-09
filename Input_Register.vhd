----------------------------------------------------------------------------------
--Input register
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Input_Register is
    Port ( input     : in STD_LOGIC_VECTOR (15 downto 0);           --16-bit input data
           slct      : in STD_LOGIC_VECTOR (3 downto 0);            --4-bit register select
           enable    : in STD_LOGIC;                                --enable bit to store to register
           clock     : in STD_LOGIC;                                --clock
           a         : inout STD_LOGIC_VECTOR (15 downto 0);        --register a
           b         : inout STD_LOGIC_VECTOR (15 downto 0);        --register b
           c         : inout STD_LOGIC_VECTOR (15 downto 0);        --register c
           d         : inout STD_LOGIC_VECTOR (15 downto 0);        --register d
           reg_1_out : out STD_LOGIC_VECTOR (15 downto 0);          --register 1 output to ALU
           reg_2_out : out STD_LOGIC_VECTOR (15 downto 0));         --register 2 output to ALU
end Input_Register;

architecture Behavioral of Input_Register is

begin

process(clock,enable)

begin

    --on a rising edge clock and if the enable bit is high,
    --store the inputted data into the selected register

    if(clock'event and clock = '1') then      
        if enable = '1' then
            case slct(1 downto 0) is
            when "00" => a <= input;        --store inputted data into register a when select is "0000"
            when "01" => b <= input;        --store inputted data into register b when select is "0001"        
            when "10" => c <= input;        --store inputted data into register c when select is "0010"
            when "11" => d <= input;        --store inputted data into register d when select is "0011"
            when others => NULL;
            end case;
        
        else
             
             --on a rising edge clock and if the enable bit is low,
             --output the values stored in the selected register to 
             --outputs reg_1 and reg_2
             
             case slct(3 downto 0) is
             when "0000" =>
             reg_1_out <= a;
             reg_2_out <= a;
             
             when "0001" =>
             reg_1_out <= b;
             reg_2_out <= a;
             
             when "0010" =>
             reg_1_out <= c;
             reg_2_out <= a;
             
             when "0011" =>
             reg_1_out <= d;
             reg_2_out <= a;
             
             when "0100" =>
             reg_1_out <= a;
             reg_2_out <= b;
             
             when "0101" =>
             reg_1_out <= b;
             reg_2_out <= b;
             
             when "0110" =>
             reg_1_out <= c;
             reg_2_out <= b;
             
             when "0111" =>
             reg_1_out <= d;
             reg_2_out <= b;
             
             when "1000" =>
             reg_1_out <= a;
             reg_2_out <= c;
             
             when "1001" =>
             reg_1_out <= b;
             reg_2_out <= c;
             
             when "1010" =>
             reg_1_out <= c;
             reg_2_out <= c;
             
             when "1011" =>
             reg_1_out <= d;
             reg_2_out <= c;
             
             when "1100" =>
             reg_1_out <= a;
             reg_2_out <= d;
             
             when "1101" =>
             reg_1_out <= b;
             reg_2_out <= d;
             
             when "1110" =>
             reg_1_out <= c;
             reg_2_out <= d;
             
             when "1111" =>
             reg_1_out <= d;
             reg_2_out <= d;
             
             when others => NULL;      
            end case;
        end if;
   end if;
            
end process;
end Behavioral;