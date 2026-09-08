`timescale 1ns / 1ps

module tb_delay_demo;

    reg in;
    reg ctrl;
    wire out;

    // Instantiate a tri-state buffer with 3 explicit delays:
    // Rise delay = 4ns
    // Fall delay = 6ns
    // Turn-off delay = 3ns
    // Syntax: bufif1 #(rise, fall, turn_off) instance_name (output, input, control);
    bufif1 #(4, 6, 3) uut (out, in, ctrl);

    initial begin
        // Initialize everything to 0
        in = 0;
        ctrl = 0;
        #10;
        
        // --- 1. OBSERVE RISE DELAY (Transition to 1) ---
        // Enable the buffer, input is 1. Output must transition Z -> 1.
        in = 1;
        ctrl = 1; 
        #10; // Expected output transition at +4ns -> time = 14ns

        // --- 2. OBSERVE FALL DELAY (Transition to 0) ---
        // Keep buffer enabled, drop input to 0. Output must transition 1 -> 0.
        in = 0;
        #10; // Expected output transition at +6ns -> time = 26ns

        // --- 3. OBSERVE TURN-OFF DELAY (Transition to Z) ---
        // Pull input back high, wait for output to stabilize at 1
        in = 1;
        #10; // Stabilizes at 1 at time = 34ns
        
        // Turn off the control signal. Output must transition 1 -> Z.
        ctrl = 0;
        #10; // Expected output transition at +3ns -> time = 43ns

        $finish;
    end

    // Monitor the outputs in the console terminal
    initial begin
        $monitor("Time = %0dns | Control = %b | Input = %b | Output = %b", $time, ctrl, in, out);
    end

endmodule