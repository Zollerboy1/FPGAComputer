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

module Computer(
    input [7:0] ProgramModeAddressIn, ProgramModeDataIn,
    input Clock100MHz, ManualClock, ProgramModeClock, ProgramModeToggle, ClockToggle, Reset,
    output [3:0] Anodes,
    output [6:0] LEDs,
    output reg [7:0] Bus, ProgramModeRAMQ
);

    wire [7:0] bus, ramQ, registerAQ, registerBQ;
    wire [22:0] controlWord;
    wire clock, selectedClock, carryFlag, zeroFlag, overflowFlag;
    wire debouncedManualClock, debouncedProgramModeClock, debouncedProgramModeToggle, debouncedClockToggle;

    reg programMode, manualClockEnable;


    initial begin
        programMode = 1'b0;
        manualClockEnable = 1'b1;
    end


    ButtonDebouncer manualClockDebouncer(ManualClock, Clock100MHz, debouncedManualClock);
    ButtonDebouncer programModeClockDebouncer(ProgramModeClock, Clock100MHz, debouncedProgramModeClock);
    ButtonDebouncer programModeToggleDebouncer(ProgramModeToggle, Clock100MHz, debouncedProgramModeToggle);
    ButtonDebouncer clockToggleDebouncer(ClockToggle, Clock100MHz, debouncedClockToggle);

    always @(posedge debouncedProgramModeToggle) begin
        programMode <= ~programMode;
    end

    always @(posedge debouncedClockToggle) begin
        manualClockEnable <= ~manualClockEnable;
    end


    ClockModule clockModule(
        .Clock100MHz(Clock100MHz),
        .Halt(controlWord[0] | programMode),
        .ClockOut(clock)
    );

    N_Bit_Multiplexer2To1 #(1) clockSelect(clock, debouncedManualClock, manualClockEnable, selectedClock);


    RAMModule ramModule(
        .BusIn(bus),
        .ProgramModeAddressIn(ProgramModeAddressIn),
        .ProgramModeDataIn(ProgramModeDataIn),
        .Clock(selectedClock),
        .ProgramModeEnable(programMode),
        .ProgramModeClock(debouncedProgramModeClock),
        .AddressEnable(controlWord[1]),
        .RAMInputEnable(controlWord[2]),
        .RAMOutputEnable(controlWord[3]),
        .Reset(Reset),
        .BusOut(bus),
        .Q(ramQ)
    );


    ControlModule controlModule(
        .BusIn(bus),
        .Clock(selectedClock),
        .InstructionEnable(controlWord[4]),
        .OperandInputEnable(controlWord[5]),
        .OperandOutputEnable(controlWord[6]),
        .MicroInstructionReset(controlWord[7]),
        .Reset(Reset),
        .CarryFlag(carryFlag),
        .ZeroFlag(zeroFlag),
        .OverflowFlag(overflowFlag),
        .BusOut(bus),
        .ControlWord(controlWord)
    );


    CounterModule counterModule(
        .BusIn(bus),
        .Clock(selectedClock),
        .CounterInputEnable(controlWord[8]),
        .CountEnable(controlWord[9]),
        .CounterOutputEnable(controlWord[10]),
        .Reset(Reset),
        .BusOut(bus)
    );


    RegisterModule registerAModule(
        .BusIn(bus),
        .Clock(selectedClock),
        .RegisterInputEnable(controlWord[11]),
        .RegisterOutputEnable(controlWord[12]),
        .Reset(Reset),
        .BusOut(bus),
        .Q(registerAQ)
    );


    ALUModule aluModule(
        .RegisterA(registerAQ),
        .RegisterB(registerBQ),
        .ALUSelect(controlWord[16:13]),
        .Clock(selectedClock),
        .ALUOutputEnable(controlWord[17]),
        .SwitchAB(controlWord[18]),
        .FlagsEnable(controlWord[19]),
        .Reset(Reset),
        .Bus(bus),
        .CarryFlag(carryFlag),
        .ZeroFlag(zeroFlag),
        .OverflowFlag(overflowFlag)
    );


    RegisterModule registerBModule(
        .BusIn(bus),
        .Clock(selectedClock),
        .RegisterInputEnable(controlWord[20]),
        .RegisterOutputEnable(controlWord[21]),
        .Reset(Reset),
        .BusOut(bus),
        .Q(registerBQ)
    );


    DisplayModule displayModule(
        .Bus(bus),
        .Clock(selectedClock),
        .DisplayInputEnable(controlWord[22]),
        .Reset(Reset),
        .Clock100MHz(Clock100MHz),
        .Anodes(Anodes),
        .LEDs(LEDs)
    );


    always @(*) begin
        if (programMode) begin
            Bus = 8'b11111111;
            ProgramModeRAMQ = ramQ;
        end
        else begin
            Bus = bus;
            ProgramModeRAMQ = 8'b00000000;
        end
    end

endmodule
