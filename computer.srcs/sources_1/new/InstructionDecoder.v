// Instruction:
//     - 0:  MicroInstruction[0]
//     - 1:  MicroInstruction[1]
//     - 2:  MicroInstruction[2]
//     - 3:  Instruction[0]
//     - 4:  Instruction[1]
//     - 5:  Instruction[2]
//     - 6:  Instruction[3]
//     - 7:  Instruction[4]
//     - 8:  Instruction[5]
//     - 9: Instruction[6]
//     - 10: Instruction[7]
//     - 11: OverflowFlag
//     - 12: ZeroFlag
//     - 13: CarryFlag
// ControlWord:
//     - 0:  Halt
//     - 1:  AddressEnable
//     - 2:  RAMInputEnable
//     - 3:  RAMOutputEnable
//     - 4:  InstructionEnable
//     - 5:  OperandInputEnable
//     - 6:  OperandOutputEnable
//     - 7:  MicroInstructionReset
//     - 8:  CounterInputEnable
//     - 9:  CountEnable
//     - 10: CounterOutputEnable
//     - 11: AInputEnable
//     - 12: AOutputEnable
//     - 13: ALUSelect[0]
//     - 14: ALUSelect[1]
//     - 15: ALUSelect[2]
//     - 16: ALUSelect[3]
//     - 17: ALUOutputEnable
//     - 18: FlagsEnable
//     - 19: BInputEnable
//     - 20: BOutputEnable
//     - 21: DisplayInputEnable

module InstructionDecoder(
    input [13:0] Instruction,
    output [21:0] ControlWord
);

    reg [21:0] controlWordROM [((1 << 14) - 1):0];
    

    initial begin
        $display("Loading ROM");
        $readmemb("InstructionDecoder.mem", controlWordROM);
    end


    assign ControlWord = controlWordROM[Instruction];

endmodule
