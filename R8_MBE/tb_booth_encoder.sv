module tb_booth_encoder;
    logic [3 : 0] y_tb;
    logic [4 : 0] BE_out_tb;
    
    booth_encoder dut(.y(y_tb), .BE_out(BE_out_tb));

    initial begin
        assign y_tb = { 4'b0011 };
        #100;
    end
    //4'b0110, 4'b0111, 4'b1000, 4'b1001
endmodule
