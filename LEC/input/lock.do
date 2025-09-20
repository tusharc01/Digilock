// Read the TSMC 180nm library
read library -Both -Replace -sensitive -Statetable -Liberty tsl18fs120_scl_ff.lib -nooptimize

// Read golden (RTL) design
read design lock.v -Verilog -Golden -sensitive -continuousassignment Bidirectional -nokeep_unreach -nosupply

// Read revised (netlist) design
read design lock_netlist.v -Verilog -Revised -sensitive -continuousassignment Bidirectional -nokeep_unreach -nosupply

// Set setup mode and root module
set system mode lec

// Set LEC mode and compare
add compared points -all

// Exit
exit
