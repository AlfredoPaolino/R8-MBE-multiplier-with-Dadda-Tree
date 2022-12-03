module tb_encoder_unit;
    logic [23 : 0] y_tb;
    logic [7 : 0][4 : 0] BEU_out_tb;
    
    booth_encoder_unit dut(.y(y_tb), .BEU_out(BEU_out_tb));

    initial begin
        assign y_tb = { 4'b0000, 4'b0001, 4'b0010, 4'b0011, 4'b0100, 4'b0101 };
        #100;
    end
    //4'b0110, 4'b0111, 4'b1000, 4'b1001
endmodule
