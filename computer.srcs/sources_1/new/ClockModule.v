module ClockModule(
    input Clock100MHz, Halt,
    output ClockOut
);

    wire internalClock;

    N_USPerCycle_Clock #(1000) clock(Clock100MHz, internalClock);


    assign ClockOut = ~Halt & internalClock;

endmodule
