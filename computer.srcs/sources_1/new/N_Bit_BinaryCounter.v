module N_Bit_BinaryCounter #(
    parameter NUM_BITS = 8
) (
    input [(NUM_BITS - 1):0] D,
    input Clock, InputEnable, CountEnable, Reset,
    output [(NUM_BITS - 1):0] Q
);

    wire [(NUM_BITS - 1):0] d, q, incrementedQ;
    wire _unused;

    N_Bit_Adder #(NUM_BITS) incrementer(q, {(NUM_BITS){1'b0}}, 1'b1, incrementedQ, _unused);

    N_Bit_Multiplexer2To1 #(NUM_BITS) selectD(incrementedQ, D, InputEnable, d);


    N_Bit_Register #(NUM_BITS) register(d, Clock, InputEnable | CountEnable, Reset, q);


    assign Q = q;

endmodule
