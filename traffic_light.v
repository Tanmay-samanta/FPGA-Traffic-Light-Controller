`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.09.2025 16:12:19
// Design Name: 
// Module Name: traffic_light
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


module traffic_light (
    input clk,          // 100 MHz clock (divided internally)
    input reset,        // Active high reset
    input emergency,    // Active high emergency override (for NS priority)
    output reg NS_G,    // NS Green
    output reg NS_Y,    // NS Yellow
    output reg EW_G,    // EW Green
    output reg EW_Y     // EW Yellow
);

// Parameters for timing (in divided clock cycles, ~1 Hz after divider)
parameter GREEN_TIME = 5;   // 5 seconds green
parameter YELLOW_TIME = 1;  // 1 second yellow

// Clock divider: Divide 100 MHz to ~1 Hz (100M cycles per second)
reg [26:0] clk_div_counter = 0;
reg clk_1hz = 0;
always @(posedge clk) begin
    if (clk_div_counter == 27'd100000000 - 1) begin
        clk_div_counter <= 0;
        clk_1hz <= ~clk_1hz;
    end else begin
        clk_div_counter <= clk_div_counter + 1;
    end
end

// FSM registers
reg [1:0] state = 0, next_state = 0;
reg [3:0] counter = 0;  // Counter for state timing (max 15 cycles)

// State definitions
localparam S_NS_GREEN = 2'd0;
localparam S_NS_YELLOW = 2'd1;
localparam S_EW_GREEN = 2'd2;
localparam S_EW_YELLOW = 2'd3;

// Sequential logic: State update and counter
always @(posedge clk_1hz or posedge reset) begin
    if (reset) begin
        state <= S_NS_GREEN;
        counter <= 0;
    end else begin
        state <= next_state;
        if (next_state != state) begin
            counter <= 0;
        end else begin
            counter <= counter + 1;
        end
    end
end

// Combinational logic: Next state
always @(*) begin
    next_state = state;
    case (state)
        S_NS_GREEN:   if (counter == GREEN_TIME - 1) next_state = S_NS_YELLOW;
        S_NS_YELLOW:  if (counter == YELLOW_TIME - 1) next_state = S_EW_GREEN;
        S_EW_GREEN:   if (counter == GREEN_TIME - 1) next_state = S_EW_YELLOW;
        S_EW_YELLOW:  if (counter == YELLOW_TIME - 1) next_state = S_NS_GREEN;
        default:      next_state = S_NS_GREEN;
    endcase
end

// Output logic: Normal FSM outputs, overridden by emergency
always @(*) begin
    NS_G = 0; NS_Y = 0; EW_G = 0; EW_Y = 0;
    if (emergency) begin
        // Emergency override: NS Green (priority), others off (red)
        NS_G = 1;
    end else begin
        case (state)
            S_NS_GREEN:   NS_G = 1;
            S_NS_YELLOW:  NS_Y = 1;
            S_EW_GREEN:   EW_G = 1;
            S_EW_YELLOW:  EW_Y = 1;
            default:      NS_G = 1;  // Default to NS Green
        endcase
    end
end

endmodule