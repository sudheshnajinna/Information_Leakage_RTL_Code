module enhanced_encryption_module #(parameter N = 8) (
    input wire [N-1:0] data_in,
    input wire [N-1:0] key,
    output reg [N-1:0] data_out
);
    integer i;
    reg [N-1:0] round_key;
    reg [N-1:0] state;
    reg [N-1:0] s_box [0:15]; // Simple S-box
    integer round;

    // Initialize S-box (example values)
    initial begin
        s_box[0] = 4; s_box[1] = 10; s_box[2] = 9; s_box[3] = 2;
        s_box[4] = 13; s_box[5] = 8; s_box[6] = 0; s_box[7] = 14;
        s_box[8] = 6; s_box[9] = 11; s_box[10] = 1; s_box[11] = 12;
        s_box[12] = 7; s_box[13] = 15; s_box[14] = 5; s_box[15] = 3;
    end

    // Key expansion (simplified)
    function [N-1:0] expand_key;
        input [N-1:0] k, round;
        begin
            expand_key = k ^ round; // Simple XOR with round number for demonstration
        end
    endfunction

    // Perform encryption
    always @(*) begin
        state = data_in;
        for (round = 0; round < 3; round = round + 1) begin
            // Substitution step using S-box
            for (i = 0; i < N; i = i + 2) begin
                state[i+:2] = s_box[state[i+:2]];
            end
            
            // Permutation step (bitwise rotation)
            state = {state[N-2:0], state[N-1]};
            
            // Add round key
            round_key = expand_key(key, round);
            state = state ^ round_key;
        end
        data_out = state;
    end
endmodule
