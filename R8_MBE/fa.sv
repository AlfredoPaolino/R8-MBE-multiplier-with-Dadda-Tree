module fa
    (
    input a, b, c,
    output S, Cout
    );
    
    assign S = a^b^c;
    assign Cout = (a&b) | (a&c) | (c&b);

endmodule