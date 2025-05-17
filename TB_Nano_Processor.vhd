----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2025 05:12:12 PM
-- Design Name: 
-- Module Name: TB_Nano_Processor - Behavioral
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

entity TB_Nano_Processor is
--  Port ( );
end TB_Nano_Processor;


architecture Behavioral of TB_Nano_Processor is
    component Nano_Processor
        Port (
            Reset : in STD_LOGIC;
            Clk_in : in STD_LOGIC;
            Zero : out STD_LOGIC;
            Overflow : out STD_LOGIC;
            R7_out : out STD_LOGIC_VECTOR (3 downto 0);
            Seven_Segment_out : out STD_LOGIC_VECTOR (6 downto 0);
            Anode : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    signal Reset : STD_LOGIC := '0';
    signal Clk_in : STD_LOGIC := '0';
    signal Zero : STD_LOGIC;
    signal Overflow : STD_LOGIC;
    signal R7_out : STD_LOGIC_VECTOR (3 downto 0);
    signal Seven_Segment_out : STD_LOGIC_VECTOR (6 downto 0);
    signal Anode : STD_LOGIC_VECTOR (3 downto 0);

    constant CLK_PERIOD : time := 10 ns;
    -- For faster simulation, reduce DIV_FACTOR in Slow_Clk to 50
    constant SLOW_CLK_PERIOD : time := 50 * 2 * CLK_PERIOD; -- 1000 ns (1 us)
    
    
begin
        uut: Nano_Processor
            port map (
                Reset => Reset,
                Clk_in => Clk_in,
                Zero => Zero,
                Overflow => Overflow,
                R7_out => R7_out,
                Seven_Segment_out => Seven_Segment_out,
                Anode => Anode
            );
    
        clk_process: process
        begin
            while true loop
                Clk_in <= '0';
                wait for CLK_PERIOD / 2;
                Clk_in <= '1';
                wait for CLK_PERIOD / 2;
            end loop;
        end process;
    
        stim_proc: process
        begin
            -- Test Case 1: Initial Reset
            Reset <= '1';
            wait for CLK_PERIOD * 2;
            Reset <= '0';
            wait for CLK_PERIOD * 2;
            assert R7_out = "0000" report "R7 not reset" severity error;
    
            -- Test Case 2: Run the program
            -- Note: DIV_FACTOR reduced to 50 for simulation (1 slow cycle = 1 us)
            -- Each instruction takes 1 slow clock cycle
            -- Cycle 1: MOVI R1, 10
            wait for SLOW_CLK_PERIOD;
            -- Access internal signals via path (for simulation only)
            assert uut.RegBank.Reg_1_out = "1010" report "MOVI R1, 10 failed" severity error;
    
            -- Cycle 2: MOVI R2, 1
            wait for SLOW_CLK_PERIOD;
            assert uut.RegBank.Reg_2_out = "0001" report "MOVI R2, 1 failed" severity error;
    
            -- Cycle 3: NEG R2
            wait for SLOW_CLK_PERIOD;
            assert uut.RegBank.Reg_2_out = "1111" report "NEG R2 failed" severity error;
    
            -- Cycle 4: ADD R1, R2
            wait for SLOW_CLK_PERIOD;
            assert uut.RegBank.Reg_1_out = "1001" report "ADD R1, R2 failed" severity error;
    
            -- Cycle 5: JZR R1, 7 (no jump, R1 ? 0)
            wait for SLOW_CLK_PERIOD;
            assert uut.Program_Counter.Q = "101" report "JZR R1, 7 should not jump" severity error;
    
            -- Cycle 6: JZR R0, 3 (jump to 3, R0 = 0)
            wait for SLOW_CLK_PERIOD;
            assert uut.Program_Counter.Q = "011" report "JZR R0, 3 failed" severity error;
    
            -- Cycle 7: ADD R1, R2 (R1 = 9 - 1 = 8)
            wait for SLOW_CLK_PERIOD;
            assert uut.RegBank.Reg_1_out = "1000" report "Second ADD R1, R2 failed" severity error;
    
            -- Run a few more cycles to observe loop
            wait for SLOW_CLK_PERIOD * 3;
    
            -- End simulation
            wait;
        end process;
    end Behavioral;