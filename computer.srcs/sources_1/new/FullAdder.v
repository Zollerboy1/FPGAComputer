module FullAdder (
    input A, B, Cin,
    output S, Cout
);
    
    wire firstToOr, firstToSecond, secondToOr;

    
    HalfAdder first(A, B, firstToSecond, firstToOr);
    HalfAdder second(firstToSecond, Cin, S, secondToOr);

    assign Cout = firstToOr | secondToOr;

endmodule
