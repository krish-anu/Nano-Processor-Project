----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.05.2025 20:42:15
-- Design Name: 
-- Module Name: TB_Instruction_decoder - Behavioral
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

entity TB_Instruction_decoder is
--  Port ( );
end TB_Instruction_decoder;

architecture Behavioral of TB_Instruction_decoder is
component Instruction_Decoder
Port ( Instruction_bus : in STD_LOGIC_VECTOR (11 downto 0);
    Reg_Value : in STD_LOGIC_VECTOR (3 downto 0);
    Reg_a_address : out STD_LOGIC_VECTOR (2 downto 0);
    Reg_b_address : out STD_LOGIC_VECTOR (2 downto 0);
    Reg_select : out STD_LOGIC_VECTOR (2 downto 0);
    AddSub_select : out STD_LOGIC;
    Jump_flag : out STD_LOGIC;
    Jump_address : out STD_LOGIC_VECTOR (2 downto 0);
    Load_select : out STD_LOGIC;
    Immediate_value : out STD_LOGIC_VECTOR (3 downto 0));
end component;
    
SIGNAL Instruction_bus : STD_LOGIC_VECTOR (11 downto 0);
SIGNAL Reg_Value : STD_LOGIC_VECTOR (3 downto 0);
SIGNAL Reg_a_address : STD_LOGIC_VECTOR (2 downto 0);
SIGNAL Reg_b_address : STD_LOGIC_VECTOR (2 downto 0);
SIGNAL Reg_select : STD_LOGIC_VECTOR (2 downto 0);
SIGNAL AddSub_select : STD_LOGIC;
SIGNAL Jump_flag : STD_LOGIC;
SIGNAL Jump_address : STD_LOGIC_VECTOR (2 downto 0);
SIGNAL Load_select : STD_LOGIC;
SIGNAL Immediate_value : STD_LOGIC_VECTOR (3 downto 0);

begin
UUT: Instruction_Decoder PORT MAP(
    Instruction_bus => Instruction_bus,
    Reg_Value => Reg_Value,
    Reg_a_address => Reg_a_address,
    Reg_b_address => Reg_b_address,
    Reg_select => Reg_select,
    AddSub_select => AddSub_select,
    Jump_flag => Jump_flag,
    Jump_address => Jump_address,
    Load_select => Load_select,
    Immediate_value => Immediate_value
);
process
begin
--1
Reg_Value <= "1110";
Instruction_bus <= "101110000000";
wait for 100 ns;
--2
Reg_Value <= "1010";
Instruction_bus <= "101100000011";
wait for 100 ns;
--3
Reg_Value <= "1011";
Instruction_bus <= "101010001111";
wait for 100 ns;
--4
Reg_Value<= "0000"
;
Instruction_bus <= "001111100000";
wait for 100 ns;
--5
Reg_Value <= "1010";
Instruction_bus <= "001101010000";
wait for 100 ns;
--6
Reg_Value <= "1010";
Instruction_bus<="010100000000";
wait for 100 ns;
--7
Reg_Value <= "1011";
Instruction_bus<="111100000111";
wait for 100 ns;
--8
Reg_Value <= "0000";
Instruction_bus<="110000000011";
wait for 100 ns;
--9
Reg_Value <= "1010";
Instruction_bus<="110000000111";
wait for 100 ns;
wait;
end process;

end Behavioral;
