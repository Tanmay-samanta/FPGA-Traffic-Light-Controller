`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.09.2025 16:13:21
// Design Name: 
// Module Name: tb_traffic_light
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////




module tb_traffic_light;
    reg clk = 0;
    reg reset = 0;
    reg emergency = 0;
    wire NS_G, NS_Y, EW_G, EW_Y;

    // Instantiate the Unit Under Test (UUT)
    traffic_light uut (
        .clk(clk),
        .reset(reset),
        .emergency(emergency),
        .NS_G(NS_G),
        .NS_Y(NS_Y),
        .EW_G(EW_G),
        .EW_Y(EW_Y)
    );

    // Clock generation: 10 ns period (100 MHz)
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        reset = 1;
        emergency = 0;

        // Reset for 2 cycles
        #20;
        reset = 0;

        // Normal cycle: Run for 12 cycles (~12 seconds at 1 Hz)
        #12000;  // 12 cycles at 1 kHz (scaled down for sim; adjust if needed)

        // Trigger emergency
        emergency = 1;
        #6000;   // 6 cycles (~6 seconds at 1 Hz)

        // Clear emergency
        emergency = 0;
        #12000;  // 12 cycles (~12 seconds at 1 Hz)

        // End simulation
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%0t | Reset=%b | Emergency=%b | NS_G=%b NS_Y=%b | EW_G=%b EW_Y=%b", $time, reset, emergency, NS_G, NS_Y, EW_G, EW_Y);
    end

endmodule