# Quad-Core-RISC-V-Processor-System
The primary objective of this project was to design a multi-core system that shares a single unified Data RAM. To manage simultaneous memory access requests from four independent cores, a Round-Robin Arbiter was implemented. This ensures fair, starvation-free access for all cores, preventing data corruption and bus contention.
Key Features

Quad-Core Architecture: Four parallel Single-Cycle RISC-V cores.

Starvation-Free Arbitration: Implements a Round-Robin algorithm to manage shared bus access.

Modular Design: Clean separation of Core Logic, Memory Subsystem, and Interconnects.

Unified Memory Model: Distributed Instruction ROMs with a single Shared Data RAM (1KB).

Hazard Management: Cores automatically stall when denied bus access.
