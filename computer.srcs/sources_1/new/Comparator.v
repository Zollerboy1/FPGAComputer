module Comparator(
    input A, B,
    output AIsGreater, Equal, BIsGreater
);

    assign AIsGreater = A & ~B;
    assign Equal = A ~^ B;
    assign BIsGreater = ~A & B;

endmodule
