module tb_selector_unit ();

    logic [23 : 0] x_tb;
    logic [24 : 0] x_2_tb;
    logic [25 : 0] x_3_tb;
    logic [25 : 0] x_4_tb;
    logic [7 : 0][4 : 0] BEU_out_tb;
    logic [7 : 0][25 : 0] BSU_out_tb;

    booth_selector_unit dut(
        .x(x_tb),
        .x_2(x_2_tb),
        .x_3(x_3_tb),
        .x_4(x_4_tb),
        .BEU_out(BEU_out_tb),
        .BSU_out(BSU_out_tb)
    );

    initial begin
        assign x_tb = { 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0001 };
        assign x_2_tb = { 5'b00000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0010 };
        assign x_3_tb = { 6'b000000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0011 };
        assign x_4_tb = { 6'b000000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0100 };
        assign BEU_out_tb = {{5'b00000}, {5'b00001}, {5'b00010}, {5'b00100}, {5'b01000}, {5'b11000}, {5'b10100}, {5'b10010}};
    end
endmodule