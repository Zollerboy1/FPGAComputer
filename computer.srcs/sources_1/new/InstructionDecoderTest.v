module InstructionDecoderTest(
    input [13:0] Instruction,
    output [15:0] ControlWord
);

    wire [5:0] _unused;

    InstructionDecoder decoder(Instruction, {_unused, ControlWord});

endmodule
