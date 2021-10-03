module alu(input [31:0] a, b
	input [2:0] f,
	output [31:0] y
	output zero);

wire reg1, reg2;
reg reg3;

assign reg1 = a;
assign reg2 = b;
assign reg2n = reg1;
assign reg3 = y;

always @(f or reg1 or reg2) begin
    if (f[2]) begin
        reg2 = ~reg2 + 1b'1;
        reg2n = ~reg2;
    end
    y = 8b'00000000;
    case (f[1:0])
        2b'00: y = reg1 & reg2n;
        2b'01: y = reg1 | reg2n;
        2b'10: y = reg1 + reg2;
        2b'11: y[0] = (reg1 + reg2)[31];
    endcase
end

endmodule