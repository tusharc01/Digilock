// Read the TSMC 180nm library
read library -Both -Replace -sensitive -Statetable -Liberty tsl18fs120_scl_ff.lib

// Read golden (RTL) design
read design lock.v -Verilog -Golden -sensitive -continuousassignment Bidirectional -nokeep_unreach -nosupply

// Read revised (netlist) design
read design lock_netlist_dft.v -Verilog -Revised -sensitive -continuousassignment Bidirectional -nokeep_unreach -nosupply

// First set system to SETUP mode for configuration commands
set system mode setup

// Handle DFT pins - These commands only work in SETUP mode
add ignored inputs SE -Revised
add ignored inputs scan_in -Revised
add ignored outputs scan_out -Revised

// Set analysis options
set flatten model -seq_constant

// Now switch to LEC mode for comparison
set system mode lec

// Add compared points
add compared points -all

// Run comparison
compare

// If there are non-equivalent points, analyze them
analyze datapath -verbose
analyze setup -verbose
