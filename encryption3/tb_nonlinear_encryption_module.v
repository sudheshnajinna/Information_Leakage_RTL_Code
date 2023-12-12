// tb_nonlinear_encryption_module.v
`timescale 1ns / 1ps

module tb_nonlinear_encryption_module;

parameter N = 8;
reg [N-1:0] data_in;
reg [N-1:0] key;
wire [N-1:0] data_out;
reg [N-1:0] expected_data_out;

nonlinear_encryption_module3 #(N) uut (
    .data_in(data_in),
    .key(key),
    .data_out(data_out)
);

function [N-1:0] calculate_expected_output;
    input [N-1:0] data;
    input [N-1:0] k;
    integer i;
    reg [N-1:0] intermediate;
    begin
        for (i = 0; i < N; i = i + 1) begin
            intermediate[i] = data[i] ^ k[i];
        end
        for (i = 0; i < N; i = i + 1) begin
            calculate_expected_output[i] = (intermediate[i] + (intermediate[(i+1) % N] & k[i])) % 2;
        end
    end
endfunction

initial begin
    $dumpfile("nonlinear_waveform.vcd");
    $dumpvars(0, tb_nonlinear_encryption_module);

    // Test Vector 1
    data_in = 8'b10101010; 
    key = 8'b11111111; 
    expected_data_out = calculate_expected_output(data_in, key);    
    #10; 
    perform_test();

    // Test Vector 2
    data_in = 8'b01010101; 
    key = 8'b00000000; 
    expected_data_out = calculate_expected_output(data_in, key);    
    #10; 
    perform_test();

    // Test Vector 3
    data_in = 8'b00000000; 
    key = 8'b10101010; 
    expected_data_out = calculate_expected_output(data_in, key);    
    #10; 
    perform_test();

    // Test Vector 4
    data_in = 8'b11111111; 
    key = 8'b01010101; 
    expected_data_out = calculate_expected_output(data_in, key);    
    #10; 
    perform_test();

    // Test Vector 5
    data_in = 8'b00011011; 
    key = 8'b10101010; 
    expected_data_out = calculate_expected_output(data_in, key);    
    #10; 
    perform_test();

    // Test Vector 6
    data_in = 8'b10010110; 
    key = 8'b01100101; 
    expected_data_out = calculate_expected_output(data_in, key);    
    #10; 
    perform_test();

    // Test Vector 7
    data_in = 8'b00000001; 
    key = 8'b01010101; 
    expected_data_out = calculate_expected_output(data_in, key);    
    #10; 
    perform_test();

    // Test Vector 8
    data_in = 8'b00000010; 
    key = 8'b01010101; 
    expected_data_out = calculate_expected_output(data_in, key);    
    #10; 
    perform_test();

    $display("All tests passed.");
    $finish;
end

task perform_test;
    begin
        $display("Time: %t, Input: %b, Key: %b, Output: %b, Expected: %b", 
                 $time, data_in, key, data_out, expected_data_out);
        if (data_out !== expected_data_out) begin
            $display("Error: Output does not match expected value.");
            $finish;
        end
    end
endtask

endmodule
