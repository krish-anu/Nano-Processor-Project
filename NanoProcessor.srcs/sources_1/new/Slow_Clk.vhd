----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/28/2025 12:27:22 PM
-- Design Name: 
-- Module Name: Slow_Clk - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
--   This module generates a slower clock signal by dividing the input clock.
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

entity Slow_Clk is
    Port (
        Clk_in   : in  STD_LOGIC;
        Reset    : in  STD_LOGIC;
        Clk_out  : out STD_LOGIC
    );
end Slow_Clk;

architecture Behavioral of Slow_Clk is
    constant DIV_FACTOR : integer := 50000000; -- Clock division factor
    signal count        : integer range 0 to DIV_FACTOR := 0;
    signal Clk_status   : STD_LOGIC := '0';
begin

    process (Clk_in, Reset)
    begin
        if (Reset = '1') then
            count <= 0;
            Clk_status <= '0';
        elsif rising_edge(Clk_in) then
            count <= count + 1;
            if (count = DIV_FACTOR) then
                Clk_status <= not Clk_status;
                count <= 0;
            end if;
        end if;
    end process;

    Clk_out <= Clk_status; -- assign outside process

end Behavioral;
