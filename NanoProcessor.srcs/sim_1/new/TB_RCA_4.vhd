----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.05.2025 20:01:21
-- Design Name: 
-- Module Name: TB_RCA_4 - Behavioral
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

entity TB_RCA_4 is
--  Port ( );
end TB_RCA_4;

architecture Behavioral of TB_RCA_4 is
component RCA_4
Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
    B : in STD_LOGIC_VECTOR (3 downto 0);
    M : in STD_LOGIC;
    S : out STD_LOGIC_VECTOR (3 downto 0);
    Overflow : out STD_LOGIC;
    Zero : out STD_LOGIC);
end component;
signal A,B,S : std_logic_vector (3 downto 0);
signal M,Overflow,Zero : std_logic;
begin
    UUT : RCA_4 port map (
        A => A,
        B => B,
        M => M,
        S => S,
        Overflow => Overflow,
        Zero => Zero);
process

begin
    M <= '0';
    A <= "0011";
    B <= "0001";
    wait for 100 ns;
    A <= "0000";
    B <= "0000";
    wait for 100 ns;

    A <= "0101";
    B <= "0100";
    wait for 100 ns;
    M <= '1';
    B <= "0111";
    A <= "0001";
    wait for 100 ns;
    M <= '0';
    A <= "0111";
    B <= "0001";
    wait for 100 ns;
    A <= "1111";
    B <= "0001";
    wait for 100 ns;
    M <= '1';
    A <= "0111";
    B <= "0111";
   
    wait for 100 ns;

    A <= "0101";
    B <= "0100";
    wait for 100 ns;
    A <= "1101";
    B <= "1001";
    wait for 100 ns;
end process;


end Behavioral;
