module N_Bit_ArithmeticBarrelShifter #(
    parameter NUM_BITS = 8
) (
    input [(NUM_BITS - 1):0] A, B,
    input SelectDirection,
    output [(NUM_BITS - 1):0] O,
    output Overflow
);

    localparam number_of_shift_bits = $clog2(NUM_BITS);

    wire [(NUM_BITS - number_of_shift_bits - 1):0] shiftTooLarge;
    
    wire [(NUM_BITS - 1):0] straightConnections [number_of_shift_bits:0];
    wire [(NUM_BITS - 1):0] leftConnections [(number_of_shift_bits - 1):0];
    wire [(NUM_BITS - 1):0] rightConnections [(number_of_shift_bits - 1):0];
    wire [(NUM_BITS - 1):0] shiftedConnections [(number_of_shift_bits - 1):0];

    wire [((2 ** number_of_shift_bits) - 2):0] selectedOverflow;
    wire [(number_of_shift_bits - 1):0] overflowConnections;


    assign shiftTooLarge[0] = B[number_of_shift_bits];

    assign straightConnections[0] = A;


    genvar i;

    generate
        for (i = 1; i < NUM_BITS - number_of_shift_bits; i = i + 1) begin
            assign shiftTooLarge[i] = shiftTooLarge[i - 1] | B[i + number_of_shift_bits];
        end
    endgenerate


    generate
        for (i = 0; i < number_of_shift_bits; i = i + 1) begin
            assign leftConnections[i][((2 ** i) - 1):0] = {(2 ** i){1'b0}};
            assign leftConnections[i][(NUM_BITS - 2):(2 ** i)] = straightConnections[i][(NUM_BITS - (2 ** i) - 2):0];
            assign leftConnections[i][NUM_BITS - 1] = A[NUM_BITS - 1];

            assign rightConnections[i][(NUM_BITS - (2 ** i) - 1):0] = straightConnections[i][(NUM_BITS - 1):(2 ** i)];
            assign rightConnections[i][(NUM_BITS - 1):(NUM_BITS - (2 ** i))] = {(2 ** i){A[NUM_BITS - 1]}};

            N_Bit_Multiplexer2To1 #(NUM_BITS) selectShiftDirection_i(leftConnections[i], rightConnections[i], SelectDirection, shiftedConnections[i]);

            N_Bit_Multiplexer2To1 #(NUM_BITS) select_i(straightConnections[i], shiftedConnections[i], B[i], straightConnections[i + 1]);


            N_Bit_Multiplexer2To1 #(2 ** i) selectOverflow_i({(2 ** i){A[NUM_BITS - 1]}}, straightConnections[i][(NUM_BITS - 2):(NUM_BITS - (2 ** i) - 1)], B[i], selectedOverflow[((2 ** (i + 1) - 2)):((2 ** i) - 1)]);

            assign overflowConnections[i] = |{{(2 ** i){A[NUM_BITS - 1]}} ^ selectedOverflow[((2 ** (i + 1) - 2)):((2 ** i) - 1)]};
        end
    endgenerate


    N_Bit_Multiplexer2To1 #(NUM_BITS) select(straightConnections[number_of_shift_bits], {NUM_BITS{1'b0}}, shiftTooLarge[NUM_BITS - number_of_shift_bits - 1], O);


    assign Overflow = (|overflowConnections) & ~SelectDirection;

endmodule
