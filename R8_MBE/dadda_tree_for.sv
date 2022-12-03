module dadda_tree
    (
        input logic [8 : 0][31 : 0] dadda_in,
        output logic [47 : 0] dadda_out
    );

    logic [4 : 0][8 : 0][47 : 0] pp_matrix;
    logic [4 : 0][47 : 0] T;

    genvar i;

    //--- LEVEL 0 = SHIFTED INPUTS ---
    assign pp_matrix[0][0][47 : 0] = {dadda_in[8][26 : 11], dadda_in[0]};
    assign pp_matrix[0][1][47 : 0] = {dadda_in[7][29 : 14], dadda_in[1]};
    assign pp_matrix[0][2][47 : 0] = {1'b0 , dadda_in[6][31 : 20], dadda_in[2], 3'b0};
    assign pp_matrix[0][3][47 : 0] = {4'b0 , dadda_in[5][31 : 26], dadda_in[3], 6'b0};
    assign pp_matrix[0][4][47 : 0] = {7'b0 , dadda_in[4], 9'b0};
    assign pp_matrix[0][5][47 : 0] = {10'b0 , dadda_in[5][25:0], 12'b0};
    assign pp_matrix[0][6][47 : 0] = {13'b0 , dadda_in[6][19:0], 15'b0};
    assign pp_matrix[0][7][47 : 0] = {16'b0, dadda_in[7][13:0], 18'b0};
    assign pp_matrix[0][8][47 : 0] = {16'b0, dadda_in[8][10:0], 21'b0};

    //--- LEVEL 1 = 8 ---

    ha ha1_0(.a(pp_matrix[0][7][21]), .b(pp_matrix[0][8][21]), .S(pp_matrix[1][7][21]), .Cout(pp_matrix[1][7][22]));

    generate
        for (i = 0; i < 10; i++) begin
            fa fa1_i0(.a(pp_matrix[0][6][22+i]), .b(pp_matrix[0][7][22+i]), .c(pp_matrix[0][8][22+i]), .S(pp_matrix[1][6][22+i]), .Cout(pp_matrix[1][7][23+i]));
        end
    endgenerate

    assign pp_matrix[1][0] = pp_matrix[0][0];
    assign pp_matrix[1][1] = pp_matrix[0][1];
    assign pp_matrix[1][2] = pp_matrix[0][2];
    assign pp_matrix[1][3] = pp_matrix[0][3];
    assign pp_matrix[1][4] = pp_matrix[0][4];
    assign pp_matrix[1][5] = pp_matrix[0][5];
    assign pp_matrix[1][6][47 : 32] = pp_matrix[0][6][47 : 32];
    assign pp_matrix[1][6][21 : 0] = pp_matrix[0][6][21 : 0];
    assign pp_matrix[1][7][47 : 33] = pp_matrix[0][7][47 : 33];
    assign pp_matrix[1][7][20 : 0] = pp_matrix[0][7][20 : 0];
    assign pp_matrix[1][8] = 48'b0;

    //--- LEVEL 2 = 5 ---

    ha ha2_0(.a(pp_matrix[1][3][9]), .b(pp_matrix[1][4][9]), .S(pp_matrix[2][3][9]), .Cout(pp_matrix[2][3][10]));

    generate
        for(i = 0; i < 2; i++) begin
            fa fa2_i0(.a(pp_matrix[1][2][10+i]), .b(pp_matrix[1][3][10+i]), .c(pp_matrix[1][4][10+i]), .S(pp_matrix[2][2][10+i]), .Cout(pp_matrix[2][3][11+i]));
        end
    endgenerate

    assign T[0][12] = 1'b0;
    generate
        for(i = 0; i < 3; i++) begin
            ca ca2_i0(.x4(pp_matrix[1][2][12+i]), .x3(pp_matrix[1][3][12+i]), .x2(pp_matrix[1][4][12+i]), .x1(pp_matrix[1][5][12+i]), .Tin(T[0][12+i]), .S(pp_matrix[2][2][12+i]), .C(pp_matrix[2][3][13+i]), .Tout(T[0][13+i]));
        end
    endgenerate
    
    ca ca2_0(.x4(pp_matrix[1][3][15]), .x3(pp_matrix[1][4][15]), .x2(pp_matrix[1][5][15]), .x1(pp_matrix[1][6][15]), .Tin(T[0][15]), .S(pp_matrix[2][2][15]), .C(pp_matrix[2][3][16]), .Tout(T[0][16]));
    ha ha2_1(.a(pp_matrix[1][1][15]), .b(pp_matrix[1][2][15]), .S(pp_matrix[2][1][15]), .Cout(pp_matrix[2][2][16]));

    generate
        for(i = 0; i < 2; i++) begin
            ca ca2_i1(.x4(pp_matrix[1][3][16+i]), .x3(pp_matrix[1][4][16+i]), .x2(pp_matrix[1][5][16+i]), .x1(pp_matrix[1][6][16+i]), .Tin(T[0][16+i]), .S(pp_matrix[2][1][16+i]), .C(pp_matrix[2][3][17+i]), .Tout(T[0][17+i]));
            fa fa2_i1(.a(pp_matrix[1][0][16+i]), .b(pp_matrix[1][1][16+i]), .c(pp_matrix[1][2][16+i]), .S(pp_matrix[2][0][16+i]), .Cout(pp_matrix[2][2][17+i]));
        end
    endgenerate

    assign T[1][18] = 1'b0;
    generate
        for (i = 0; i < 15; i++) begin
            ca ca2_i2(.x4(pp_matrix[1][4][18+i]), .x3(pp_matrix[1][5][18+i]), .x2(pp_matrix[1][6][18+i]), .x1(pp_matrix[1][7][18+i]), .Tin(T[0][18+i]), .S(pp_matrix[2][0][18+i]), .C(pp_matrix[2][3][19+i]), .Tout(T[0][19+i]));
            ca ca2_i3(.x4(pp_matrix[1][0][18+i]), .x3(pp_matrix[1][1][18+i]), .x2(pp_matrix[1][2][18+i]), .x1(pp_matrix[1][3][18+i]), .Tin(T[1][18+i]), .S(pp_matrix[2][1][18+i]), .C(pp_matrix[2][2][19+i]), .Tout(T[1][19+i]));
        end
    endgenerate
    
    generate
        for (i = 0; i < 2; i++) begin
            ca ca2_i3(.x4(pp_matrix[1][3][33+i]), .x3(pp_matrix[1][4][33+i]), .x2(pp_matrix[1][5][33+i]), .x1(pp_matrix[1][6][33+i]), .Tin(T[0][33+i]), .S(pp_matrix[2][1][33+i]), .C(pp_matrix[2][3][34+i]), .Tout(T[0][34+i]));
            ca ca2_i4(.x4(pp_matrix[1][0][33+i]), .x3(pp_matrix[1][1][33+i]), .x2(pp_matrix[1][2][33+i]), .x1(1'b0), .Tin(T[1][33+i]), .S(pp_matrix[2][0][33+i]), .C(pp_matrix[2][2][34+i]), .Tout(T[1][34+i]));
        end
    endgenerate

    ca ca2_1(.x4(pp_matrix[1][2][35]), .x3(pp_matrix[1][3][35]), .x2(pp_matrix[1][4][35]), .x1(pp_matrix[1][5][35]), .Tin(T[0][35]), .S(pp_matrix[2][1][35]), .C(pp_matrix[2][3][36]), .Tout(T[0][36]));
    fa fa2_0(.a(pp_matrix[1][0][35]), .b(pp_matrix[1][1][35]), .c(T[1][35]), .S(pp_matrix[2][0][35]), .Cout(pp_matrix[2][2][36]));


    generate
        for (i = 0; i < 2; i++) begin
            ca ca2_i5(.x4(pp_matrix[1][2][36+i]), .x3(pp_matrix[1][3][36+i]), .x2(pp_matrix[1][4][36+i]), .x1(pp_matrix[1][5][36+i]), .Tin(T[0][36+i]), .S(pp_matrix[2][1][36+i]), .C(pp_matrix[2][3][37+i]), .Tout(T[0][37+i]));
            ha ha2_i0(.a(pp_matrix[1][0][36+i]), .b(pp_matrix[1][1][36+i]), .S(pp_matrix[2][0][36+i]), .Cout(pp_matrix[2][2][37+i]));
        end
    endgenerate

    ca ca2_2(.x4(pp_matrix[1][1][38]), .x3(pp_matrix[1][2][38]), .x2(pp_matrix[1][3][38]), .x1(pp_matrix[1][4][38]), .Tin(T[0][38]), .S(pp_matrix[2][1][38]), .C(pp_matrix[2][3][39]), .Tout(T[0][39]));
    
    fa fa2_1(.a(pp_matrix[1][4][39]), .b(pp_matrix[1][3][39]), .c(T[0][39]), .S(pp_matrix[2][2][39]), .Cout(pp_matrix[2][3][40]));
    ha ha2_2(.a(pp_matrix[1][2][39]), .b(pp_matrix[1][1][39]), .S(pp_matrix[2][1][39]), .Cout(pp_matrix[2][2][40]));
    
    fa fa2_2(.a(pp_matrix[1][2][40]), .b(pp_matrix[1][3][40]), .c(pp_matrix[1][4][40]), .S(pp_matrix[2][1][40]), .Cout(pp_matrix[2][3][41]));
    ha ha2_3(.a(pp_matrix[1][0][40]), .b(pp_matrix[1][1][40]), .S(pp_matrix[2][0][40]), .Cout(pp_matrix[2][2][41]));


    generate
        for (i = 0; i < 3; i++) begin
            ha ha2_i2(.a(pp_matrix[1][2][41+i]), .b(pp_matrix[1][3][41+i]), .S(pp_matrix[2][1][41+i]), .Cout(pp_matrix[2][3][42+i]));
            ha ha2_i3(.a(pp_matrix[1][0][41+i]), .b(pp_matrix[1][1][41+i]), .S(pp_matrix[2][0][41+i]), .Cout(pp_matrix[2][2][42+i]));
        end
    endgenerate    

    ha ha2_4(.a(pp_matrix[1][1][44]), .b(pp_matrix[1][2][44]), .S(pp_matrix[2][1][44]), .Cout(pp_matrix[2][3][45]));

    assign pp_matrix[2][0][47 : 44] = pp_matrix[1][0][47 : 44];
    assign pp_matrix[2][0][39 : 38] = pp_matrix[1][0][39 : 38];
    assign pp_matrix[2][0][15 : 0] = pp_matrix[1][0][15 : 0];
    assign pp_matrix[2][1][47 : 45] = pp_matrix[1][1][47 : 45];
    assign pp_matrix[2][1][14 : 0] = pp_matrix[1][1][14 : 0];
    assign pp_matrix[2][2][47 : 45] = pp_matrix[1][2][47 : 45];
    assign pp_matrix[2][2][9 : 0] = pp_matrix[1][2][9 : 0];
    assign pp_matrix[2][3][47 : 46] = pp_matrix[1][3][47 : 46];
    assign pp_matrix[2][3][8 : 0] = pp_matrix[1][3][8 : 0];
    assign pp_matrix[2][4] = 48'b0;
    assign pp_matrix[2][5] = 48'b0;
    assign pp_matrix[2][6] = 48'b0;
    assign pp_matrix[2][7] = 48'b0;
    assign pp_matrix[2][8] = 48'b0;

    assign dadda_out = pp_matrix[2][0] + pp_matrix[2][1] + pp_matrix[2][2] + pp_matrix[2][3] + pp_matrix[2][4] + pp_matrix[2][5] + pp_matrix[2][6] + pp_matrix[2][7] + pp_matrix[2][8];


endmodule