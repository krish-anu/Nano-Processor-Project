----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2025 03:36:00 PM
-- Design Name: 
-- Module Name: TB_Decoder_2_to_4 - Behavioral
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

entity TB_Decoder_2_to_4 is
--  Port ( );
end TB_Decoder_2_to_4;


architecture Behavioral of TB_Decoder_2_to_4 is
    -- Component declaration for Decoder_2_to_4
    component Decoder_2_to_4
        Port (
            I : in STD_LOGIC_VECTOR (1 downto 0);
            EN : in STD_LOGIC;
            Y : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    -- Signals
    signal I : STD_LOGIC_VECTOR (1 downto 0) := "00";
    signal EN : STD_LOGIC := '0';
    signal Y : STD_LOGIC_VECTOR (3 downto 0);

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: Decoder_2_to_4
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
        I <= "00";
        wait for 10 ns;
        assert Y = "0000" report "EN = 0 failed" severity error;

        -- Test Case 2: EN = '1', I = "00"
        EN <= '1';
        I <= "00";
        wait for 10 ns;
        assert Y = "0001" report "I = 00 failed" severity error;

        -- Test Case 3: EN = '1', I = "01"
        I <= "01";
        wait for 10 ns;
        assert Y = "0010" report "I = 01 failed" severity error;

        -- Test Case 4: EN = '1', I = "10"
        I <= "10";
        wait for 10 ns;
        assert Y = "0100" report "I = 10 failed" severity error;

        -- Test Case 5: EN = '1', I = "11"
        I <= "11";
        wait for 10 ns;
        assert Y = "1000" report "I = 11 failed" severity error;

        -- Test Case 6: EN = '0' again
        EN <= '0';
        I <= "11";
        wait for 10 ns;
        assert Y = "0000" report "EN = 0 after I = 11 failed" severity error;

        -- End simulation
        wait;
    end process;
end Behavioral;