`define MINUS_SIGN 4'b1110
`define EMPTY 4'b1111


module SevenSegmentDisplayController(
    input Clock100MHz,
    input [7:0] Number,
    output reg [3:0] Anodes,
    output reg [6:0] LEDs
);

    
    wire [11:0] ledDigits;
    wire [1:0] ledActivationCounter;
    wire negative;

    reg [19:0] refreshCounter;
    reg [3:0] currentLEDDigit;



    BinaryToBCDConverter converter(Number, ledDigits, negative);


    always @(posedge Clock100MHz) begin
        refreshCounter <= refreshCounter + 1;
    end

    
    assign ledActivationCounter = refreshCounter[19:18];


    always @(*) begin
        case (ledActivationCounter)
        2'b00: begin
            Anodes = 4'b0111;

            currentLEDDigit = negative ? `MINUS_SIGN : `EMPTY;
        end
        2'b01: begin
            Anodes = 4'b1011;

            currentLEDDigit = ledDigits[11:8];
        end
        2'b10: begin
            Anodes = 4'b1101;

            currentLEDDigit = ledDigits[7:4];
        end
        2'b11: begin
            Anodes = 4'b1110;

            currentLEDDigit = ledDigits[3:0];
        end
        endcase
    end

    always @(*) begin
        case (currentLEDDigit)
        4'b0001:     LEDs = 7'b1001111; // "1"
        4'b0010:     LEDs = 7'b0010010; // "2"
        4'b0011:     LEDs = 7'b0000110; // "3"
        4'b0100:     LEDs = 7'b1001100; // "4"
        4'b0101:     LEDs = 7'b0100100; // "5"
        4'b0110:     LEDs = 7'b0100000; // "6"
        4'b0111:     LEDs = 7'b0001111; // "7"
        4'b1000:     LEDs = 7'b0000000; // "8"
        4'b1001:     LEDs = 7'b0000100; // "9"
        `MINUS_SIGN: LEDs = 7'b1111110; // "-"
        `EMPTY:      LEDs = 7'b1111111; // " "
        default:     LEDs = 7'b0000001; // "0"
        endcase
    end

endmodule
