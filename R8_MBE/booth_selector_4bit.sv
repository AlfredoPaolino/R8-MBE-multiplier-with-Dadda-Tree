module booth_selector_4bit 
    (
        input logic x_1,
        input logic x_2,
        input logic x_3,
        input logic x_4,
        input logic [4 : 0] BE_sel,
        output logic pp
    );

    logic pp_sig_1, pp_sig_2;

    assign pp_sig_1 = ~((BE_sel[0] & x_1) | (BE_sel[1] & x_2));
    assign pp_sig_2 = ~((BE_sel[2] & x_3) | (BE_sel[3] & x_4));
    assign pp = ~(pp_sig_1 & pp_sig_2) ^ BE_sel[4];

endmodule