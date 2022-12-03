module ca
    (
    input logic x4, x3, x2, x1, Tin,
    output logic Tout, C, S
    );

    logic fa0_out;

    fa fa_0(.a(x4), .b(x3), .c(x2), .S(fa0_out), .Cout(Tout));
    fa fa_1(.a(fa0_out), .b(x1), .c(Tin), .S(S), .Cout(C));

endmodule