module N_Bit_Adder #(
    parameter NUM_BITS = 8
) (
    input [(NUM_BITS - 1):0] A, B,
    input Cin,
    output [(NUM_BITS - 1):0] S,
    output Cout
);

    wire [NUM_BITS:0] carry;
    

    assign carry[0] = Cin;


    genvar i;

    generate
        for (i = 0; i < NUM_BITS; i = i + 1) begin
            FullAdder adder_i(A[i], B[i], carry[i], S[i], carry[i + 1]);
        end
    endgenerate


    assign Cout = carry[NUM_BITS];
endmodule
