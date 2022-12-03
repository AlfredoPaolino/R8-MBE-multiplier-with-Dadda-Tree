module booth_encoder
    (
        input logic [3 : 0] y,
        output logic [4 : 0] BE_out
    );
    
        assign BE_out[0] = ~((y[0] ~^ y[1]) | (~(y[2] ~^ y[3])));
        assign BE_out[1] = ~(~((y[0] ~^ y[1])) | (y[1] ~^ y[2]));
        assign BE_out[2] = ~((y[0] ~^ y[1]) | (y[2] ~^ y[3]));
        assign BE_out[3] = ~(~(y[0] ~^ y[1]) | (~(y[1] ~^ y[2])) | (y[2] ~^ y[3]));   
        assign BE_out[4] = y[3];  

endmodule 

