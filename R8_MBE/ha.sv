module ha
    (
        input logic a, b,
        output logic S, Cout
    );

    assign S = a^b;
    assign Cout = a&b;

endmodule