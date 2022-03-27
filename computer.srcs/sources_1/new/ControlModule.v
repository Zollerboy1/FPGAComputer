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
//     - 18: SwitchAB
//     - 19: FlagsEnable
//     - 20: BInputEnable
//     - 21: BOutputEnable
//     - 22: DisplayInputEnable

module ControlModule(
    input [7:0] BusIn,
    input Clock, InstructionEnable, OperandInputEnable, OperandOutputEnable, MicroInstructionReset, Reset,
    input CarryFlag, ZeroFlag, OverflowFlag,
    output [7:0] BusOut,
    output [22:0] ControlWord
);

    wire [7:0] instruction, operandOutput;
    wire [2:0] microInstruction;


    N_Bit_Register #(8) instructionRegister(BusIn, Clock, InstructionEnable, Reset, instruction);
    N_Bit_Register #(8) operandRegister(BusIn, Clock, OperandInputEnable, Reset, operandOutput);

    N_Bit_BusTransceiver #(8) transceiver(operandOutput, OperandOutputEnable, BusOut);


    N_Bit_BinaryCounter #(3) microInstructionCounter(3'b000, ~Clock, MicroInstructionReset, 1'b1, Reset, microInstruction);


    InstructionDecoder decoder({CarryFlag, ZeroFlag, OverflowFlag, instruction, microInstruction}, ControlWord);


endmodule
