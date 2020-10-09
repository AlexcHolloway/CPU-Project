----------------------------------------------------------------------------------
-- Top Level
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Top_Level is
Port (external_input : in STD_LOGIC_VECTOR (15 downto 0);
      clock          : in STD_LOGIC;
      data_out       : out STD_LOGIC_VECTOR (15 downto 0));
    
end Top_Level;

architecture Behavioral of Top_Level is
	
--Declaring components	

component ALU is
    Port ( reg_1  : in STD_LOGIC_VECTOR (15 downto 0);
           reg_2  : in STD_LOGIC_VECTOR (15 downto 0);
           op     : in STD_LOGIC_VECTOR (7 downto 0);
           enable_alu : in STD_LOGIC;
           clock  : in STD_LOGIC;
           result : out STD_LOGIC_VECTOR (15 downto 0));
end component ALU;


component Input_Register is
    Port ( input : in STD_LOGIC_VECTOR (15 downto 0);    
           slct : in STD_LOGIC_VECTOR (3 downto 0);
           enable : in STD_LOGIC;
           clock : in STD_LOGIC;
           a : inout STD_LOGIC_VECTOR (15 downto 0);
           b : inout STD_LOGIC_VECTOR (15 downto 0);
           c : inout STD_LOGIC_VECTOR (15 downto 0);
           d : inout STD_LOGIC_VECTOR (15 downto 0);    
           reg_1_out : out STD_LOGIC_VECTOR (15 downto 0);
           reg_2_out : out STD_LOGIC_VECTOR (15 downto 0));
end component Input_Register;


component Instruction_Decoder is
    Port ( external_input : in STD_LOGIC_VECTOR (15 downto 0);
           store_input : in STD_LOGIC_VECTOR (15 downto 0);
           instruction : in STD_LOGIC_VECTOR (27 downto 0);
           clock : in STD_LOGIC;
           external_data_enable : out STD_LOGIC;
           input : out STD_LOGIC_VECTOR (15 downto 0);
           write_enable : out STD_LOGIC;
           slct : out STD_LOGIC_VECTOR (3 downto 0);
           alu_enable : out STD_LOGIC;
           alu_op : out STD_LOGIC_VECTOR (7 downto 0);
           store_enable : out STD_LOGIC;
           clock_enable : out STD_LOGIC;
           load_address : out STD_LOGIC;
           new_address : out STD_LOGIC_VECTOR (7 downto 0));
end component Instruction_Decoder;


component Output_Register is
    Port ( result : in STD_LOGIC_VECTOR (15 downto 0);
           store_enable : in STD_LOGIC;
           clock : in STD_LOGIC;
           store : out STD_LOGIC_VECTOR (15 downto 0);
           data_out : out STD_LOGIC_VECTOR (15 downto 0));
end component Output_Register;



component Program_Counter is
    Port ( new_Address : in STD_LOGIC_VECTOR (7 downto 0);
           load_address : in STD_LOGIC;
           clock : in STD_LOGIC;
           clock_enable : in STD_LOGIC;
           output_address : out STD_LOGIC_VECTOR (7 downto 0) := "00000000");
end component Program_Counter;



component ROM is
    Port ( address : in STD_LOGIC_VECTOR (7 downto 0);
           clock : in STD_LOGIC;
           instruction : out STD_LOGIC_VECTOR (27 downto 0));
end component ROM;


--Clock signal
signal clock_sig : STD_LOGIC;


--ALU signals
signal  result_sig_alu :  STD_LOGIC_VECTOR (15 downto 0);

--Input Register signals
signal  ir_reg_1_out_sig :  STD_LOGIC_VECTOR (15 downto 0);
signal  ir_reg_2_out_sig :  STD_LOGIC_VECTOR (15 downto 0);
signal sig_a : STD_LOGIC_VECTOR (15 downto 0);
signal sig_b : STD_LOGIC_VECTOR (15 downto 0);
signal sig_c : STD_LOGIC_VECTOR (15 downto 0);
signal sig_d : STD_LOGIC_VECTOR (15 downto 0);

--Instruction Decoder signals
signal  external_data_enable_sig_insdec  :  STD_LOGIC;
signal  input_sig_insdec  :  STD_LOGIC_VECTOR (15 downto 0);
signal  write_enable_sig_insdec  :  STD_LOGIC;
signal  slct_sig_insdec  :  STD_LOGIC_VECTOR (3 downto 0);
signal  alu_enable_sig_insdec  :  STD_LOGIC;
signal  alu_op_sig_insdec  :  STD_LOGIC_VECTOR (7 downto 0);
signal  store_enable_sig_insdec  :  STD_LOGIC;
signal  clock_enable_sig_insdec  :  STD_LOGIC;
signal  load_address_sig_insdec  :  STD_LOGIC;
signal  new_address_sig_insdec  :  STD_LOGIC_VECTOR (7 downto 0);

--Output Register signals
signal  store_sig_outreg :  STD_LOGIC_VECTOR (15 downto 0);
signal  data_out_sig_outreg :  STD_LOGIC_VECTOR (15 downto 0);


--Program Counter signals
signal  output_address_sig_pc :  STD_LOGIC_VECTOR (7 downto 0) := "00000000";


--ROM signals
signal  instruction_sig_rom :  STD_LOGIC_VECTOR (27 downto 0);



begin

--Assign ports to signals

M1_Input_Register : Input_Register
port map ( input => input_sig_insdec,
           slct => slct_sig_insdec,
           enable => write_enable_sig_insdec,
           clock => clock,
           reg_1_out => ir_reg_1_out_sig,
           reg_2_out => ir_reg_2_out_sig);


M2_ALU : ALU
port map( reg_1 => ir_reg_1_out_sig,
          reg_2 => ir_reg_2_out_sig,
          op => alu_op_sig_insdec,
          clock => clock,
          enable_alu => alu_enable_sig_insdec,
          result => result_sig_alu);



M3_Instuction_Decoder : Instruction_Decoder
port map( external_input => external_input,
          store_input => store_sig_outreg,
          instruction => instruction_sig_rom,
          clock => clock,
          external_data_enable => external_data_enable_sig_insdec,      --fix!
          input => input_sig_insdec,
          write_enable => write_enable_sig_insdec,
          slct => slct_sig_insdec,
          alu_enable => alu_enable_sig_insdec,
          alu_op => alu_op_sig_insdec,
          store_enable => store_enable_sig_insdec,
          clock_enable => clock_enable_sig_insdec,
          load_address => load_address_sig_insdec,
          new_address => new_address_sig_insdec);


M4_Output_Register : Output_Register
port map ( result => result_sig_alu,
           store_enable =>  store_enable_sig_insdec,
           clock => clock,
           store => store_sig_outreg,
           data_out => data_out);


M5_Program_Counter : Program_Counter
port map( new_address => new_address_sig_insdec,
          load_address => load_address_sig_insdec,
          clock => clock,
          clock_enable => clock_enable_sig_insdec,
          output_address => output_address_sig_pc);
          
          
M6_ROM : ROM
port map( address => output_address_sig_pc,
          instruction => instruction_sig_rom,
          clock => clock);          

end Behavioral;