// src/memory/instruction_rom.sv
module instruction_rom (
    input  logic [31:0] addr,
    output logic [31:0] instruction
);
    // Fix: Create a temporary wire for the slice to make Icarus happy
    logic [5:0] addr_index;
    assign addr_index = addr[5:0];

    // Simple hardcoded program
    always_comb begin
        case (addr_index) 
            6'd0:  instruction = 32'h00100093; // ADDI x1, x0, 1
            6'd4:  instruction = 32'h00200113; // ADDI x2, x0, 2
            6'd8:  instruction = 32'h002081b3; // ADD  x3, x1, x2
            6'd12: instruction = 32'h00302023; // SW   x3, 0(x0) <-- WRITE TO SHARED MEM
            6'd16: instruction = 32'h00000033; // ADD x0, x0, x0 (NOP)
            default: instruction = 32'h00000013; // NOP
        endcase
    end
endmodule