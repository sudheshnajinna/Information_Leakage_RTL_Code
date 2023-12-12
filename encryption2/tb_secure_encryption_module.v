`timescale 1ns / 1ps

module tb_secure_encryption_module;

parameter N = 8;
reg [N-1:0] data_in;
reg [N-1:0] key;
wire [N-1:0] data_out;

// Instantiate the secure encryption module
secure_encryption_module #(N) uut (
    .data_in(data_in),
    .key(key),
    .data_out(data_out)
);

initial begin
    // Setup the waveform dump file
    $dumpfile("secure_waveform.vcd");
    $dumpvars(0, tb_secure_encryption_module);
    
    // Test case 1
    data_in = 8'b10101010;  // Example input
    key = 8'b11001100;      // Example key
    #10;  // Wait for 10 time units
    $display("Time: %t, Input: %b, Key: %b, Output: %b", $time, data_in, key, data_out);

    // Test case 2
    data_in = 8'b01010101;  // Another input
    key = 8'b00110011;      // Another key
    #10;  // Wait for 10 time units
    $display("Time: %t, Input: %b, Key: %b, Output: %b", $time, data_in, key, data_out);

    // Add more test cases as needed

    $finish;  // End the simulation
end

endmodule
