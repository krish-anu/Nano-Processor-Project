# 4-Bit Nanoprocessor Project (12-bit and 13-bit Instruction Versions)

This project implements a custom-designed 4-bit nanoprocessor developed in two stages:

1. An initial version using a 12-bit instruction format  
2. An enhanced version with a 13-bit instruction format, supporting more advanced operations

Both versions are implemented using VHDL and focus on arithmetic, logical operations, data movement, and control flow.

---

## Phase 1: 12-Bit Instruction Nanoprocessor

### Supported Instructions
- `ADD` – Add contents of two registers
- `NEG` – Two’s complement (negate) of a register
- `MOVI` – Move immediate value into a register
- `JZR` – Jump to address if a register value is zero

### Instruction Format (12 bits)

| Bits        | Field      | Description                             |
|-------------|------------|-----------------------------------------|
| 11 – 10     | OPCODE     | Operation code (2 bits)                 |
| 9 – 7       | DEST       | Destination register (R0–R7)            |
| 6 – 4       | SRC        | Source register                         |
| 3 – 0       | IMM/ADDR   | Immediate value or jump address         |

### Example Instructions
- `MOVI R2, 5` → Load value 5 into R2  
- `JZR R1, 0xA` → If R1 == 0, jump to address 0xA

---

## Phase 2: Enhanced 13-Bit Instruction Nanoprocessor

To increase functionality, the instruction format was upgraded to 13 bits, enabling more operations and clearer decoding.

### New Instructions Added
- `CMP` – Compare two registers (sets flags)
- `AND` – Bitwise AND of two registers
- `OR` – Bitwise OR of two registers

### Instruction Format (13 bits)

| Bits        | Field      | Description                             |
|-------------|------------|-----------------------------------------|
| 12 – 10     | OPCODE     | Operation code (3 bits)                 |
| 9 – 7       | DEST       | Destination register (R0–R7)            |
| 6 – 4       | SRC        | Source register                         |
| 3 – 0       | IMM/ADDR   | Immediate value, jump address, or unused|

### Opcode Table

| OPCODE | Mnemonic | Operation Description                        |
|--------|----------|----------------------------------------------|
| 000    | ADD      | DEST ← DEST + SRC                            |
| 001    | NEG      | DEST ← -DEST                                 |
| 010    | MOVI     | DEST ← Immediate                             |
| 011    | JZR      | If DEST == 0, PC ← address                   |
| 100    | CMP      | Set flags based on DEST - SRC                |
| 101    | AND      | DEST ← DEST & SRC                            |
| 110    | OR       | DEST ← DEST | SRC                            |
| 111    | Reserved | For future use                               |

### Example Instructions

| Binary Instruction | Mnemonic        | Meaning                          |
|--------------------|-----------------|----------------------------------|
| 0101110001010      | MOVI R7, 10     | Load 0xA into R7                 |
| 1001110110000      | CMP R7, R3      | Compare R7 with R3               |
| 1010010100000      | AND R1, R2      | R1 ← R1 & R2                     |
| 1100010100000      | OR R1, R2       | R1 ← R1 | R2                     |

---

---

## Features

- ALU supporting arithmetic and logic operations
- Register file with 8 general-purpose registers
- Control logic for conditional branching
- Instruction decoder for 12-bit and 13-bit formats
- Simulation testbench for functional verification

---

## Future Work

- Add subtraction, shift, and load/store instructions
- Include memory interfacing
- Implement input/output handling
- Extend instruction width for larger programs

---
Developed with ❤️ for understanding digital systems and processor design.
