module DFlipFlop (
    input D, Clock, Enable, Reset,
    output reg Q
);
    
    always @(posedge Clock, posedge Reset)
    begin
        if (Reset)
            Q <= 1'b0;
        else if (Enable)
            Q <= D;
    end

endmodule
