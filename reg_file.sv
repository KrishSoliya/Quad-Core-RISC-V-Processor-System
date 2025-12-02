// src/core/reg_file.sv
module reg_file (
    input  logic        clk,
    input  logic        we,
    input  logic [4:0]  rs1,
    input  logic [4:0]  rs2,
    input  logic [4:0]  rd,
    input  logic [31:0] wdata,
    output logic [31:0] rdata1,
    output logic [31:0] rdata2
);
    logic [31:0] regs [0:31];

    always_ff @(posedge clk) begin
        if (we && rd != 0) begin
            regs[rd] <= wdata;
        end
    end

    assign rdata1 = (rs1 == 0) ? 0 : regs[rs1];
    assign rdata2 = (rs2 == 0) ? 0 : regs[rs2];
endmodule