// secure_encryption_module.v
module secure_encryption_module #(parameter N = 8) (
    input wire [N-1:0] data_in,
    input wire [N-1:0] key,
    output reg [N-1:0] data_out
);
    integer i;

    always @(*) begin
        for (i = 0; i < N; i = i + 1) begin
            if (key[i] == 1'b1)
                data_out[i] = (data_in[i] << 1) ^ key[i];  // Double and XOR with key bit if key bit is 1
            else
                data_out[i] = (data_in[i] * 3) ^ key[i];  // Multiply by 3 and XOR with key bit if key bit is 0
        end
    end
endmodule
