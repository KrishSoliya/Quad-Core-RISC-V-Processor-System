// File: sim/tb_quad_core.sv
`timescale 1ns / 1ps

module tb_quad_core;
    // Testbench Signals
    logic clk;
    logic reset;

    // Instantiate the Top Level Design (The Quad-Core System)
    quad_core_top uut (
        .clk(clk), 
        .reset(reset)
    );

    // Clock Generation (100MHz equivalent)
    always #5 clk = ~clk;

    // Simulation Sequence
    initial begin
        // 1. Initialize Signals
        clk = 0;
        reset = 1;
        
        // 2. Setup Waveform Dumping (Crucial for GTKWave)
        $dumpfile("quad_core.vcd");
        $dumpvars(0, tb_quad_core);

        // 3. Apply Reset
        #20;
        reset = 0; // Release reset, let the processor run

        // 4. Run Simulation
        $display("--- Starting Quad-Core Simulation ---");
        $display("Time | Event");
        
        // Let it run for 1000ns (enough for all cores to finish their tasks)
        #1000;
        
        // 5. Finish
        $display("--- Simulation Complete ---");
        $finish;
    end

endmodule