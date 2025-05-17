----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2025 03:38:09 PM
-- Design Name: 
-- Module Name: TB_PC_3bit - Behavioral
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

entity TB_PC_3bit is
--  Port ( );
end TB_PC_3bit;


architecture Behavioral of TB_PC_3bit is
    -- Component declaration for PC_3bit
    component PC_3bit
        Port (
            D : in STD_LOGIC_VECTOR (2 downto 0);
            Load : in STD_LOGIC;
            Clk : in STD_LOGIC;
            Res : in STD_LOGIC;
            Q : out STD_LOGIC_VECTOR (2 downto 0)
        );
    end component;

    -- Signals
    signal D : STD_LOGIC_VECTOR (2 downto 0) := "000";
    signal Load : STD_LOGIC := '0';
    signal Clk : STD_LOGIC := '0';
    signal Res : STD_LOGIC := '0';
    signal Q : STD_LOGIC_VECTOR (2 downto 0);

    -- Clock period (2 seconds as per slow clock guideline)
    constant CLK_PERIOD : time := 2 sec;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: PC_3bit
        port map (
            D => D,
            Load => Load,
            Clk => Clk,
            Res => Res,
            Q => Q
        );

    -- Clock process
    clk_process: process
    begin
        while true loop
            Clk <= '0';
            wait for CLK_PERIOD / 2;
            Clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Test Case 1: Initial Reset
        Res <= '1';
        wait for CLK_PERIOD;
        Res <= '0';
        wait for CLK_PERIOD;
        assert Q = "000" report "Reset failed" severity error;

        -- Test Case 2: Increment PC (Load = '0')
        Load <= '0';
        wait for CLK_PERIOD * 3; -- Increment 3 times: 000 -> 001 -> 010 -> 011
        assert Q = "011" report "Increment failed" severity error;

        -- Test Case 3: Load a value (D = "101") - Simulate JZR jump
        D <= "101"; -- Address 5 (e.g., jump to ROM 5)
        Load <= '1';
        wait for CLK_PERIOD;
        Load <= '0';
        wait for CLK_PERIOD;
        assert Q = "101" report "Load failed" severity error;

        -- Test Case 4: Increment after Load
        wait for CLK_PERIOD * 2; -- Increment 2 times: 101 -> 110 -> 111
        assert Q = "111" report "Increment after load failed" severity error;

        -- Test Case 5: Reset after operations
        Res <= '1';
        wait for CLK_PERIOD;
        Res <= '0';
        wait for CLK_PERIOD;
        assert Q = "000" report "Reset after operations failed" severity error;

        -- Test Case 6: Load another value (D = "010")
        D <= "010"; -- Address 2
        Load <= '1';
        wait for CLK_PERIOD;
        Load <= '0';
        wait for CLK_PERIOD;
        assert Q = "010" report "Second load failed" severity error;

        -- End simulation
        wait;
    end process;
end Behavioral;