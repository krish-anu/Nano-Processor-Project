----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2025 03:30:30 PM
-- Design Name: 
-- Module Name: TB_Register_Bank - Behavioral
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

entity TB_Register_Bank is
--  Port ( );
end TB_Register_Bank;

architecture Behavioral of TB_Register_Bank is
    -- Component declaration for Register_Bank
    component Register_Bank
        Port (
            Selector : in STD_LOGIC_VECTOR (2 downto 0);
            Clk : in STD_LOGIC;
            Reset : in STD_LOGIC;
            Data : in STD_LOGIC_VECTOR (3 downto 0);
            Reg_0_out : out STD_LOGIC_VECTOR (3 downto 0);
            Reg_1_out : out STD_LOGIC_VECTOR (3 downto 0);
            Reg_2_out : out STD_LOGIC_VECTOR (3 downto 0);
            Reg_3_out : out STD_LOGIC_VECTOR (3 downto 0);
            Reg_4_out : out STD_LOGIC_VECTOR (3 downto 0);
            Reg_5_out : out STD_LOGIC_VECTOR (3 downto 0);
            Reg_6_out : out STD_LOGIC_VECTOR (3 downto 0);
            Reg_7_out : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    -- Signals
    signal Selector : STD_LOGIC_VECTOR (2 downto 0) := "000";
    signal Clk : STD_LOGIC := '0';
    signal Reset : STD_LOGIC := '0';
    signal Data : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    signal Reg_0_out : STD_LOGIC_VECTOR (3 downto 0);
    signal Reg_1_out : STD_LOGIC_VECTOR (3 downto 0);
    signal Reg_2_out : STD_LOGIC_VECTOR (3 downto 0);
    signal Reg_3_out : STD_LOGIC_VECTOR (3 downto 0);
    signal Reg_4_out : STD_LOGIC_VECTOR (3 downto 0);
    signal Reg_5_out : STD_LOGIC_VECTOR (3 downto 0);
    signal Reg_6_out : STD_LOGIC_VECTOR (3 downto 0);
    signal Reg_7_out : STD_LOGIC_VECTOR (3 downto 0);

    -- Clock period (2 seconds as per slow clock guideline)
    constant CLK_PERIOD : time := 2 sec;


begin
    -- Instantiate the Unit Under Test (UUT)
    uut: Register_Bank
        port map (
            Selector => Selector,
            Clk => Clk,
            Reset => Reset,
            Data => Data,
            Reg_0_out => Reg_0_out,
            Reg_1_out => Reg_1_out,
            Reg_2_out => Reg_2_out,
            Reg_3_out => Reg_3_out,
            Reg_4_out => Reg_4_out,
            Reg_5_out => Reg_5_out,
            Reg_6_out => Reg_6_out,
            Reg_7_out => Reg_7_out
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
        wait for CLK_PERIOD;
        Reset <= '0';
        wait for CLK_PERIOD;
        assert Reg_0_out = "0000" and Reg_1_out = "0000" and Reg_2_out = "0000" and
               Reg_3_out = "0000" and Reg_4_out = "0000" and Reg_5_out = "0000" and
               Reg_6_out = "0000" and Reg_7_out = "0000"
            report "Reset failed" severity error;

        -- Test Case 2: Write to R1 (Selector = "001") - Simulate MOVI R1, 10
        Data <= "1010"; -- Decimal 10
        Selector <= "001";
        wait for CLK_PERIOD;
        Selector <= "000"; -- Check output
        wait for CLK_PERIOD;
        assert Reg_1_out = "1010" report "R1 write failed" severity error;

        -- Test Case 3: Write to R2 (Selector = "010") - Simulate MOVI R2, 1
        Data <= "0001"; -- Decimal 1
        Selector <= "010";
        wait for CLK_PERIOD;
        Selector <= "000"; -- Check output
        wait for CLK_PERIOD;
        assert Reg_2_out = "0001" report "R2 write failed" severity error;

        -- Test Case 4: Verify R0 remains "0000" despite Enable
        Selector <= "000";
        Data <= "1111"; -- Try to overwrite R0
        wait for CLK_PERIOD;
        assert Reg_0_out = "0000" report "R0 not hardcoded to 0000" severity error;

        -- Test Case 5: Write to R7 (Selector = "111") - Simulate final result storage
        Data <= "0011"; -- Decimal 3 (e.g., sum of 1+2)
        Selector <= "111";
        wait for CLK_PERIOD;
        Selector <= "000"; -- Check output
        wait for CLK_PERIOD;
        assert Reg_7_out = "0011" report "R7 write failed" severity error;

        -- Test Case 6: Reset again to verify
        Reset <= '1';
        wait for CLK_PERIOD;
        Reset <= '0';
        wait for CLK_PERIOD;
        assert Reg_7_out = "0000" report "Reset after write failed" severity error;

        -- End simulation
        wait;
    end process;
end Behavioral;
