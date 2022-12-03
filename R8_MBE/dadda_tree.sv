module dadda_tree
    (
        input logic [8 : 0][32 : 0] dadda_in,
        output logic [47 : 0] dadda_out
    );

    logic [4 : 0][8 : 0][47 : 0] pp_matrix;
    logic [4 : 0][47 : 0] T;

    genvar i;

    //--- LEVEL 0 = SHIFTED INPUTS ---
    assign pp_matrix[0][0][47 : 0] = {dadda_in[8][26 : 12], dadda_in[0]};
    assign pp_matrix[0][1][47 : 0] = {dadda_in[7][29 : 15], dadda_in[1]};
    assign pp_matrix[0][2][47 : 0] = {dadda_in[6][32 : 21], dadda_in[2], 3'b0};
    assign pp_matrix[0][3][47 : 0] = {3'b0 , dadda_in[5][32 : 27], dadda_in[3], 6'b0};
    assign pp_matrix[0][4][47 : 0] = {6'b0 , dadda_in[4], 9'b0};
    assign pp_matrix[0][5][47 : 0] = {9'b0 , dadda_in[5][26:0], 12'b0};
    assign pp_matrix[0][6][47 : 0] = {12'b0 , dadda_in[6][20:0], 15'b0};
    assign pp_matrix[0][7][47 : 0] = {15'b0, dadda_in[7][14:0], 18'b0};
    assign pp_matrix[0][8][47 : 0] = {15'b0, dadda_in[8][11:0], 21'b0};

    //--- LEVEL 1 = 8 ---

    ha ha1_0(.a(pp_matrix[0][7][21]), .b(pp_matrix[0][8][21]), .S(pp_matrix[1][7][21]), .Cout(pp_matrix[1][7][22]));

    generate
        for (i = 0; i < 11; i++) begin
            fa fa1_i0(.a(pp_matrix[0][6][22+i]), .b(pp_matrix[0][7][22+i]), .c(pp_matrix[0][8][22+i]), .S(pp_matrix[1][6][22+i]), .Cout(pp_matrix[1][7][23+i]));
        end
    endgenerate

    assign pp_matrix[1][0] = pp_matrix[0][0];
    assign pp_matrix[1][1] = pp_matrix[0][1];
    assign pp_matrix[1][2] = pp_matrix[0][2];
    assign pp_matrix[1][3] = pp_matrix[0][3];
    assign pp_matrix[1][4] = pp_matrix[0][4];
    assign pp_matrix[1][5] = pp_matrix[0][5];
    assign pp_matrix[1][6][47 : 33] = pp_matrix[0][6][47 : 33];
    assign pp_matrix[1][6][21 : 0] = pp_matrix[0][6][21 : 0];
    assign pp_matrix[1][7][47 : 34] = pp_matrix[0][7][47 : 34];
    assign pp_matrix[1][7][20 : 0] = pp_matrix[0][7][20 : 0];

    //--- LEVEL 2 = 4 ---

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
        for (i = 0; i < 16; i++) begin
            ca ca2_i2(.x4(pp_matrix[1][4][18+i]), .x3(pp_matrix[1][5][18+i]), .x2(pp_matrix[1][6][18+i]), .x1(pp_matrix[1][7][18+i]), .Tin(T[0][18+i]), .S(pp_matrix[2][0][18+i]), .C(pp_matrix[2][3][19+i]), .Tout(T[0][19+i]));
            ca ca2_i3(.x4(pp_matrix[1][0][18+i]), .x3(pp_matrix[1][1][18+i]), .x2(pp_matrix[1][2][18+i]), .x1(pp_matrix[1][3][18+i]), .Tin(T[1][18+i]), .S(pp_matrix[2][1][18+i]), .C(pp_matrix[2][2][19+i]), .Tout(T[1][19+i]));
        end
    endgenerate
    
    generate
        for (i = 0; i < 2; i++) begin
            ca ca2_i3(.x4(pp_matrix[1][3][34+i]), .x3(pp_matrix[1][4][34+i]), .x2(pp_matrix[1][5][34+i]), .x1(pp_matrix[1][6][34+i]), .Tin(T[0][34+i]), .S(pp_matrix[2][1][34+i]), .C(pp_matrix[2][3][35+i]), .Tout(T[0][35+i]));
            ca ca2_i4(.x4(pp_matrix[1][0][34+i]), .x3(pp_matrix[1][1][34+i]), .x2(pp_matrix[1][2][34+i]), .x1(1'b0), .Tin(T[1][34+i]), .S(pp_matrix[2][0][34+i]), .C(pp_matrix[2][2][35+i]), .Tout(T[1][35+i]));
        end
    endgenerate

    ca ca2_1(.x4(pp_matrix[1][2][36]), .x3(pp_matrix[1][3][36]), .x2(pp_matrix[1][4][36]), .x1(pp_matrix[1][5][36]), .Tin(T[0][36]), .S(pp_matrix[2][1][36]), .C(pp_matrix[2][3][37]), .Tout(T[0][37]));
    fa fa2_0(.a(pp_matrix[1][0][36]), .b(pp_matrix[1][1][36]), .c(T[1][36]), .S(pp_matrix[2][0][36]), .Cout(pp_matrix[2][2][37]));


    generate
        for (i = 0; i < 2; i++) begin
            ca ca2_i5(.x4(pp_matrix[1][2][37+i]), .x3(pp_matrix[1][3][37+i]), .x2(pp_matrix[1][4][37+i]), .x1(pp_matrix[1][5][37+i]), .Tin(T[0][37+i]), .S(pp_matrix[2][1][37+i]), .C(pp_matrix[2][3][38+i]), .Tout(T[0][38+i]));
            ha ha2_i0(.a(pp_matrix[1][0][37+i]), .b(pp_matrix[1][1][37+i]), .S(pp_matrix[2][0][37+i]), .Cout(pp_matrix[2][2][38+i]));
        end
    endgenerate

    ca ca2_2(.x4(pp_matrix[1][1][39]), .x3(pp_matrix[1][2][39]), .x2(pp_matrix[1][3][39]), .x1(pp_matrix[1][4][39]), .Tin(T[0][39]), .S(pp_matrix[2][1][39]), .C(pp_matrix[2][3][40]), .Tout(T[0][40]));
    
    fa fa2_1(.a(pp_matrix[1][4][40]), .b(pp_matrix[1][3][40]), .c(T[0][40]), .S(pp_matrix[2][2][40]), .Cout(pp_matrix[2][3][41]));
    ha ha2_2(.a(pp_matrix[1][2][40]), .b(pp_matrix[1][1][40]), .S(pp_matrix[2][1][40]), .Cout(pp_matrix[2][2][41]));
    
    fa fa2_2(.a(pp_matrix[1][2][41]), .b(pp_matrix[1][3][41]), .c(pp_matrix[1][4][41]), .S(pp_matrix[2][1][41]), .Cout(pp_matrix[2][3][42]));
    ha ha2_3(.a(pp_matrix[1][0][41]), .b(pp_matrix[1][1][41]), .S(pp_matrix[2][0][41]), .Cout(pp_matrix[2][2][42]));


    generate
        for (i = 0; i < 3; i++) begin
            ha ha2_i2(.a(pp_matrix[1][2][42+i]), .b(pp_matrix[1][3][42+i]), .S(pp_matrix[2][1][42+i]), .Cout(pp_matrix[2][3][43+i]));
            ha ha2_i3(.a(pp_matrix[1][0][42+i]), .b(pp_matrix[1][1][42+i]), .S(pp_matrix[2][0][42+i]), .Cout(pp_matrix[2][2][43+i]));
        end
    endgenerate    

    ha ha2_4(.a(pp_matrix[1][1][45]), .b(pp_matrix[1][2][45]), .S(pp_matrix[2][1][45]), .Cout(pp_matrix[2][3][46]));

    assign pp_matrix[2][0][47 : 45] = pp_matrix[1][0][47 : 45];
    assign pp_matrix[2][0][40 : 39] = pp_matrix[1][0][40 : 39];
    assign pp_matrix[2][0][15 : 0] = pp_matrix[1][0][15 : 0];
    assign pp_matrix[2][1][47 : 46] = pp_matrix[1][1][47 : 46];
    assign pp_matrix[2][1][14 : 0] = pp_matrix[1][1][14 : 0];
    assign pp_matrix[2][2][47 : 46] = pp_matrix[1][2][47 : 46];
    assign pp_matrix[2][2][9 : 0] = pp_matrix[1][2][9 : 0];
    assign pp_matrix[2][3][47] = pp_matrix[1][3][47];
    assign pp_matrix[2][3][8 : 0] = pp_matrix[1][3][8 : 0];

    //--- LEVEL 3 = 2 ---
    ha ha3_0(.a(pp_matrix[2][1][3]), .b(pp_matrix[2][2][3]), .S(pp_matrix[3][1][3]), .Cout(pp_matrix[3][1][4]));


    generate
        for (i = 0; i < 2; i++) begin
            fa fa3_i0(.a(pp_matrix[2][0][4+i]), .b(pp_matrix[2][1][4+i]), .c(pp_matrix[2][2][4+i]), .S(pp_matrix[3][0][4+i]), .Cout(pp_matrix[3][1][5+i]));
        end
    endgenerate  

    assign T[2][6] = 1'b0;
    generate
        for (i = 0; i < 41; i++) begin
            ca ca3_0i(.x4(pp_matrix[2][0][6+i]), .x3(pp_matrix[2][1][6+i]), .x2(pp_matrix[2][2][6+i]), .x1(pp_matrix[2][3][6+i]), .Tin(T[2][6+i]), .S(pp_matrix[3][0][6+i]), .C(pp_matrix[3][1][7+i]), .Tout(T[2][7+i]));
        end
    endgenerate

    ca ca3_0(.x4(pp_matrix[2][0][47]), .x3(pp_matrix[2][1][47]), .x2(pp_matrix[2][2][47]), .x1(1'b0), .Tin(T[2][47]), .S(pp_matrix[3][0][47]), .C(), .Tout());

    assign pp_matrix[3][0][3 : 0] = pp_matrix[2][0][3 : 0];
    assign pp_matrix[3][1][2 : 0] = pp_matrix[2][1][2 : 0]; 

    assign dadda_out = pp_matrix[3][0] + pp_matrix[3][1];

endmodule