module CounterModule(
    input [7:0] BusIn,
    input Clock, CounterInputEnable, CountEnable, CounterOutputEnable, Reset,
    output [7:0] BusOut
);

    wire [7:0] internalBus;

    N_Bit_BinaryCounter #(8) counter(BusIn, Clock, CounterInputEnable, CountEnable, Reset, internalBus);


    N_Bit_BusTransceiver #(8) transceiver(internalBus, CounterOutputEnable, BusOut);

endmodule
