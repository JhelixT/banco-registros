`timescale 1ns/1ps
`include "registerBank.v"

module registerBank_tb;
    reg clk;
    reg we;
    reg [2:0] write_addr;
    reg [2:0] read_addr;
    reg [7:0] write_data;
    wire [7:0] read_data;

    registerBank uut (
        .clk(clk),
        .we(we),
        .write_addr(write_addr),
        .read_addr(read_addr),
        .write_data(write_data),
        .read_data(read_data)
    );

    // Generación de reloj
    always #5 clk = ~clk;

    initial begin
        $dumpfile("registerBank.vcd");
        $dumpvars(0, registerBank_tb);
 
        clk = 0;
        we = 0;
        write_addr = 0;
        read_addr = 0;
        write_data = 0;
        #10;

        // Escribir en registro 3
        we = 1;
        write_addr = 3;
        write_data = 8'hAA;
        #10;

        // Leer registro 3
        we = 0;
        read_addr = 3;
        #10;

        // Intentar escribir sin WE
        // no deberia escribirse
        we = 0;
        write_addr = 5;
        write_data = 8'h55;
        #10;

        // Leer registro 5 (debe ser 0)
        read_addr = 5;
        #10;

        // Escribir de vuelta en registro 5 con WE
        // si deberia escribirse
        we = 1;
        write_addr = 5;
        write_data = 8'h55;
        #10;

        // Leer registro 5 (debe ser 55)
        we = 0;
        read_addr = 5;
        #10;

        // Leer y Escribir un mismo registro
        we = 1;
        read_addr = 5;
        write_addr = 5;
        write_data = 8'hA3;
        #10;

        $finish;
    end

endmodule