module N_Bit_AdderOrSubtracter #(
    parameter NUM_BITS = 8
) (
    input [(NUM_BITS - 1):0] A, B,
    input SelectOperation,
    output [(NUM_BITS - 1):0] S,
    output Cout, Overflow
);

    wire [(NUM_BITS - 1):0] selectedB, sum;

    N_Bit_Multiplexer2To1 select_i(B, ~B, SelectOperation, selectedB);

    N_Bit_Adder #(NUM_BITS) adder(A, selectedB, SelectOperation, sum, Cout);


    assign S = sum;
    assign Overflow = (A[NUM_BITS - 1] & selectedB[NUM_BITS - 1] & ~sum[NUM_BITS - 1]) | (~(A[NUM_BITS - 1] | selectedB[NUM_BITS - 1]) & sum[NUM_BITS - 1]);

endmodule
