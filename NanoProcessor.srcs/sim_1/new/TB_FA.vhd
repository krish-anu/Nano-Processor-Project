----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 
-- Design Name: 
-- Module Name: TB_FA - Behavioral
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

entity TB_FA is
--  Port ( );
end TB_FA;

architecture Behavioral of TB_FA is
    component FA 
     port (
      A , B, C_in: in std_logic;
     C_out , S :out std_logic );
 end component;
  
  SIGNAL A,B,C_in :std_logic;
  SIGNAL C_out , S: std_logic;
begin
   UUT: entity work.FA
   
   PORT MAP( 
       A => A,
       B => B,
       C_in => C_in,
       C_out  => c_out,
       S => S );
       
   process 
       begin 
           A <= '0';
           B <= '0';
           C_in <= '0';
           
       WAIT FOR 100 ns;
           A <= '0';
           B <= '0';
           C_in <= '1';

       WAIT FOR 100 ns;
           A <= '0';
           B <= '1';
           C_in <= '0';
           
       WAIT FOR 100 ns;
           A<= '0';
           B<= '1';
           C_in <= '1';
               
       WAIT FOR 100 ns;
           A <= '1';
           B <= '0';
           C_in <= '0';  
                       
       WAIT FOR 100 ns;
           A <= '1';
           B<= '0';
           C_in <= '1';       

       WAIT FOR 100 ns;
           A <= '1';
           B <= '1';
           C_in <= '0';
           
       WAIT FOR 100 ns;
           A <= '1';
           B <= '1';
           C_in <= '1';
           
        WAIT;           
       
end process;                                      
      

end Behavioral;
