// tb_encryption_module.v
`timescale 1ns / 1ps

module tb_encryption_module;

parameter N = 8;
reg [N-1:0] data_in;
reg [N-1:0] key;
wire [N-1:0] data_out;
reg [N-1:0] expected_data_out;

encryption_module #(N) uut (
    .data_in(data_in),
    .key(key),
    .data_out(data_out)
);

// Function to calculate expected output
function [N-1:0] calculate_expected_output;
    input [N-1:0] data;
    input [N-1:0] k;
    integer i;
    begin
        for (i = 0; i < N; i = i + 1) begin
            calculate_expected_output[i] = k[i] ? data[i] << 1 : data[i];
        end
    end
endfunction

initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, tb_encryption_module);

    // Test vector 1: Alternating 1s and 0s, with alternating key
    data_in = 8'b10101010; 
    key = 8'b11001100; 
    expected_data_out = calculate_expected_output(data_in, key);    
    #10; 
    $display("Time: %t, Input: %b, Key: %b, Output: %b, Expected: %b", $time, data_in, key, data_out, expected_data_out);
    if (data_out !== expected_data_out) begin
        $display("Error: Output does not match expected value.");
        $finish;
    end

    // Test vector 2: Alternating 0s and 1s, with alternating key
    data_in = 8'b01010101; 
    key = 8'b00110011; 
    expected_data_out = calculate_expected_output(data_in, key);    
    #10; 
    $display("Time: %t, Input: %b, Key: %b, Output: %b, Expected: %b", $time, data_in, key, data_out, expected_data_out);
    if (data_out !== expected_data_out) begin
        $display("Error: Output does not match expected value.");
        $finish;
    end

    // Test vector 3: All 0s
    data_in = 8'b00000000; 
    key = 8'b11111111; 
    expected_data_out = calculate_expected_output(data_in, key);    
    #10; 
    $display("Time: %t, Input: %b, Key: %b, Output: %b, Expected: %b", $time, data_in, key, data_out, expected_data_out);
    if (data_out !== expected_data_out) begin
        $display("Error: Output does not match expected value.");
        $finish;
    end

    // Test vector 4: All 1s
    data_in = 8'b11111111; 
    key = 8'b00000000; 
    expected_data_out = calculate_expected_output(data_in, key);    
    #10; 
    $display("Time: %t, Input: %b, Key: %b, Output: %b, Expected: %b", $time, data_in, key, data_out, expected_data_out);
    if (data_out !== expected_data_out) begin
        $display("Error: Output does not match expected value.");
        $finish;
    end

    // Add more test vectors as needed...

    $display("All tests passed.");
    $finish;
end

endmodule
