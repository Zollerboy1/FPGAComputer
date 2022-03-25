module N_Bit_Multiplexer2To1 #(
    parameter NUM_BITS = 8
) (
    input [(NUM_BITS - 1):0] A, B,
    input S,
    output [(NUM_BITS - 1):0] O
);

    genvar i;
    
    generate
        for (i = 0; i < NUM_BITS; i = i + 1) begin
            assign O[i] = (A[i] & ~S) | (B[i] & S);
        end
    endgenerate

endmodule
