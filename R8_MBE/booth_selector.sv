module booth_selector 
    (
        input logic [26 : 0] x_1,
        input logic [26 : 0] x_2,
        input logic [26 : 0] x_3,
        input logic [26 : 0] x_4,
        input logic [4 : 0] BE_sel,
        output logic [26 : 0] pp
    );

    genvar i;
    generate
        for (i = 0; i < 27; i++) begin
            booth_selector_4bit bs_4bit_i(
                .x_1(x_1[i]),
                .x_2(x_2[i]),
                .x_3(x_3[i]),
                .x_4(x_4[i]),
                .BE_sel(BE_sel),
                .pp(pp[i])
                );
        end
    endgenerate    

endmodule