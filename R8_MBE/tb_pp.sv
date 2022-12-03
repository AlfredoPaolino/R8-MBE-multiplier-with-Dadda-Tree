module tb_pp ();

    //pp_gen
    logic [23 : 0] x_in_tb;
    logic [26 : 0] x_1_tb;
    logic [26 : 0] x_2_tb;
    logic [26 : 0] x_3_tb;
    logic [26 : 0] x_4_tb;

    //booth_encoder_unit
    logic [23 : 0] y_tb;
    logic [8 : 0][4 : 0] BEU_out_tb;

    //booth_selector_unit
    logic [8 : 0][26 : 0] BSU_out_tb;
    
    //pp_resize_unit
    logic [8 : 0] n_tb;
    logic [8 : 0][32 : 0] PPRU_out_tb;

    //dadda_tree
    logic [47 : 0] dadda_out_tb;

    pp_gen pp_gen0(
        .x_in(x_in_tb),
        .x_1(x_1_tb),
        .x_2(x_2_tb),
        .x_3(x_3_tb),
        .x_4(x_4_tb)
    );

    booth_encoder_unit beu0(.y(y_tb), .BEU_out(BEU_out_tb));

    booth_selector_unit bsu0(
        .x_1(x_1_tb),
        .x_2(x_2_tb),
        .x_3(x_3_tb),
        .x_4(x_4_tb),
        .BEU_sel(BEU_out_tb),
        .BSU_out(BSU_out_tb)
    );

    genvar i;
    generate
        for (i = 0; i < 9; i++) begin
            assign n_tb[i] = BEU_out_tb[i][4];
        end
    endgenerate

    pp_resize_unit ppru0(
        .PPRU_in(BSU_out_tb),
        .n(n_tb),
        .PPRU_out(PPRU_out_tb)     
    );

    dadda_tree dadda0(
        .dadda_in(PPRU_out_tb),
        .dadda_out(dadda_out_tb)
    );


    initial begin
        assign x_in_tb = 24'hFFFFFF;
        assign y_tb = 4'h1;
        #100;
        assign x_in_tb = 24'hFFFFFF;
        assign y_tb = 4'h2;
        #100;
        assign x_in_tb = 24'hFFFFFF;
        assign y_tb = 4'h3;
        #100;
        assign x_in_tb = 24'hFFFFFF;
        assign y_tb = 4'h4;
        #100;
        assign x_in_tb = 24'hFFFFFF;
        assign y_tb = 24'hFFFFFF;
        #100;
        assign x_in_tb = 24'h14FEAC;
        assign y_tb = 24'h8B4CFE;
        #100;
        assign x_in_tb = 24'h012345;
        assign y_tb = 24'h067890;       
    end
endmodule