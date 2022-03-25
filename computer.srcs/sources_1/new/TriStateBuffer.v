module TriStateBuffer(
    input D, Enable,
    output Q
);
    
    assign Q = (Enable) ? D : 1'bz;

endmodule
