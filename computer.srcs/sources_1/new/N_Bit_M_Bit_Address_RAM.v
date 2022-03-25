module N_Bit_M_Bit_Address_RAM #(
    parameter NUM_BITS = 8,
    parameter NUM_ADDRESS_BITS = 8
) (
    input [(NUM_BITS - 1):0] D,
    input [(NUM_ADDRESS_BITS - 1):0] Address,
    input Clock, InputEnable, OutputEnable, Reset,
    output [(NUM_BITS - 1):0] Q
);

    localparam num_addresses = 2 ** NUM_ADDRESS_BITS;


    wire [(num_addresses - 1):0] addressEnabled;
    wire [(NUM_BITS - 1):0] q [(num_addresses - 1):0];


    N_Bit_Decoder #(8) addressDecoder(Address, 1'b1, addressEnabled);


    genvar i;
    
    generate
        for (i = 0; i < num_addresses; i = i + 1) begin
            N_Bit_Register #(NUM_BITS) register_i(D, Clock, addressEnabled[i] & InputEnable, Reset, q[i]);

            
            N_Bit_BusTransceiver transceiver_i(q[i], addressEnabled[i] & OutputEnable, Q);
        end
    endgenerate

endmodule
