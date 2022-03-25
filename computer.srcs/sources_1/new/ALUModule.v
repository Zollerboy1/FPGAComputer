// Select:
//     - 0000: A + B    (Addition)
//     - 0001: A - B    (Subtraction)
//     - 0010: A + 1    (Increment)
//     - 0011: A - 1    (Decrement)
//     - 0100: A & B    (Bitwise And)
//     - 0101: A | B    (Bitwise Or)
//     - 0110: A ^ B    (Bitwise Xor)
//     - 0111: ~A       (Ones' Complement)
//     - 1000: A << B   (Logical Shift Left)
//     - 1001: A >> B   (Logical Shift Right)
//     - 1010: A <<< B  (Arithmetic Shift Left)
//     - 1011: A >>> B  (Arithmetic Shift Right)
//     - 1100: A > B    (Greater Than)
//     - 1101: A == B   (Equal)
//     - 1110: A        (Pass Through A)
//     - 1111: B        (Pass Through B)

module ALUModule(
    input [7:0] RegisterA, RegisterB,
    input [3:0] ALUSelect,
    input Clock, ALUOutputEnable, FlagsEnable, Reset,
    output [7:0] Bus,
    output CarryFlag, ZeroFlag, OverflowFlag
);

    wire [7:0] internalBus;
    wire carryFlag, zeroFlag, overflowFlag;

    N_Bit_ALU #(8) alu(
        .A(RegisterA),
        .B(RegisterB),
        .Select(ALUSelect),
        .O(internalBus),
        .CarryFlag(carryFlag),
        .ZeroFlag(zeroFlag),
        .OverflowFlag(overflowFlag)
    );


    N_Bit_BusTransceiver #(8) transceiver(internalBus, ALUOutputEnable, Bus);


    N_Bit_Register #(3) flagsRegister(
        .D({carryFlag, zeroFlag, overflowFlag}),
        .Clock(Clock),
        .Enable(FlagsEnable),
        .Reset(Reset),
        .Q({CarryFlag, ZeroFlag, OverflowFlag})
    );


endmodule
