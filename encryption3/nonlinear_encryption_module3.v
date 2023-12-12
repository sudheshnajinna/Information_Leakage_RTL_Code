// nonlinear_encryption_module.v
module nonlinear_encryption_module3 #(parameter N = 8) (
    input wire [N-1:0] data_in,
    input wire [N-1:0] key,
    output reg [N-1:0] data_out
);
    integer i;
    reg [N-1:0] intermediate;

    always @(*) begin
        // First stage: XOR with key and rotate
        for (i = 0; i < N; i = i + 1) begin
            intermediate[i] = data_in[i] ^ key[i];
        end

        // Second stage: Nonlinear transformation
        for (i = 0; i < N; i = i + 1) begin
            data_out[i] = (intermediate[i] + (intermediate[(i+1) % N] & key[i])) % 2;
        end
    end
endmodule
