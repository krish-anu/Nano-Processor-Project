-- Company:
-- Engineer: 
-- Create Date: 
-- Design Name: 
-- Module Name: TB_RCA_3 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description:  
-- Dependencies:  --  -- Revision: 
-- Revision 0.01 - File Created -- Additional Comments: --  ---------------------------------------------------------------------------------- 
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; -- Uncomment the following library declaration if using -- arithmetic functions with Signed or Unsigned values --use IEEE.NUMERIC_STD.ALL; -- Uncomment the following library declaration if instantiating -- any Xilinx leaf cells in this code. --library UNISIM; --use UNISIM.VComponents.all; 

entity TB_RCA3 is
 --  Port ( ); 
end TB_RCA3; 

architecture Behavioral of TB_RCA3 is 


  signal A0, A1, A2 : STD_LOGIC;  -- 3-bit input A
    signal B0, B1, B2 : STD_LOGIC;  -- 3-bit input B
    signal C_in : STD_LOGIC;            -- Carry-in input
    signal S0, S1, S2 : STD_LOGIC;  -- 3-bit sum output
    signal C_out : STD_LOGIC;  

begin 
UUT: entity work.RCA_3 
PORT MAP( 
A0 => A0, 
A1 =>A1, 
A2 =>A2, 
B0 =>B0, 
B1=>B1, 
B2 =>B2, 
C_in => C_in, 
S0 => S0, 
S1 =>S1, 
S2 => S2, 
C_out =>C_out 
); 
process 
begin 
A0 <= '0'; 
A1 <= '1'; 
A2 <= '1'; 
B0 <= '0'; 
B1 <= '1'; 
B2 <= '1'; 
C_in <= '0'; 
WAIT FOR 100 ns; 
A0 <= '1'; 
A1 <= '0'; 
A2 <= '1'; 
B0 <= '0'; 
B1 <= '1'; 
B2 <= '0'; 
C_in <= '0'; 
WAIT FOR 100 ns; 
A0 <= '0'; 
A1 <= '1'; 
A2 <= '0'; 
B0 <= '1'; 
B1 <= '0'; 
B2 <= '1'; 
C_in <= '0'; 
WAIT FOR 100 ns; 
A0 <= '0'; 
A1 <= '1'; 
A2 <= '1'; 
B0 <= '1'; 
B1 <= '1'; 
B2 <= '1'; 
C_in <= '0'; 
WAIT FOR 100 ns; 
A0 <= '0'; 
A1 <= '0'; 
A2 <='0'; 
B0 <= '1'; 
B1 <= '1'; 
B2 <= '1'; 
C_in <= '0'; 
WAIT FOR 100 ns; 
A0 <= '0'; 
A1 <= '1'; 
A2 <= '0'; 
B0 <= '1'; 
B1 <= '0'; 
B2 <= '1'; 
C_in <= '0'; 
WAIT FOR 100 NS; 
A0 <= '0'; 
A1 <= '1'; 
A2 <='0'; 
B0 <= '0'; 
B1 <= '0'; 
B2 <= '0'; 
C_in <= '0'; 
WAIT FOR 100 ns; 
A0 <= '0'; 
A1 <= '1'; 
A2 <= '1'; 
B0 <= '1'; 
B1 <= '1'; 
B2 <= '1'; 
C_in <= '0'; 
wait for 100 ns;
WAIT; 
end process; 
end Behavioral;
