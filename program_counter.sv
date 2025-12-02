// src/core/program_counter.sv
module program_counter (
    input  logic        clk,
    input  logic        reset,
    input  logic        stall, // From arbiter (wait for memory)
    output logic [31:0] pc_out
);
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            pc_out <= 0;
        else if (!stall)
            pc_out <= pc_out + 4;
    end
endmodule