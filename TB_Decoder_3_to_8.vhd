----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2025 03:36:39 PM
-- Design Name: 
-- Module Name: TB_Decoder_3_to_8 - Behavioral
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
    -- Component declaration for Decoder_3_to_8
    component Decoder_3_to_8
        Port (
            I : in STD_LOGIC_VECTOR (2 downto 0);
            EN : in STD_LOGIC;
            Y : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;

    -- Signals
    signal I : STD_LOGIC_VECTOR (2 downto 0) := "000";
    signal EN : STD_LOGIC := '0';
    signal Y : STD_LOGIC_VECTOR (7 downto 0);

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: Decoder_3_to_8
        port map (
            I => I,
            EN => EN,
            Y => Y
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- Test Case 1: EN = '0', all outputs should be '0'
        EN <= '0';
        I <= "000";
        wait for 10 ns;
        assert Y = "00000000" report "EN = 0 failed" severity error;

        -- Test Case 2: EN = '1', I = "000"
        EN <= '1';
        I <= "000";
        wait for 10 ns;
        assert Y = "00000001" report "I = 000 failed" severity error;

        -- Test Case 3: EN = '1', I = "001"
        I <= "001";
        wait for 10 ns;
        assert Y = "00000010" report "I = 001 failed" severity error;

        -- Test Case 4: EN = '1', I = "010"
        I <= "010";
        wait for 10 ns;
        assert Y = "00000100" report "I = 010 failed" severity error;

        -- Test Case 5: EN = '1', I = "011"
        I <= "011";
        wait for 10 ns;
        assert Y = "00001000" report "I = 011 failed" severity error;

        -- Test Case 6: EN = '1', I = "100"
        I <= "100";
        wait for 10 ns;
        assert Y = "00010000" report "I = 100 failed" severity error;

        -- Test Case 7: EN = '1', I = "111"
        I <= "111";
        wait for 10 ns;
        assert Y = "10000000" report "I = 111 failed" severity error;

        -- Test Case 8: EN = '0' again
        EN <= '0';
        I <= "111";
        wait for 10 ns;
        assert Y = "00000000" report "EN = 0 after I = 111 failed" severity error;

        -- End simulation
        wait;
    end process;
end Behavioral;