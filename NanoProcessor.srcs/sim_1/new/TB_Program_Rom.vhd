----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.05.2025 18:23:07
-- Design Name: 
-- Module Name: TB_Program_Rom - Behavioral
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

entity TB_Program_Rom is
--  Port ( );
end TB_Program_Rom;

architecture Behavioral of TB_Program_Rom is

component Program_Rom
port( 
    MemorySel : in STD_LOGIC_VECTOR(2 downto 0);
    Instruction : out STD_LOGIC_VECTOR(11 downto 0));
end component;
signal MemorySel: std_logic_vector(2 downto 0);
signal instruction: std_logic_vector(11 downto 0);    
    

begin
uut: program_rom port map(
memorysel=>memorysel,
instruction=>instruction);
process
begin
memorysel<="000";
wait for 100 ns;
memorysel<="001";
wait for 100 ns;
memorysel<="010";
wait for 100 ns;
memorysel<="011";
wait for 100 ns;
memorysel<="100";
wait for 100 ns;
memorysel<="101";
wait for 100 ns;
memorysel<="110";
wait for 100 ns;
memorysel<="111";
wait;

end process;
end Behavioral;
