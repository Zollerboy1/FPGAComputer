module RegisterModule(
    input [7:0] BusIn,
    input Clock, RegisterInputEnable, RegisterOutputEnable, Reset,
    output [7:0] BusOut, Q
);

    wire [7:0] internalBus;

    N_Bit_Register #(8) register(
        .D(BusIn),
        .Clock(Clock),
        .Enable(RegisterInputEnable),
        .Reset(Reset),
        .Q(internalBus)
    );

    N_Bit_BusTransceiver #(8) transceiver(internalBus, RegisterOutputEnable, BusOut);


    assign Q = internalBus;

endmodule
