----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/04/2025 02:51:47 PM
-- Design Name: 
-- Module Name: TB_Decorder_3_to_8 - Behavioral
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

entity TB_Decoder_3_to_8 is
--  Port ( );
end TB_Decoder_3_to_8;

architecture Behavioral of TB_Decoder_3_to_8 is
  signal I : STD_LOGIC_VECTOR (2 downto 0);  -- 3-bit input
  signal EN : STD_LOGIC;                     -- Enable signal
  signal Y : STD_LOGIC_VECTOR (7 downto 0);  -- 8-bit output


begin
     uut: entity work.Decoder_3_to_8
     port map (
          I => I,
          EN => EN,
          Y => Y
      );
     process
     begin
             -- My Index Number: 230090E
             -- My Index Number (Binary): 111000001011001010
             -- Derived input test cases: 010 ? 001 ? 011 ? 000 ? 111
     
             -- Test case 1: Enable = 1, Input = 010 (Expect Y(2) = 1)
             EN <= '1';
             I <= "010"; 
             wait for 100 ns;
     
             -- Test case 2: Enable = 1, Input = 001 (Expect Y(1) = 1)
             I <= "001"; 
             wait for 100 ns;
     
             -- Test case 3: Enable = 1, Input = 011 (Expect Y(3) = 1)
             I <= "011"; 
             wait for 100 ns;
     
             -- Test case 4: Enable = 1, Input = 000 (Expect Y(0) = 1)
             I <= "000"; 
             wait for 100 ns;
     
             -- Test case 5: Enable = 1, Input = 111 (Expect Y(7) = 1)
             I <= "111"; 
             wait for 100 ns;
     
             -- Test case 6: Enable = 0, Input = 010 (Decoder disabled, expect Y = "00000000")
             EN <= '0';
             I <= "010"; 
             wait for 100 ns;
     
             -- End simulation
             wait;
         end process;
end Behavioral;
