module pp_gen 
    (
        input logic  [23 : 0] x_in,
        output logic [26 : 0] x_1,
        output logic [26 : 0] x_2,
        output logic [26 : 0] x_3,
        output logic [26 : 0] x_4
    );

    logic [26 : 0] tmp;

    assign x_1 = {3'b000, x_in};
    assign x_2 = {2'b00, x_in, 1'b0};
    assign tmp = x_2;
    assign x_3 = {1'b0, tmp + x_in};
    assign x_4 = {1'b0, x_in, 2'b00};

endmodule

