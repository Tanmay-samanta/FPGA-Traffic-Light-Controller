# FPGA-Based Traffic Light Controller with Priority System

A Verilog design for a 4-way intersection traffic light controller implemented on Xilinx Artix-7 FPGA (xc7a100tftg256-1). Features normal NS/EW cycling and emergency override for NS priority.

## Features
- Green: ~5 seconds, Yellow: ~1 second (1 Hz clock divider from 100 MHz).
- Inputs: Reset (button), Emergency (switch).
- Outputs: 4 LEDs (NS_G, NS_Y, EW_G, EW_Y).

## Tools
- Xilinx Vivado (simulation/synthesis).
- Board: Artix-7 xc7a100tftg256-1.

## Files
- `traffic_light.v`: Core FSM module.
- `tb_traffic_light.v`: Testbench for simulation.
- `TrafficLightController.xdc`: Pin constraints (customize for your board).

## Setup and Run
1. Open in Vivado, set `traffic_light` as top.
2. Simulate: Run Behavioral Simulation.
3. Synthesize > Implement > Generate Bitstream.
4. Program via Hardware Manager.

## License
MIT (or your choice—add details if desired).
