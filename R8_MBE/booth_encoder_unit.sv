module booth_encoder_unit
    (
        input logic [23 : 0] y,
        output logic [8 : 0][4 : 0] BEU_out
    );
    
    booth_encoder be_0(.y({y[2 : 0], 1'b0}), .BE_out(BEU_out[0]));

    genvar i;
    generate
        for (i = 1; i < 8; i++) begin
            booth_encoder be_i(.y(y[i*3 + 2 : i*3 - 1]), .BE_out(BEU_out[i]));
        end
    endgenerate

    booth_encoder be_8(.y({3'b000, y[23]}), .BE_out(BEU_out[8]));

endmodule