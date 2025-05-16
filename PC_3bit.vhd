----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2025 11:10:22 AM
-- Design Name: 
-- Module Name: PC_3bit - Behavioral
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

entity PC_3bit is
    Port (
        D : in STD_LOGIC_VECTOR (2 downto 0); 
        Load : in STD_LOGIC;                        
        Clk : in STD_LOGIC;                         
        Res : in STD_LOGIC;                         
        Q : out STD_LOGIC_VECTOR (2 downto 0)       
    );
end PC_3bit;


architecture Behavioral of PC_3bit is
    signal pc_reg : STD_LOGIC_VECTOR (2 downto 0) := "000"; 
    signal next_pc : STD_LOGIC_VECTOR (2 downto 0); 
            
begin
    next_pc(0) <= not pc_reg(0);                             
    next_pc(1) <= pc_reg(1) xor pc_reg(0);                    
    next_pc(2) <= pc_reg(2) xor (pc_reg(1) and pc_reg(0));    

    process (Clk)
    begin
        if rising_edge(Clk) then
            if Res = '1' then
                pc_reg <= "000"; 
            elsif Load = '1' then
                pc_reg <= D; 
            else
                pc_reg <= next_pc; 
            end if;
        end if;
    end process;

    Q <= pc_reg;
end Behavioral;
