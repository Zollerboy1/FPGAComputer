module N_USPerCycle_Clock #(
    parameter US_PER_CYCLE = 1000
) (
    input Clock100MHzIn,
    output ClockOut
);

    localparam num_bits_cycle_counter = $clog2(US_PER_CYCLE * 100);

    reg [(num_bits_cycle_counter - 1):0] cycleCounter;


    initial
    begin
        cycleCounter = 0;
    end


    always @(posedge Clock100MHzIn)
    begin
        cycleCounter <= (cycleCounter >= US_PER_CYCLE * 100) ? 0 : cycleCounter + 1;
    end


    assign ClockOut = (cycleCounter < US_PER_CYCLE * 50) ? 1'b0 : 1'b1;

endmodule
