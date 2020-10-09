----------------------------------------------------------------------------------
-- Instruction Decoder
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Instruction_Decoder is
    Port ( external_input       : in STD_LOGIC_VECTOR (15 downto 0);        --16-bit external input data
           store_input          : in STD_LOGIC_VECTOR (15 downto 0);        --16-bit value from output register
           instruction          : in STD_LOGIC_VECTOR (27 downto 0);        --28-bit instruction coming from ROM
           clock                : in STD_LOGIC;                             --clock
           external_data_enable : out STD_LOGIC;                            --enable data input from external source
           input                : out STD_LOGIC_VECTOR (15 downto 0);       --16-bit output value to input register
           write_enable         : out STD_LOGIC;                            --enable input register to write new value
           slct                 : out STD_LOGIC_VECTOR (3 downto 0);        --4-bit register select
           alu_enable           : out STD_LOGIC;                            --enable ALU
           alu_op               : out STD_LOGIC_VECTOR (7 downto 0);        --8-bit operation for ALU
           store_enable         : out STD_LOGIC;                            --enable result of ALU to get stored in output register
           clock_enable         : out STD_LOGIC;                            --enable program counter to increment address
           load_address         : out STD_LOGIC;                            --load new address into program counter
           new_address          : out STD_LOGIC_VECTOR (7 downto 0));       --8-bit new address for program counter
end Instruction_Decoder;


architecture Behavioral of Instruction_Decoder is

--splitting the input instruction into 4 separate signals

signal sig_op   : STD_LOGIC_VECTOR (27 downto 20);      --upper bits of instruction are the operation bits
signal sig_data : STD_LOGIC_VECTOR (19 downto 4);       --middle bits of instruction are the data bits
signal sig_reg  : STD_LOGIC_VECTOR (3 downto 0);        --lower bits of instruction are the register bits
signal sig_address : STD_LOGIC_VECTOR (11 downto 4);    --portion of the middle bits used for loading new address to program counter

begin

--assigning instruction bits to different signals

sig_op <= instruction (27 downto 20);
sig_data <= instruction (19 downto 4);
sig_reg <= instruction (3 downto 0);
sig_address <= instruction (11 downto 4);

process(clock)
begin

    --on a rising edge clock, set the bits accordingly
    --and assign the sig op to the alu op

    if(clock'event and clock = '1') then
        alu_enable <= '0';
        store_enable <= '0';
        write_enable <= '0';
        clock_enable <= '1';
        load_address <= '0';
        alu_op <= sig_op;
       
       --for the following ALU operations, enable the ALU
       
        case sig_op is
        when "00000001" => alu_enable <= '1'; 
        when "00000010" => alu_enable <= '1';
        when "00000011" => alu_enable <= '1';
        when "00000100" => alu_enable <= '1';
        when "00000101" => alu_enable <= '1';
        when "00000110" => alu_enable <= '1';
        when "00000111" => alu_enable <= '1';
        when "00001000" => alu_enable <= '1';
        when "00001001" => alu_enable <= '1';
        when "00001010" => alu_enable <= '1';
        when "00001011" => alu_enable <= '1';
        when "00010000" => alu_enable <= '1';
        when "00010001" => alu_enable <= '1';
        when "00010010" => alu_enable <= '1';
        when "00010011" => alu_enable <= '1';
        when "00010100" => alu_enable <= '1';
        when "00010101" => alu_enable <= '1';
        when "00010110" => alu_enable <= '1';
        when "00010111" => alu_enable <= '1';
        when others     => alu_enable <= '0';
        end case;
       
        
        --if the operation is to store, store
        --the store_input value to the register
        --that is assigned using the select value.
        --enable the store_enable and write_enable bits
        
        if sig_op = "00011110" then     --Store
        slct <= sig_reg;
        input <= store_input;
        store_enable <= '1';
        write_enable <= '1';      
        end if;
        
        
        --if the operation is to load from ROM,
        --assign the input to the data signal
        --and store to the correct register.
        --enable the write enable bit
        
        if sig_op = "00011001" then     --Load ROM
        slct <= sig_reg;
        input <= sig_data;
        write_enable <= '1';
        end if;
        
        
        --if the operation is to load from extneral data,
        --assign the input to the external data input
        --and store in the correct register.
        --enable the external data enable bit to be able
        --to read from the external data source.
        --enable the write enable bit
        
        if sig_op = "00011010" then     --Load external data
        slct <= sig_reg;
        external_data_enable <= '1';
        input <= external_input;
        write_enable <= '1';
        end if;
        
        
        --if the operation is to jump, set the
        --new address from the data in the 
        --signal address.
        --enable the load address bit
        
        if sig_op = "00100000" then     --Jump
        new_address <= sig_address;
        load_address <= '1';
        end if;
        
    end if;      
end process;
end Behavioral;