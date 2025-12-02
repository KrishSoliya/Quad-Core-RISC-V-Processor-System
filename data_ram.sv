// src/memory/data_ram.sv
module data_ram (
    input  logic        clk,
    input  logic        we,
    input  logic [31:0] addr,
    input  logic [31:0] wdata,
    output logic [31:0] rdata
);
    // 1KB Shared Memory
    logic [31:0] mem [0:255];

    // Synchronous Write
    always_ff @(posedge clk) begin
        if (we) begin
            mem[addr[9:2]] <= wdata;
            $display("RAM: Write at %h, Data: %h", addr, wdata);
        end
    end

    // Asynchronous Read
    assign rdata = mem[addr[9:2]];

endmodule