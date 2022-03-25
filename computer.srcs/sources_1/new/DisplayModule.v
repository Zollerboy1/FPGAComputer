module DisplayModule(
    input [7:0] Bus,
    input Clock, DisplayInputEnable, Reset,
    input Clock100MHz,
    output [3:0] Anodes,
    output [6:0] LEDs
);

    wire [7:0] internalBus;

    N_Bit_Register #(8) displayRegister(Bus, Clock, DisplayInputEnable, Reset, internalBus);


    SevenSegmentDisplayController displayController(Clock100MHz, internalBus, Anodes, LEDs);

endmodule
