----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2025 05:44:11
-- Design Name: 
-- Module Name: Instruction_decoder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Instruction_decoder is
   Port ( Instruction_bus : in STD_LOGIC_VECTOR (11 downto 0); -- input from  program rom
Reg_Value : in STD_LOGIC_VECTOR (3 downto 0); -- to check if a register has value zero stored in it
-- reg which we check is given with JZR instruction
Reg_a_address : out STD_LOGIC_VECTOR (2 downto 0); -- selecting input for AU via 8 way 2 bit mux
Reg_b_address : out STD_LOGIC_VECTOR (2 downto 0); -- selecting input for AU via 8 way 2 bit mux
Reg_select : out STD_LOGIC_VECTOR (2 downto 0); -- to select Reg from reg bank to write to a reg
AddSub_select : out STD_LOGIC; -- selecting Add or Subtract (if neg instruction sub will be selceted)
Jump_flag : out STD_LOGIC; -- to jump to another instruction in PC(Program counter),
-- by checking Reg_Value and this output connected to 2 way 3 bit MUX selector (PC area)
Jump_address : out STD_LOGIC_VECTOR (2 downto 0); -- which instruction to execute, this output connected to 2 way 3 bit MUX

Load_select : out STD_LOGIC; -- select between AU output and immediate value (connected to 2 way 4 bit MUX)
Immediate_value : out STD_LOGIC_VECTOR (3 downto 0)); -- immediate value given for movi (a number) or JZR (a address in program rom)
end Instruction_decoder;

architecture Behavioral of Instruction_decoder is

component Decoder_2_to_4
port( I : in STD_LOGIC_VECTOR (1 downto 0);
    EN : in STD_LOGIC;
    Y : out STD_LOGIC_VECTOR (3 downto 0));
end component;
SIGNAL ADD, NEG, MOVI, JZR :STD_LOGIC;
begin
Decoder_2_to_4_0: Decoder_2_to_4
port map( I(0)=>Instruction_bus(10),
    I(1)=>Instruction_bus(11),
    EN=>'1',
    Y(0) => ADD,
    Y(1) => NEG,
    Y(2) => MOVI,
    Y(3) => JZR);
Reg_a_address <= Instruction_bus(9 downto 7);
Reg_b_address <= Instruction_bus(6 downto 4);
Reg_select <= Instruction_bus(9 downto 7);
AddSub_select <= NEG; -- NEG is substracting from zero
Jump_Flag <= JZR AND (NOT (Reg_Value(0) OR Reg_Value(1) OR Reg_Value(2) OR
Reg_Value(3))) ;
Jump_Address <=Instruction_bus(2 downto 0);
Load_select <= MOVI;
Immediate_value <= Instruction_bus(3 downto 0);

end Behavioral;
