# Create a clock with 100 MHz frequency (10 ns period)
create_clock -period 10.0 [get_ports clock] -name clk

# Input delay constraints (Example for inputs driven by external source)
set_input_delay -clock [get_clocks clk] -max 2.5 [get_ports {reset x}]
set_input_delay -clock [get_clocks clk] -min 0.5 [get_ports {reset x}]

# Output delay constraints (Example for outputs captured by an external destination)
set_output_delay -clock [get_clocks clk] -max 2.5 [get_ports {ready unlock error}]
set_output_delay -clock [get_clocks clk] -min 0.5 [get_ports {ready unlock error}]

# Specify clock uncertainty (jitter, skew, etc.)
set_clock_uncertainty -setup 0.1 [get_clocks clk]
set_clock_uncertainty -hold 0.05 [get_clocks clk]

# Specify design constraints for timing paths
set_max_delay -from [get_ports {reset x}] -to [get_ports {ready unlock error}] 15.0
set_input_delay -clock [get_clocks clk] -add_delay 1.0 [get_ports {reset x}]

# Specify design constraints (e.g., capacitance, load, drive strength)
set_load 0.005 [get_ports {ready unlock error}]

# Additional constraints, such as case analysis or mode settings
# set_case_analysis 1 [get_ports mode]
