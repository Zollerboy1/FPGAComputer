module N_Bit_BusTransceiver #(
    parameter NUM_BITS = 8
) (
    input [(NUM_BITS - 1):0] D,
    input Enable,
    output [(NUM_BITS - 1):0] Q
);

    genvar i;

    generate
        for (i = 0; i < NUM_BITS; i = i + 1) begin
            TriStateBuffer buffer_i(D[i], Enable, Q[i]);
        end
    endgenerate

endmodule
