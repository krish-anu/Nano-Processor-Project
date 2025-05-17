----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2025 05:10:21 PM
-- Design Name: 
-- Module Name: Nano_Processor - Behavioral
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

entity Nano_Processor is
    Port (
        Reset : in STD_LOGIC;                       -- Pushbutton reset
        Clk_in : in STD_LOGIC;                      -- Board clock
        Zero : out STD_LOGIC;                       -- Zero flag from ALU
        Overflow : out STD_LOGIC;                   -- Overflow flag from ALU
        R7_out : out STD_LOGIC_VECTOR (3 downto 0); -- Output to LEDs (Reg 7)
        Seven_Segment_out : out STD_LOGIC_VECTOR (6 downto 0); -- Seven-segment display
        Anode : out STD_LOGIC_VECTOR (3 downto 0)   -- Anode for seven-segment display
    );
end Nano_Processor;


architecture Behavioral of Nano_Processor is
    -- Component declarations
    component Slow_Clk
        Port (
            Clk_in : in STD_LOGIC;
            Reset : in STD_LOGIC;
            Clk_out : out STD_LOGIC
        );
    end component;

    component PC_3bit
        Port (
            D : in STD_LOGIC_VECTOR (2 downto 0);
            Load : in STD_LOGIC;
            Clk : in STD_LOGIC;
            Res : in STD_LOGIC;
            Q : out STD_LOGIC_VECTOR (2 downto 0)
        );
    end component;

    component Program_Rom
        Port (
            MemorySel : in STD_LOGIC_VECTOR (2 downto 0);
            Instruction : out STD_LOGIC_VECTOR (11 downto 0)
        );
    end component;

    component Instruction_decoder
        Port (
            Instruction_bus : in STD_LOGIC_VECTOR (11 downto 0);
            Reg_Value : in STD_LOGIC_VECTOR (3 downto 0);
            Reg_a_address : out STD_LOGIC_VECTOR (2 downto 0);
            Reg_b_address : out STD_LOGIC_VECTOR (2 downto 0);
            Reg_select : out STD_LOGIC_VECTOR (2 downto 0);
            AddSub_select : out STD_LOGIC;
            Jump_flag : out STD_LOGIC;
            Jump_address : out STD_LOGIC_VECTOR (2 downto 0);
            Load_select : out STD_LOGIC;
            Immediate_value : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

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

    component RCA_4
        Port (
            A : in STD_LOGIC_VECTOR (3 downto 0);
            B : in STD_LOGIC_VECTOR (3 downto 0);
            M : in STD_LOGIC;
            S : out STD_LOGIC_VECTOR (3 downto 0);
            Overflow : out STD_LOGIC;
            Zero : out STD_LOGIC
        );
    end component;

    component LUT_16_7
        Port (
            address : in STD_LOGIC_VECTOR (3 downto 0);
            data : out STD_LOGIC_VECTOR (6 downto 0)
        );
    end component;

    -- Signals
    signal Slow_Clk_Sig : STD_LOGIC;
    signal PC_Out : STD_LOGIC_VECTOR (2 downto 0);
    signal Next_PC : STD_LOGIC_VECTOR (2 downto 0);
    signal Mux_3bit_Out : STD_LOGIC_VECTOR (2 downto 0);
    signal Instruction : STD_LOGIC_VECTOR (11 downto 0);
    signal Reg_a_address, Reg_b_address, Reg_select, Jump_address : STD_LOGIC_VECTOR (2 downto 0);
    signal AddSub_select, Jump_flag, Load_select : STD_LOGIC;
    signal Immediate_value : STD_LOGIC_VECTOR (3 downto 0);
    signal Reg_0_out, Reg_1_out, Reg_2_out, Reg_3_out : STD_LOGIC_VECTOR (3 downto 0);
    signal Reg_4_out, Reg_5_out, Reg_6_out, Reg_7_out : STD_LOGIC_VECTOR (3 downto 0);
    signal Mux_A_out, Mux_B_out, ALU_out, Mux_4bit_out : STD_LOGIC_VECTOR (3 downto 0);


begin
    -- Instantiate Slow_Clk
    Slow_Clock: Slow_Clk
        port map (
            Clk_in => Clk_in,
            Reset => Reset,
            Clk_out => Slow_Clk_Sig
        );

    -- 2-way 3-bit multiplexer logic (PC + 1 or Jump_address)
    Next_PC(0) <= not PC_Out(0);
    Next_PC(1) <= PC_Out(1) xor PC_Out(0);
    Next_PC(2) <= PC_Out(2) xor (PC_Out(1) and PC_Out(0));
    Mux_3bit_Out <= Jump_address when Jump_flag = '1' else Next_PC;

    -- Instantiate PC_3bit
    Program_Counter: PC_3bit
        port map (
            D => Mux_3bit_Out,
            Load => Jump_flag,
            Clk => Slow_Clk_Sig,
            Res => Reset,
            Q => PC_Out
        );

    -- Instantiate Program_Rom
    ROM: Program_Rom
        port map (
            MemorySel => PC_Out,
            Instruction => Instruction
        );

    -- Instantiate Instruction_decoder
    Decoder: Instruction_decoder
        port map (
            Instruction_bus => Instruction,
            Reg_Value => Reg_1_out, -- R1 for JZR check
            Reg_a_address => Reg_a_address,
            Reg_b_address => Reg_b_address,
            Reg_select => Reg_select,
            AddSub_select => AddSub_select,
            Jump_flag => Jump_flag,
            Jump_address => Jump_address,
            Load_select => Load_select,
            Immediate_value => Immediate_value
        );

    -- 8-way 4-bit multiplexers (custom logic for selecting Reg_a and Reg_b)
    Mux_A_out <= Reg_0_out when Reg_a_address = "000" else
                 Reg_1_out when Reg_a_address = "001" else
                 Reg_2_out when Reg_a_address = "010" else
                 Reg_3_out when Reg_a_address = "011" else
                 Reg_4_out when Reg_a_address = "100" else
                 Reg_5_out when Reg_a_address = "101" else
                 Reg_6_out when Reg_a_address = "110" else
                 Reg_7_out;
    Mux_B_out <= Reg_0_out when Reg_b_address = "000" else
                 Reg_1_out when Reg_b_address = "001" else
                 Reg_2_out when Reg_b_address = "010" else
                 Reg_3_out when Reg_b_address = "011" else
                 Reg_4_out when Reg_b_address = "100" else
                 Reg_5_out when Reg_b_address = "101" else
                 Reg_6_out when Reg_b_address = "110" else
                 Reg_7_out;

    -- Instantiate RCA_4 (ALU)
    ALU: RCA_4
        port map (
            A => Mux_A_out,
            B => Mux_B_out,
            M => AddSub_select,
            S => ALU_out,
            Overflow => Overflow,
            Zero => Zero
        );

    -- 2-way 4-bit multiplexer logic (ALU_out or Immediate_value)
    Mux_4bit_out <= Immediate_value when Load_select = '1' else ALU_out;

    -- Instantiate Register_Bank
    RegBank: Register_Bank
        port map (
            Selector => Reg_select,
            Clk => Slow_Clk_Sig,
            Reset => Reset,
            Data => Mux_4bit_out,
            Reg_0_out => Reg_0_out,
            Reg_1_out => Reg_1_out,
            Reg_2_out => Reg_2_out,
            Reg_3_out => Reg_3_out,
            Reg_4_out => Reg_4_out,
            Reg_5_out => Reg_5_out,
            Reg_6_out => Reg_6_out,
            Reg_7_out => Reg_7_out
        );

    -- Instantiate LUT_16_7 (Seven-segment display)
    Seven_Segment: LUT_16_7
        port map (
            address => Reg_7_out,
            data => Seven_Segment_out
        );

    -- Output assignments
    R7_out <= Reg_7_out; -- To LEDs
    Anode <= "1110";     -- Activate one seven-segment display
end Behavioral;
