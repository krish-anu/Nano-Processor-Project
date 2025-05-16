----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2025 01:25:03 PM
-- Design Name: 
-- Module Name: Register_Bank - Behavioral
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

entity Register_Bank is
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
end Register_Bank;

architecture Behavioral of Register_Bank is
    component Reg
        port (
            Reg_in : in STD_LOGIC_VECTOR (3 downto 0);
            Enable : in STD_LOGIC;
            Reset : in STD_LOGIC;
            Clk : in STD_LOGIC;
            Reg_out : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    component Decoder_3_to_8
        port (
            I : in STD_LOGIC_VECTOR (2 downto 0);
            EN : in STD_LOGIC;
            Y : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;

    signal Enable : STD_LOGIC_VECTOR (7 downto 0);
    
begin
    Decoder_3_to_8_0: Decoder_3_to_8
        port map (
            I => Selector,
            EN => '1',
            Y => Enable
        );

    Reg_0: Reg
        port map (
            Reg_in => "0000",  
            Enable => Enable(0),
            Reset => Reset,
            Clk => Clk,
            Reg_out => Reg_0_out
        );

    Reg_1: Reg
        port map (
            Reg_in => Data,
            Enable => Enable(1),
            Reset => Reset,
            Clk => Clk,
            Reg_out => Reg_1_out
        );

    Reg_2: Reg
        port map (
            Reg_in => Data,
            Enable => Enable(2),
            Reset => Reset,
            Clk => Clk,
            Reg_out => Reg_2_out
        );

    Reg_3: Reg
        port map (
            Reg_in => Data,
            Enable => Enable(3),
            Reset => Reset,
            Clk => Clk,
            Reg_out => Reg_3_out
        );

    Reg_4: Reg
        port map (
            Reg_in => Data,
            Enable => Enable(4),
            Reset => Reset,
            Clk => Clk,
            Reg_out => Reg_4_out
        );

    Reg_5: Reg
        port map (
            Reg_in => Data,
            Enable => Enable(5),
            Reset => Reset,
            Clk => Clk,
            Reg_out => Reg_5_out
        );

    Reg_6: Reg
        port map (
            Reg_in => Data,
            Enable => Enable(6),
            Reset => Reset,
            Clk => Clk,
            Reg_out => Reg_6_out
        );

    Reg_7: Reg
        port map (
            Reg_in => Data,
            Enable => Enable(7),
            Reset => Reset,
            Clk => Clk,
            Reg_out => Reg_7_out
        );
end Behavioral;
