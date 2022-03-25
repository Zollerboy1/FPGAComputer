module ButtonDebouncer(
    input ButtonIn, Clock100MHz,
    output ButtonOut
);

    wire clockEnable;
    wire q0, q1, q2;


    N_USPerCycle_Clock clock(Clock100MHz, clockEnable);


    DFlipFlop d0(ButtonIn, Clock100MHz, clockEnable, 1'b0, q0);
    DFlipFlop d1(q0, Clock100MHz, clockEnable, 1'b0, q1);
    DFlipFlop d2(q1, Clock100MHz, clockEnable, 1'b0, q2);


    assign ButtonOut = q1 & ~q2;

endmodule
