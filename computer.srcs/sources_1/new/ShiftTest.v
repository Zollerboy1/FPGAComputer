module ShiftTest(
    input [7:0] A,
    input [7:0] B,
    input SelectDirection,
    output [7:0] O,
    output Overflow
);

    N_Bit_ArithmeticBarrelShifter #(8) shifter(A, B, SelectDirection, O, Overflow);

endmodule
