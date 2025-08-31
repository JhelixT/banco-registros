module registerBank (
    input wire clk,
    input wire we,
    input wire [2:0] write_addr,
    input wire [2:0] read_addr,
    input wire [7:0] write_data,
    output reg [7:0] read_data
);

    // Banco de 8 registros de 8 bits
    reg [7:0] registers [0:7];

    // Escritura síncrona
    //Se activa solo en el flanco de subida del reloj.
    always @(posedge clk) begin
        if (we) //si we esta actuvo(1)
            registers[write_addr] <= write_data;
    end

    always @(*) begin
        read_data = registers[read_addr];
    end

endmodule