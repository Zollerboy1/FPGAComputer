module Decoder(
    input Select, Enable,
    output [1:0] O
);

    assign O[0] = Enable & ~Select;
    assign O[1] = Enable & Select;

endmodule
