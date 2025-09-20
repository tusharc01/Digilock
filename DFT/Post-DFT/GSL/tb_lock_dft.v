`timescale 1ns/1ps

module testbench;
    reg         clock;      // Free running clock
    reg         reset;      // Reset active high
    reg         x;          // Input - X
    wire        ready;      // Output - ready for combination
    wire        unlock;     // Output - unlocked
    wire        error;      // Output - error in combination
    
    // DFT signals
    reg         SE;         // Scan Enable
    reg         scan_in;    // Scan Input
    wire        scan_out;   // Scan Output

    // Instantiate the DFT netlist
    lock u1 (
        .clock(clock),
        .reset(reset),
        .x(x),
        .ready(ready),
        .unlock(unlock),
        .error(error),
        .SE(SE),           // DFT scan enable
        .scan_in(scan_in), // DFT scan input
        .scan_out(scan_out) // DFT scan output
    );

    always
        #5 clock = ~clock;

    initial begin
        // Initialize all signals
        clock = 0;
        reset = 0;
        x = 0;
        SE = 0;        // Normal functional mode
        scan_in = 0;   // Default scan input
        
        // Apply reset
        #1 reset = 1;
        #9 reset = 0;

        #30                 // Wait to make sure system is idle

        // Test good sequence
        x = 1;
        #10 x = 0;
        #10 x = 1;
        #10 x = 0;
        #10 x = 1;
        #10 x = 1;

        // Test to see if stays unlocked and then returns to ready
        #30 x = 0;

        // Test 1011 which should go into error on the fourth digit
        #30 x = 1;
        #10 x = 0;
        #10 x = 1;
        #10 x = 1;

        // Stay in error until x -> 0
        #30 x = 0;

        // Wait in ready and test error on a zero
        #30 x = 1;
        #10 x = 0;
        #10 x = 1;
        #10 x = 0;  

        #30 $finish;
    end

    // Optional: Monitor signals for debugging
    initial begin
        $monitor("Time=%0t: reset=%b, x=%b, ready=%b, unlock=%b, error=%b, SE=%b, scan_out=%b", 
                 $time, reset, x, ready, unlock, error, SE, scan_out);
    end
   
endmodule
