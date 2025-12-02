// src/core/decoder.sv
`include "src/include/riscv_defines.svh"

module decoder (
    input  logic [31:0] instr,
    output logic        reg_write,
    output logic        mem_write,
    output logic        mem_req,
    output logic [3:0]  alu_ctrl
);
    wire [6:0] opcode = instr[6:0];

    always_comb begin
        // Defaults
        reg_write = 0; mem_write = 0; mem_req = 0; alu_ctrl = 0;

        case (opcode)
            `OP_R_TYPE: begin reg_write = 1; alu_ctrl = `ALU_ADD; end
            `OP_IMM:    begin reg_write = 1; alu_ctrl = `ALU_ADD; end
            `OP_STORE:  begin mem_write = 1; mem_req = 1; alu_ctrl = `ALU_ADD; end
            `OP_LOAD:   begin reg_write = 1; mem_req = 1; alu_ctrl = `ALU_ADD; end
        endcase
    end
endmodule