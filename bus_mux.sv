// src/interconnect/bus_mux.sv
module bus_mux (
    input  logic [3:0]  grant,     // One-hot grant signal
    // Core 0
    input  logic [31:0] addr0, data0, input logic we0,
    // Core 1
    input  logic [31:0] addr1, data1, input logic we1,
    // Core 2
    input  logic [31:0] addr2, data2, input logic we2,
    // Core 3
    input  logic [31:0] addr3, data3, input logic we3,
    
    // Output to Memory
    output logic [31:0] mem_addr,
    output logic [31:0] mem_wdata,
    output logic        mem_we
);
    always_comb begin
        // Defaults
        mem_addr = 0; mem_wdata = 0; mem_we = 0;

        // Use case statement to avoid "constant select" errors
        case (grant)
            4'b0001: begin // Grant Core 0
                mem_addr = addr0; mem_wdata = data0; mem_we = we0;
            end
            4'b0010: begin // Grant Core 1
                mem_addr = addr1; mem_wdata = data1; mem_we = we1;
            end
            4'b0100: begin // Grant Core 2
                mem_addr = addr2; mem_wdata = data2; mem_we = we2;
            end
            4'b1000: begin // Grant Core 3
                mem_addr = addr3; mem_wdata = data3; mem_we = we3;
            end
            default: begin
                mem_addr = 0; mem_wdata = 0; mem_we = 0;
            end
        endcase
    end
endmodule