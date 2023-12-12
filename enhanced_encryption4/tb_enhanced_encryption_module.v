`timescale 1ns / 1ps

module tb_enhanced_encryption_module;

parameter N = 8;
reg [N-1:0] data_in;
reg [N-1:0] key;
wire [N-1:0] data_out;
reg [N-1:0] expected_data_out;

enhanced_encryption_module #(N) uut (
    .data_in(data_in),
    .key(key),
    .data_out(data_out)
);

// Function to calculate expected output (Simplified Version)
function [N-1:0] calculate_expected_output;
    input [N-1:0] data;
    input [N-1:0] k;
    integer i;
    reg [N-1:0] intermediate;
    reg [3:0] s_box [0:15]; // Simple S-box
    integer round;
    begin
        // Initialize S-box (example values)
        s_box[0] = 4; s_box[1] = 10; s_box[2] = 9; s_box[3] = 2;
        s_box[4] = 13; s_box[5] = 8; s_box[6] = 0; s_box[7] = 14;
        s_box[8] = 6; s_box[9] = 11; s_box[10] = 1; s_box[11] = 12;
        s_box[12] = 7; s_box[13] = 15; s_box[14] = 5; s_box[15] = 3;

        intermediate = data;
        for (round = 0; round < 3; round = round + 1) begin
            for (i = 0; i < N; i = i + 2) begin
                intermediate[i+:2] = s_box[intermediate[i+:2]];
            end
            intermediate = {intermediate[N-2:0], intermediate[N-1]};
            intermediate = intermediate ^ (k ^ round); // Simplified key expansion
        end
        calculate_expected_output = intermediate;
    end
endfunction

initial begin
    $dumpfile("enhanced_waveform.vcd");
    $dumpvars(0, tb_enhanced_encryption_module);

    // Test vectors
    data_in = 8'b10101010; key = 8'b11001100;
    expected_data_out = calculate_expected_output(data_in, key);
    #10; perform_test();

    data_in = 8'b01010101; key = 8'b00110011;
    expected_data_out = calculate_expected_output(data_in, key);
    #10; perform_test();

    // Add more test vectors as needed...

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
