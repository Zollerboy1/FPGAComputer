module CounterTest(
    input [7:0] D,
    input ClockSelect, Clock100MHz, ManualClock, CounterInputEnable, CountEnable, Reset,
    output [7:0] Q
);

    wire clock5Hz, selectedClock;


    N_USPerCycle_Clock #(200000) clock(Clock100MHz, clock5Hz);

    N_Bit_Multiplexer2To1 #(1) clockSelect(clock5Hz, ManualClock, ClockSelect, selectedClock);


    N_Bit_BinaryCounter #(8) counter(D, selectedClock, CounterInputEnable, CountEnable, Reset, Q);

endmodule
