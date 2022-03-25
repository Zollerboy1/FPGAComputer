module BinaryToBCDConverter(
    input [7:0] Binary,
    output [11:0] BCD,
    output Negative
);
    
    wire [7:0] twosComplement;
    wire [11:0] incrementedDigits [7:0];
    wire [19:0] scratchSpace [8:0];

    wire _unused;


    N_Bit_Adder #(8) negater(~Binary, 8'b0000_0000, 1'b1, twosComplement, _unused);

    N_Bit_Multiplexer2To1 #(8) select(Binary, twosComplement, Binary[7], scratchSpace[0][7:0]);


    assign scratchSpace[0][19:8] = 12'b0000_0000_0000;


    genvar i;

    generate;
        for (i = 0; i < 8; i = i + 1) begin
            Add3IfAtLeast5 incrementOnes_i(scratchSpace[i][11:8], incrementedDigits[i][3:0]);
            Add3IfAtLeast5 incrementTens_i(scratchSpace[i][15:12], incrementedDigits[i][7:4]);
            Add3IfAtLeast5 incrementHundreds_i(scratchSpace[i][19:16], incrementedDigits[i][11:8]);

            N_Bit_ShifterByOne #(20) shiftLeft_i({incrementedDigits[i], scratchSpace[i][7:0]}, 1'b0, scratchSpace[i + 1]);
        end
    endgenerate

    assign BCD[11:0] = scratchSpace[8][19:8];

    assign Negative = Binary[7];

endmodule
