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
module N_Bit_ALU #(
    parameter NUM_BITS = 8
) (
    input [(NUM_BITS - 1):0] A, B,
    input [3:0] Select,
    output [(NUM_BITS - 1):0] O,
    output CarryFlag, ZeroFlag, OverflowFlag
);

    wire [(NUM_BITS - 1):0] aIsGreater, equal;
    wire [(NUM_BITS - 1):0] addOrSubtract, incrementOrDecrement, andOrOr, xorOrNot, logicalShift, arithmeticShift, comparison, passThrough;
    wire [(NUM_BITS - 1):0] arithmetic, bitwise, shift, comparisonOrPassThrough;
    wire [(NUM_BITS - 1):0] arithmeticOrBitwise, shiftOrComparisonOrPassThrough;
    wire [(NUM_BITS - 1):0] out;

    wire addOrSubtractCarry, incrementOrDecrementCarry;
    wire arithmeticCarry;
    wire arithmeticOrBitwiseCarry;
    wire addOrSubtractOverflow, incrementOrDecrementOverflow, arithmeticShiftOverflow;
    wire arithmeticOverflow, shiftOverflow;
    wire arithmeticOrBitwiseOverflow, shiftOrComparisonOrPassThroughOverflow;
    
    wire _unused;

    assign aIsGreater[(NUM_BITS - 1):1] = {(NUM_BITS - 1){1'b0}};
    assign equal[(NUM_BITS - 1):1] = {(NUM_BITS - 1){1'b0}};

    N_Bit_AdderOrSubtracter #(NUM_BITS) adderOrSubtracter(
        .A(A),
        .B(B),
        .SelectOperation(Select[0]),
        .S(addOrSubtract),
        .Cout(addOrSubtractCarry),
        .Overflow(addOrSubtractOverflow)
    );
    N_Bit_AdderOrSubtracter #(NUM_BITS) incrementerOrDecrementer(
        .A(A),
        .B({{(NUM_BITS - 1){1'b0}}, 1'b1}),
        .SelectOperation(Select[0]),
        .S(incrementOrDecrement),
        .Cout(incrementOrDecrementCarry),
        .Overflow(incrementOrDecrementOverflow)
    );

    N_Bit_Multiplexer2To1 #(NUM_BITS) selectAndOrOr(A & B, A | B, Select[0], andOrOr);
    N_Bit_Multiplexer2To1 #(NUM_BITS) selectXorOrNot(A ^ B, ~A, Select[0], xorOrNot);

    N_Bit_BarrelShifter #(NUM_BITS) logicalShifter(A, B, Select[0], logicalShift);
    N_Bit_ArithmeticBarrelShifter #(NUM_BITS) arithmeticShifter(A, B, Select[0], arithmeticShift, arithmeticShiftOverflow);

    N_Bit_Comparator #(NUM_BITS) comparator(A, B, aIsGreater[0], equal[0], _unused);
    N_Bit_Multiplexer2To1 #(NUM_BITS) selectComparison(aIsGreater, equal, Select[0], comparison);

    N_Bit_Multiplexer2To1 #(NUM_BITS) selectPassThrough(A, B, Select[0], passThrough);


    N_Bit_Multiplexer2To1 #(NUM_BITS) selectArithmetic(addOrSubtract, incrementOrDecrement, Select[1], arithmetic);
    N_Bit_Multiplexer2To1 #(NUM_BITS) selectBitwise(andOrOr, xorOrNot, Select[1], bitwise);
    N_Bit_Multiplexer2To1 #(NUM_BITS) selectShift(logicalShift, arithmeticShift, Select[1], shift);
    N_Bit_Multiplexer2To1 #(NUM_BITS) selectComparisonOrPassThrough(comparison, passThrough, Select[1], comparisonOrPassThrough);

    N_Bit_Multiplexer2To1 #(1) selectArithmeticCarry(addOrSubtractCarry, incrementOrDecrementCarry, Select[1], arithmeticCarry);
    N_Bit_Multiplexer2To1 #(1) selectArithmeticOverflow(addOrSubtractOverflow, incrementOrDecrementOverflow, Select[1], arithmeticOverflow);
    N_Bit_Multiplexer2To1 #(1) selectShiftOverflow(1'b0, arithmeticShiftOverflow, Select[1], shiftOverflow);


    N_Bit_Multiplexer2To1 #(NUM_BITS) selectArithmeticOrBitwise(arithmetic, bitwise, Select[2], arithmeticOrBitwise);
    N_Bit_Multiplexer2To1 #(NUM_BITS) selectShiftOrComparisonOrPassThrough(shift, comparisonOrPassThrough, Select[2], shiftOrComparisonOrPassThrough);

    N_Bit_Multiplexer2To1 #(1) selectArithmeticOrBitwiseCarry(arithmeticCarry, 1'b0, Select[2], arithmeticOrBitwiseCarry);
    N_Bit_Multiplexer2To1 #(1) selectArithmeticOrBitwiseOverflow(arithmeticOverflow, 1'b0, Select[2], arithmeticOrBitwiseOverflow);
    N_Bit_Multiplexer2To1 #(1) selectShiftOrComparisonOrPassThroughOverflow(shiftOverflow, 1'b0, Select[2], shiftOrComparisonOrPassThroughOverflow);


    N_Bit_Multiplexer2To1 #(NUM_BITS) select(arithmeticOrBitwise, shiftOrComparisonOrPassThrough, Select[3], out);


    N_Bit_Multiplexer2To1 #(1) selectCarry(arithmeticOrBitwiseCarry, 1'b0, Select[3], CarryFlag);
    N_Bit_Multiplexer2To1 #(1) selectOverflow(arithmeticOrBitwiseOverflow, shiftOrComparisonOrPassThroughOverflow, Select[3], OverflowFlag);

    assign O = out;
    assign ZeroFlag = ~|out;

endmodule
