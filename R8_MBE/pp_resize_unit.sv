module pp_resize_unit
    (
        input logic [8 : 0][26 : 0] PPRU_in,
        input logic [8 : 0] n,
        output logic [8 : 0][32 : 0] PPRU_out
    );

    assign PPRU_out[0] = {2'b00, ~PPRU_in[0][26], {3{PPRU_in[0][26]}}, PPRU_in[0]};
    
    genvar i;
    generate 
        for (i = 1; i < 8; i++) begin
             assign PPRU_out[i] = {2'b11, ~PPRU_in[i][26], PPRU_in[i], 2'b00, PPRU_in[i-1][26]};
        end
    endgenerate

    assign PPRU_out[8] = {3'b000, PPRU_in[8], 2'b00, PPRU_in[7][26]};

endmodule