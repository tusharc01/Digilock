# Set search paths
set_db init_lib_search_path /home/nitrkl05/Desktop/Lock/DFT
set_db init_hdl_search_path /home/nitrkl05/Desktop/Lock/DFT

# Read libraries
read_libs tsl18fs120_scl_ff.lib

# Read netlist (post-synthesis)
read_hdl lock_netlist.v

# Elaborate design
elaborate

# Read timing constraints
read_sdc /home/nitrkl05/Desktop/Lock/DFT/lock_mapped.sdc

# DFT configuration
set_db dft_scan_style muxed_scan
set_db dft_prefix dft_
define_shift_enable -name SE -active high -create_port SE
check_dft_rules

# Synthesis steps
set_db syn_generic_effort medium
syn_generic
set_db syn_map_effort medium
syn_map
set_db syn_opt_effort medium
syn_opt

# Check DFT rules again
check_dft_rules

# REMOVE THE PROBLEMATIC LINE AND USE THIS INSTEAD:
# Define scan chain with auto-creation (Genus will determine optimal number)
define_scan_chain -name top_chain -sdi scan_in -sdo scan_out -create_ports

# Connect scan chains - let Genus determine the number automatically
connect_scan_chains -auto_create_chains
syn_opt -incr

# Generate reports
report_scan_chains

# Write outputs
write_dft_atpg -library /home/nitrkl05/Desktop/Lock/DFT/tsl18fs120_scl_ff.lib
write_hdl > lock_netlist_dft.v
write_sdc > lock_sdc_dft.sdc
write_sdf -nonegchecks -edges check_edge -timescale ns -recrem split -setuphold split > dft_delays.sdf
write_scandef > lock_fsm_scanDEF.scandef

# Show GUI
gui_show
