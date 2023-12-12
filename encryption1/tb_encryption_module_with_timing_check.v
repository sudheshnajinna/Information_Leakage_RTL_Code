// tb_encryption_module_with_timing_check.v
`timescale 1ns / 1ps

module tb_encryption_module_with_timing_check;

parameter N = 8;
reg [N-1:0] data_in;
reg [N-1:0] key;
wire [N-1:0] data_out;
reg [N-1:0] expected_data_out;

// Assume the propagation delay should not exceed this value (for example 3 ns)
parameter MAX_PROPAGATION_DELAY = 3;

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

// Task to perform the checking
task perform_check;
    input [N-1:0] data, k, expected_output;
    begin
        data_in = data; 
        key = k; 
        expected_data_out = expected_output;
        #10; // Wait for the output to settle
        if (data_out !== expected_data_out) begin
            $display("Error: Output does not match expected value at time %t.", $time);
            $display("Input: %b, Key: %b, Actual Output: %b, Expected Output: %b", data_in, key, data_out, expected_data_out);
            $finish;
        end
        #MAX_PROPAGATION_DELAY;
        if (data_out !== expected_data_out) begin
            $display("Timing issue detected at time %t.", $time);
            $display("Input: %b, Key: %b, Actual Output: %b, Expected Output: %b", data_in, key, data_out, expected_data_out);
            $finish;
        end
    end
endtask

initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, tb_encryption_module_with_timing_check);

    // Apply test vectors and perform checks
    perform_check(8'b10101010, 8'b11001100, calculate_expected_output(8'b10101010, 8'b11001100));
    perform_check(8'b01010101, 8'b00110011, calculate_expected_output(8'b01010101, 8'b00110011));
    perform_check(8'b00000000, 8'b11111111, calculate_expected_output(8'b00000000, 8'b11111111));
    perform_check(8'b11111111, 8'b00000000, calculate_expected_output(8'b11111111, 8'b00000000));

    // Add more test vectors as needed...

    $display("All tests passed with no errors or timing issues detected.");
    $finish;
end

endmodule
