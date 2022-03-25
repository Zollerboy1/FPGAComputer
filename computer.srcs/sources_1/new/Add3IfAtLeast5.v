module Add3IfAtLeast5(
    input [3:0] A,
    output [3:0] O
);
    
    wire [3:0] incremented;
    wire isAtLeast5;

    wire _unused;


    assign isAtLeast5 = A[3] | (A[2] & (A[1] | A[0]));


    N_Bit_Adder #(4) incrementer(A, 4'b0011, 1'b0, incremented, _unused);

    N_Bit_Multiplexer2To1 #(4) select(A, incremented, isAtLeast5, O);

endmodule
