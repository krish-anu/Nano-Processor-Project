----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 04/25/2025 06:03:44 PM
-- Design Name:
-- Module Name: LUT_16_7 - Behavioral
-- Project Name: Lab 8
-- Target Devices:
-- Tool Versions:
-- Description:
--   This module implements a 16-to-7 lookup table (LUT) for driving a seven-segment display.
--   It maps a 4-bit input address to a 7-bit output based on a predefined ROM.
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--   The ROM maps hexadecimal digits (0 to F) to their corresponding seven-segment display patterns.
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity LUT_16_7 is
    Port ( 
           address : in STD_LOGIC_VECTOR (3 downto 0); -- 4-bit input address
           data : out STD_LOGIC_VECTOR (6 downto 0)    -- 7-bit output for seven-segment display
         );
end LUT_16_7;

architecture Behavioral of LUT_16_7 is
    -- Define the ROM type and initialize it with seven-segment patterns
    type rom_type is array (0 to 15) of std_logic_vector(6 downto 0);
    signal sevenSegment_ROM : rom_type := (
        "1000000", -- 0
        "1111001", -- 1
        "0100100", -- 2
        "0110000", -- 3
        "0011001", -- 4
        "0010010", -- 5
        "0000010", -- 6
        "1111000", -- 7
        "0000000", -- 8
        "0010000", -- 9
        "0001000", -- A
        "0000011", -- B
        "1000110", -- C
        "0100001", -- D
        "0000110", -- E
        "0001110"  -- F
    );
begin
    -- Map the input address to the corresponding seven-segment pattern
    data <= sevenSegment_ROM(to_integer(unsigned(address)));
end Behavioral;