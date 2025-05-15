----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/04/2025 02:44:48 PM
-- Design Name: 
-- Module Name: Decorder_3_to_8 - Behavioral
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

entity Decorder_3_to_8 is
    Port ( I : in STD_LOGIC_VECTOR (2 downto 0);
           EN : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (7 downto 0));
end Decorder_3_to_8;

architecture Behavioral of Decorder_3_to_8 is
      component Decorder_2_to_4
        port(I:in STD_LOGIC_VECTOR(1 downto 0);
            EN:in STD_LOGIC;
            Y: out STD_LOGIC_VECTOR(3 downto 0)
            );
      end component;
      signal IO, I1 : STD_LOGIC_VECTOR (1 downto 0); 
      signal Y0, Y1 : STD_LOGIC_VECTOR (3 downto 0); 
      signal en0, en1 : STD_LOGIC;  
  
  begin
  
     
      Decorder_2_to_4_0: Decorder_2_to_4 
          port map (I => IO, EN => en0, Y => Y0);
  
    
      Decorder_2_to_4_1: Decorder_2_to_4 
          port map (I => I1, EN => en1, Y => Y1);
  

      en0 <= NOT(I(2)) AND EN;  
      en1 <= I(2) AND EN;     
  

      IO <= I(1 downto 0);
      I1 <= I(1 downto 0);
  
      Y(3 downto 0) <= Y0;  
      Y(7 downto 4) <= Y1; 
 end Behavioral;
  

