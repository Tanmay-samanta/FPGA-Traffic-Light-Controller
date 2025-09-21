# Clock (100 MHz oscillator - replace LOC with your board's clock pin)
set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports { clk }];  # Example for Arty A7

# Reset (button - active high, replace LOC)
set_property -dict { PACKAGE_PIN J5 IOSTANDARD LVCMOS33 } [get_ports { reset }];

# Emergency (switch - active high, replace LOC)
set_property -dict { PACKAGE_PIN H5 IOSTANDARD LVCMOS33 } [get_ports { emergency }];

# Outputs to LEDs (replace LOCs)
set_property -dict { PACKAGE_PIN A8 IOSTANDARD LVCMOS33 } [get_ports { NS_G }];   # LED0
set_property -dict { PACKAGE_PIN B8 IOSTANDARD LVCMOS33 } [get_ports { NS_Y }];   # LED1
set_property -dict { PACKAGE_PIN C8 IOSTANDARD LVCMOS33 } [get_ports { EW_G }];   # LED2
set_property -dict { PACKAGE_PIN D8 IOSTANDARD LVCMOS33 } [get_ports { EW_Y }];   # LED3