module alu(input [31:0] a, 
	input [31:0]b,
	input [2:0] f,
	output [31:0] y,
	output zero);

wire[31:0] reg1, reg2;
reg[31:0] reg2n, reg2bn, tmp;
reg[31:0] reg3;


assign reg1 = a;
assign reg2 = b;
assign y = reg3;
assign zero = !y;

always @(f or reg1 or reg2) begin
    if (f[2]) begin
        reg2n = ~reg2 + 1;
        reg2bn = ~reg2;
    end else begin
 	reg2n = reg2;
	reg2bn = reg2;
    end
	tmp = reg1 + reg2n;
    case (f[1:0])
        2'b00: reg3 = reg1 & reg2bn;
        2'b01: reg3 = reg1 | reg2bn;
        2'b10: reg3 = reg1 + reg2n;
        2'b11: reg3 = {31'b0, tmp[31]};
    endcase
end


endmodule
