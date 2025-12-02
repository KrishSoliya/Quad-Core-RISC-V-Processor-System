// src/core/alu.sv
`include "src/include/riscv_defines.svh"

module alu (
    input  logic [31:0] a,
    input  logic [31:0] b,
    input  logic [3:0]  alu_ctrl,
    output logic [31:0] result,
    output logic        zero
);
    always_comb begin
        case (alu_ctrl)
            `ALU_ADD: result = a + b;
            `ALU_SUB: result = a - b;
            `ALU_AND: result = a & b;
            `ALU_OR:  result = a | b;
            `ALU_XOR: result = a ^ b;
            default:  result = 0;
        endcase
    end
    assign zero = (result == 0);
endmodule