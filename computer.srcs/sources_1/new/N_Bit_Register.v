module N_Bit_Register #(
    parameter NUM_BITS = 8
) (
    input [(NUM_BITS - 1):0] D,
    input Clock, Enable, Reset,
    output [(NUM_BITS - 1):0] Q
);

    genvar i;

    generate
        for (i = 0; i < NUM_BITS; i = i + 1) begin
            DFlipFlop register(
                .D(D[i]),
                .Clock(Clock),
                .Enable(Enable),
                .Reset(Reset),
                .Q(Q[i])
            );
        end
    endgenerate
    
endmodule
