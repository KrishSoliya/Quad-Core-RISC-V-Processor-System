// src/memory/memory_interface.sv
module memory_interface (
    input  logic        req,
    input  logic        we,
    input  logic [31:0] addr,
    input  logic [31:0] wdata,
    // To RAM
    output logic        ram_we,
    output logic [31:0] ram_addr,
    output logic [31:0] ram_wdata
);
    // Simple pass-through buffer
    assign ram_we    = req & we;
    assign ram_addr  = addr;
    assign ram_wdata = wdata;
endmodule