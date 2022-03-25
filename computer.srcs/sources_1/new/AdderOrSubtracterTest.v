module AdderOrSubtracterTest(
    input [5:0] A, B,
    input SelectOperation,
    output [6:0] S
);

    N_Bit_AdderOrSubtracter #(6) adder(A, B, SelectOperation, S[5:0], S[6]);

endmodule
