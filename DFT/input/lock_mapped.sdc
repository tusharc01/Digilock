# ####################################################################

#  Created by Genus(TM) Synthesis Solution 20.11-s111_1 on Fri Sep 19 18:16:32 IST 2025

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design lock

create_clock -name "clk" -period 10.0 -waveform {0.0 5.0} [get_ports clock]
set_load -pin_load 0.005 [get_ports ready]
set_load -pin_load 0.005 [get_ports unlock]
set_load -pin_load 0.005 [get_ports error]
set_max_delay 15 -from [list [get_ports x] [get_ports reset] ] -to [list [get_ports error] [get_ports unlock] [get_ports ready] ]
set_clock_gating_check -setup 0.0 
set_input_delay -clock [get_clocks clk] -add_delay -max 2.5 [get_ports reset]
set_input_delay -clock [get_clocks clk] -add_delay -max 2.5 [get_ports x]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.5 [get_ports reset]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.5 [get_ports x]
set_output_delay -clock [get_clocks clk] -add_delay -max 2.5 [get_ports ready]
set_output_delay -clock [get_clocks clk] -add_delay -max 2.5 [get_ports unlock]
set_output_delay -clock [get_clocks clk] -add_delay -max 2.5 [get_ports error]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.5 [get_ports ready]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.5 [get_ports unlock]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.5 [get_ports error]
set_input_delay -clock [get_clocks clk] -add_delay 1.0 [get_ports reset]
set_input_delay -clock [get_clocks clk] -add_delay 1.0 [get_ports x]
set_wire_load_mode "enclosed"
set_dont_use true [get_lib_cells tsl18fs120_scl_ff/slbhb2]
set_dont_use true [get_lib_cells tsl18fs120_scl_ff/slbhb1]
set_dont_use true [get_lib_cells tsl18fs120_scl_ff/slbhb4]
set_clock_uncertainty -setup 0.1 [get_clocks clk]
set_clock_uncertainty -hold 0.05 [get_clocks clk]
