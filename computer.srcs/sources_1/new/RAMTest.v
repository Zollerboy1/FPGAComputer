module RAMTest(
    input [7:0] D,
    input [6:0] Address,
    input Clock, RAMInputEnable, Reset,
    output [7:0] Q
);

    N_Bit_M_Bit_Address_RAM #(8, 8) ram(D, {1'b0, Address}, Clock, RAMInputEnable, 1'b1, Reset, Q);

endmodule
