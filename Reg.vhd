----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2025 01:45:19 PM
-- Design Name: 
-- Module Name: Reg - Behavioral
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

entity Reg is
    Port (
        Reg_in : in STD_LOGIC_VECTOR (3 downto 0);
        Enable : in STD_LOGIC;
        Reset : in STD_LOGIC;
        Clk : in STD_LOGIC;
        Reg_out : out STD_LOGIC_VECTOR (3 downto 0)
    );
end Reg;

architecture Behavioral of Reg is
    signal reg_data : STD_LOGIC_VECTOR (3 downto 0) := "0000";

begin
    process (Clk)
    begin
        if rising_edge(Clk) then
            if Reset = '1' then
                reg_data <= "0000"; 
            elsif Enable = '1' then
                reg_data <= Reg_in; 
            end if;
        end if;
    end process;
    Reg_out <= reg_data;
end Behavioral;
