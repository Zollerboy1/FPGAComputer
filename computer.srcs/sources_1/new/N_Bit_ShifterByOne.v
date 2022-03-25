module N_Bit_ShifterByOne #(
    parameter NUM_BITS = 8
) (
    input [(NUM_BITS - 1):0] A,
    input SelectDirection,
    output [(NUM_BITS - 1):0] O
);

    wire [(NUM_BITS - 1):0] shiftedLeft, shiftedRight;


    assign shiftedLeft[0] = 1'b0;
    assign shiftedLeft[(NUM_BITS - 1):1] = A[(NUM_BITS - 2):0];

    assign shiftedRight[(NUM_BITS - 2):0] = A[(NUM_BITS - 1):1];
    assign shiftedRight[NUM_BITS - 1] = 1'b0;


    N_Bit_Multiplexer2To1 #(NUM_BITS) select(shiftedLeft, shiftedRight, SelectDirection, O);

endmodule
