// encryption_module.v
module encryption_module #(parameter N = 8) (
    input wire [N-1:0] data_in,
    input wire [N-1:0] key,
    output reg [N-1:0] data_out
);
    integer i;
    
    // Perform encryption operation
    always @(*) begin
        for (i = 0; i < N; i = i + 1) begin
            if (key[i] == 1'b1)
                data_out[i] = data_in[i] << 1;  // Double if key bit is 1
            else
                data_out[i] = data_in[i];       // No change if key bit is 0 (Information leakage here)
        end
    end
endmodule
