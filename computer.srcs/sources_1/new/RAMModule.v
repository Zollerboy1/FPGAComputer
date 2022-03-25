module RAMModule(
    input [7:0] BusIn, ProgramModeAddressIn, ProgramModeDataIn,
    input Clock, ProgramModeEnable, ProgramModeClock, AddressEnable, RAMInputEnable, RAMOutputEnable, Reset,
    output [7:0] BusOut, Q
);

    wire [7:0] addressRegisterQ, address, d, q;
    wire ramClock;


    N_Bit_Multiplexer2To1 #(1) selectClock(Clock, ProgramModeClock, ProgramModeEnable, ramClock);


    N_Bit_Register #(8) addressRegister(BusIn, Clock, AddressEnable, Reset, addressRegisterQ);


    N_Bit_Multiplexer2To1 #(8) selectAddress(addressRegisterQ, ProgramModeAddressIn, ProgramModeEnable, address);
    N_Bit_Multiplexer2To1 #(8) selectData(BusIn, ProgramModeDataIn, ProgramModeEnable, d);


    N_Bit_M_Bit_Address_RAM #(8, 8) ram(d, address, ramClock, RAMInputEnable | ProgramModeEnable, 1'b1, 1'b0, q);


    N_Bit_BusTransceiver #(8) transceiver(q, RAMOutputEnable, BusOut);

    assign Q = q;

endmodule
