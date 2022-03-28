module N_USPerCycle_Clock #(
    parameter US_PER_CYCLE = 1000
) (
    input Clock100MHzIn,
    output reg ClockOut
);

    localparam num_clock_cycles = US_PER_CYCLE * 100;
    localparam num_bits_cycle_counter = $clog2(num_clock_cycles);

    reg [(num_bits_cycle_counter - 1):0] cycleCounter;


    initial
    begin
        cycleCounter = 0;
    end


    always @(posedge Clock100MHzIn)
    begin
        cycleCounter <= cycleCounter + {{(num_bits_cycle_counter - 1){1'b0}}, 1'b1};
        
        if (cycleCounter >= num_clock_cycles - 1)
            cycleCounter <= {num_bits_cycle_counter{1'b0}};
        
        ClockOut <= (cycleCounter < num_clock_cycles / 2) ? 1'b1 : 1'b0;
    end

endmodule
