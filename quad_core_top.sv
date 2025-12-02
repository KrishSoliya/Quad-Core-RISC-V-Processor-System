// src/interconnect/quad_core_top.sv
module quad_core_top (
    input logic clk,
    input logic reset
);
    // Interconnect Signals
    logic [3:0] reqs, grants;
    logic [3:0] we_sigs;
    logic [31:0] addrs [3:0];
    logic [31:0] wdatas [3:0];

    // Bus -> Memory Signals
    logic [31:0] bus_addr, bus_wdata;
    logic bus_we;

    // 1. Instantiate 4 Cores
    genvar i;
    generate
        for (i=0; i<4; i++) begin : cores
            riscv_core_single #(.CORE_ID(i)) core_inst (
                .clk(clk), .reset(reset),
                .bus_grant(grants[i]),
                .bus_req(reqs[i]), .bus_we(we_sigs[i]),
                .bus_addr(addrs[i]), .bus_wdata(wdatas[i])
            );
        end
    endgenerate

    // 2. Arbiter
    round_robin_arbiter arb_inst (
        .clk(clk), .reset(reset), .req(reqs), .grant(grants)
    );

    // 3. Mux
    bus_mux mux_inst (
        .grant(grants),
        .addr0(addrs[0]), .data0(wdatas[0]), .we0(we_sigs[0]),
        .addr1(addrs[1]), .data1(wdatas[1]), .we1(we_sigs[1]),
        .addr2(addrs[2]), .data2(wdatas[2]), .we2(we_sigs[2]),
        .addr3(addrs[3]), .data3(wdatas[3]), .we3(we_sigs[3]),
        .mem_addr(bus_addr), .mem_wdata(bus_wdata), .mem_we(bus_we)
    );

    // 4. Shared Data RAM
    data_ram shared_mem (
        .clk(clk), .we(bus_we), .addr(bus_addr), 
        .wdata(bus_wdata), .rdata()
    );

endmodule