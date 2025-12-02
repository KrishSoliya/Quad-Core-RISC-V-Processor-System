// src/core/riscv_core_single.sv
`include "src/include/riscv_defines.svh"

module riscv_core_single #(parameter CORE_ID = 0) (
    input  logic        clk,
    input  logic        reset,
    input  logic        bus_grant,
    output logic        bus_req,
    output logic        bus_we,
    output logic [31:0] bus_addr,
    output logic [31:0] bus_wdata
);
    // Internal Signals
    logic [31:0] pc, instr, rdata1, rdata2, alu_res;
    logic reg_write, mem_write_internal, mem_req_internal;
    logic [3:0] alu_ctrl;

    // 1. Program Counter
    program_counter pc_inst (
        .clk(clk), .reset(reset), .stall(bus_req && !bus_grant), .pc_out(pc)
    );

    // 2. Instruction Memory
    instruction_rom instr_rom_inst (
        .addr(pc), .instruction(instr)
    );

    // 3. Decoder
    decoder dec_inst (
        .instr(instr), .reg_write(reg_write), .mem_write(mem_write_internal), 
        .mem_req(mem_req_internal), .alu_ctrl(alu_ctrl)
    );

    // 4. Register File
    reg_file rf_inst (
        .clk(clk), .we(reg_write), .rs1(instr[19:15]), .rs2(instr[24:20]), 
        .rd(instr[11:7]), .wdata(alu_res), .rdata1(rdata1), .rdata2(rdata2)
    );

    // --- NEW LOGIC: Immediate Handling ---
    
    // Extract the "Immediate" (The number part of the instruction)
    // For ADDI, the number is in the top 12 bits (31:20)
    logic [31:0] imm_i;
    assign imm_i = {{20{instr[31]}}, instr[31:20]}; // Sign extension

    // Mux: Choose between Register 2 or the Immediate value
    logic [31:0] alu_operand_b;
    // Check if OpCode is OP_IMM (0010011) or OP_LOAD (0000011) or OP_STORE (0100011)
    // For this simple demo, we just check for Immediate OpCode
    assign alu_operand_b = (instr[6:0] == `OP_IMM) ? imm_i : rdata2;

    // -------------------------------------

    // 5. ALU (Now uses the smart operand_b)
    alu alu_inst (
        .a(rdata1), .b(alu_operand_b), .alu_ctrl(alu_ctrl), .result(alu_res), .zero()
    );

    // Bus Output Logic
    assign bus_req   = mem_req_internal;
    assign bus_we    = mem_write_internal;
    // Add offset to address so cores write to different places
    assign bus_addr  = (mem_req_internal) ? (32'h1000 + (CORE_ID * 4)) : 0; 
    
    // Write Data: For STORE instructions, we always want the value from Register 2
    // We also add the CORE_ID just so you can see "0, 1, 2, 3" in the waveform output!
    assign bus_wdata = rdata2 + CORE_ID; 

endmodule