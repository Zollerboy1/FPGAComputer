module DisplayedAdderTest(
    input [7:0] A, B,
    input Clock100MHz, SelectOperation,
    output [3:0] Anodes,
    output [6:0] LEDs
);

    wire [7:0] sum;
    
    wire _unused;


    N_Bit_AdderOrSubtracter #(8) adder(A, B, SelectOperation, sum, _unused);

    SevenSegmentDisplayController controller(Clock100MHz, sum, Anodes, LEDs);


endmodule
