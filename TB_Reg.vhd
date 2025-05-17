----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2025 03:35:09 PM
-- Design Name: 
-- Module Name: TB_Reg - Behavioral
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

entity TB_Reg is
--  Port ( );
end TB_Reg;



architecture Behavioral of TB_Reg is
    -- Component declaration for Reg
    component Reg
        Port (
            Reg_in : in STD_LOGIC_VECTOR (3 downto 0);
            Enable : in STD_LOGIC;
            Reset : in STD_LOGIC;
            Clk : in STD_LOGIC;
            Reg_out : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    -- Signals
    signal Reg_in : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    signal Enable : STD_LOGIC := '0';
    signal Reset : STD_LOGIC := '0';
    signal Clk : STD_LOGIC := '0';
    signal Reg_out : STD_LOGIC_VECTOR (3 downto 0);

    -- Clock period (10 ns for faster simulation)
    constant CLK_PERIOD : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: Reg
        port map (
            Reg_in => Reg_in,
            Enable => Enable,
            Reset => Reset,
            Clk => Clk,
            Reg_out => Reg_out
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
        Reset <= '1';
        wait for CLK_PERIOD * 2;
        Reset <= '0';
        wait for CLK_PERIOD * 2;
        assert Reg_out = "0000" report "Reset failed" severity error;

        -- Test Case 2: Write with Enable = '1'
        Reg_in <= "1010";
        Enable <= '1';
        wait for CLK_PERIOD * 2;
        Enable <= '0';
        wait for CLK_PERIOD * 2;
        assert Reg_out = "1010" report "Write with Enable failed" severity error;

        -- Test Case 3: No Write with Enable = '0'
        Reg_in <= "1111";
        Enable <= '0';
        wait for CLK_PERIOD * 2;
        assert Reg_out = "1010" report "Data changed without Enable" severity error;

        -- Test Case 4: Reset After Write
        Reset <= '1';
        wait for CLK_PERIOD * 2;
        Reset <= '0';
        wait for CLK_PERIOD * 2;
        assert Reg_out = "0000" report "Reset after write failed" severity error;

        -- Test Case 5: Write Another Value
        Reg_in <= "0011";
        Enable <= '1';
        wait for CLK_PERIOD * 2;
        Enable <= '0';
        wait for CLK_PERIOD * 2;
        assert Reg_out = "0011" report "Second write failed" severity error;

        -- End simulation
        wait;
    end process;
end Behavioral;
