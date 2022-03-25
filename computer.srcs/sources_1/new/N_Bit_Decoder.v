module N_Bit_Decoder #(
    parameter NUM_BITS = 8
) (
    input [(NUM_BITS - 1):0] Select,
    input Enable,
    output [(num_decoded_bits - 1):0] O
);

    localparam num_decoded_bits = 2 ** NUM_BITS;

    genvar i;
    
    generate
        for (i = 0; i < 2; i = i + 1) begin
            if (i == 0) begin
                if (NUM_BITS == 2)
                    Decoder rightOneBitDecoder(Select[0], Enable & ~Select[1], O[1:0]);
                else
                    N_Bit_Decoder #(NUM_BITS - 1) rightDecoder(Select[(NUM_BITS - 2):0], Enable & ~Select[NUM_BITS - 1], O[((num_decoded_bits / 2) - 1):0]);
            end
            else begin
                if (NUM_BITS == 2)
                    Decoder leftOneBitDecoder(Select[0], Enable & Select[1], O[3:2]);
                else
                    N_Bit_Decoder #(NUM_BITS - 1) leftDecoder(Select[(NUM_BITS - 2):0], Enable & Select[NUM_BITS - 1], O[(num_decoded_bits - 1):(num_decoded_bits / 2)]);
            end
        end
    endgenerate

endmodule
