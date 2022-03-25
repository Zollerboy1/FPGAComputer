module ALUTest(
    input [5:0] A, B,
    input [3:0] Select,
    output [5:0] O,
    output CarryFlag, ZeroFlag, OverflowFlag
);

    N_Bit_ALU #(6) alu(A, B, Select, O, CarryFlag, ZeroFlag, OverflowFlag);

endmodule
