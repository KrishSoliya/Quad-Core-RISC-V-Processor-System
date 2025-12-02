# Quad-Core-RISC-V-Processor-System
The primary objective of this project was to design a multi-core system that shares a single unified Data RAM. To manage simultaneous memory access requests from four independent cores, a Round-Robin Arbiter was implemented. This ensures fair, starvation-free access for all cores, preventing data corruption and bus contention.
QuadCore_RISCV_Project/
├── src/                        # Design Source Code
│   ├── include/                # Header files and Definitions
│   │   └── riscv_defines.svh   # OpCode definitions (RV32I)
│   ├── core/                   # Processor Core Logic
│   │   ├── alu.sv              # Arithmetic Logic Unit
│   │   ├── decoder.sv          # Instruction Decoder
│   │   ├── program_counter.sv  # PC with Stall Logic
│   │   ├── reg_file.sv         # 32x32 Register File
│   │   └── riscv_core_single.sv# Single Core Wrapper
│   ├── memory/                 # Memory Subsystem
│   │   ├── instruction_rom.sv  # Read-Only Program Memory
│   │   ├── data_ram.sv         # Shared 1KB Data RAM
│   │   └── memory_interface.sv # Memory Wrapper
│   └── interconnect/           # Bus & Arbitration Logic
│       ├── round_robin_arbiter.sv # The Arbitration Logic
│       ├── bus_mux.sv          # 4-to-1 Bus Multiplexer
│       └── quad_core_top.sv    # Top-Level System Module
├── sim/                        # Verification Environment
│   └── tb_quad_core.sv         # SystemVerilog Testbench
└── README.md                   # Project Documentation
