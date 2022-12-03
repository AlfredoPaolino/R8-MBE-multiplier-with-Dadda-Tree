module booth_selector_unit
    (
        input logic [26 : 0] x_1,
        input logic [26 : 0] x_2,
        input logic [26 : 0] x_3,
        input logic [26 : 0] x_4,
        input logic [8 : 0][4 : 0] BEU_sel,
        output logic [8 : 0][26 : 0] BSU_out
    );
    
    genvar i;
    generate
        for (i = 0; i < 9; i++) begin
            booth_selector bs_i(
                .x_1(x_1),
                .x_2(x_2),
                .x_3(x_3),
                .x_4(x_4),
                .BE_sel(BEU_sel[i]),
                .pp(BSU_out[i])
            );
        end
    endgenerate

endmodule