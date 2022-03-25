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

module Computer(
    input [7:0] ProgramModeAddressIn, ProgramModeDataIn,
    input Clock100MHz, ManualClock, ProgramModeClock, ProgramModeToggle, ClockToggle, Reset,
    output [3:0] Anodes,
    output [6:0] LEDs,
    output reg [7:0] Bus, ProgramModeRAMQ
);

    wire [7:0] bus, ramQ, registerAQ, registerBQ;
    wire [21:0] controlWord;
    wire clock, selectedClock, carryFlag, zeroFlag, overflowFlag;

    reg programMode, manualClock;
    reg [25:0] programModeCoolDown, manualClockCoolDown;


    initial begin
        programMode = 1'b0;
        programModeCoolDown = 0;
        manualClock = 1'b1;
        manualClockCoolDown = 0;
    end


    always @(posedge Clock100MHz, posedge ProgramModeToggle) begin
        if (ProgramModeToggle && (programModeCoolDown == 0)) begin
            programMode <= ~programMode;
            programModeCoolDown <= 1;
        end
        else if (Clock100MHz) begin
            if (programModeCoolDown != 0)
                programModeCoolDown <= programModeCoolDown + 1;
        end
    end


    always @(posedge Clock100MHz, posedge ClockToggle) begin
        if (ClockToggle && (manualClockCoolDown == 0)) begin
            manualClock <= ~manualClock;
            manualClockCoolDown <= 1;
        end
        else if (Clock100MHz) begin
            if (manualClockCoolDown != 0)
                manualClockCoolDown <= manualClockCoolDown + 1;
        end
    end


    ClockModule clockModule(
        .Clock100MHz(Clock100MHz),
        .Halt(controlWord[0]),
        .ClockOut(clock)
    );

    N_Bit_Multiplexer2To1 #(1) clockSelect(clock, ManualClock, manualClock, selectedClock);


    RAMModule ramModule(
        .BusIn(bus),
        .ProgramModeAddressIn(ProgramModeAddressIn),
        .ProgramModeDataIn(ProgramModeDataIn),
        .Clock(selectedClock),
        .ProgramModeEnable(programMode),
        .ProgramModeClock(ProgramModeClock),
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
        .FlagsEnable(controlWord[18]),
        .Reset(Reset),
        .Bus(bus),
        .CarryFlag(carryFlag),
        .ZeroFlag(zeroFlag),
        .OverflowFlag(overflowFlag)
    );


    RegisterModule registerBModule(
        .BusIn(bus),
        .Clock(selectedClock),
        .RegisterInputEnable(controlWord[19]),
        .RegisterOutputEnable(controlWord[20]),
        .Reset(Reset),
        .BusOut(bus),
        .Q(registerBQ)
    );


    DisplayModule displayModule(
        .Bus(bus),
        .Clock(selectedClock),
        .DisplayInputEnable(controlWord[21]),
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
