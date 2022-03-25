module DecoderTest(
    input [3:0] Select,
    output [15:0] O
);

    N_Bit_Decoder #(4) decoder (Select, 1'b1, O);

endmodule
