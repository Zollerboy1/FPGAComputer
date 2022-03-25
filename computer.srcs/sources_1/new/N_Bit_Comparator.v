module N_Bit_Comparator #(
    parameter NUM_BITS = 8
) (
    input [(NUM_BITS - 1):0] A, B,
    output AIsGreater, Equal, BIsGreater
);

    localparam num_bits_right = 2 ** ($clog2(NUM_BITS) - 1);


    wire rightAIsGreater, rightEqual, rightBIsGreater;
    wire leftAIsGreater, leftEqual, leftBIsGreater;


    genvar i;
    
    generate
        for (i = 0; i < NUM_BITS; i = i + num_bits_right) begin
            if (i == 0) begin
                if (num_bits_right == 1)
                    Comparator rightOneBitComparator(A[0], B[0], rightAIsGreater, rightEqual, rightBIsGreater);
                else
                    N_Bit_Comparator #(num_bits_right) rightComparator(A[(num_bits_right - 1):0], B[(num_bits_right - 1):0], rightAIsGreater, rightEqual, rightBIsGreater);
            end
            else begin
                if ((NUM_BITS - i) == 1)
                    Comparator leftOneBitComparator(A[i], B[i], leftAIsGreater, leftEqual, leftBIsGreater);
                else
                    N_Bit_Comparator #(NUM_BITS - i) leftComparator(A[(NUM_BITS - 1):i], B[(NUM_BITS - 1):i], leftAIsGreater, leftEqual, leftBIsGreater);
            end
        end
    endgenerate

    assign AIsGreater = leftAIsGreater | (leftEqual & rightAIsGreater);
    assign Equal = leftEqual & rightEqual;
    assign BIsGreater = leftBIsGreater | (leftEqual & rightBIsGreater);

endmodule
