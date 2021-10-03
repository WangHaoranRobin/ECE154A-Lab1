
module zz_alu();

	reg [31:0] a, b, vectornum, errors, yexpected;
	reg [3:0] f;
	reg [3:0] zeroexpected;
	reg [103:0] testvectors[0:31];

	wire [31:0] y;
	wire zero;

	reg clk, reset;	

	alu DUT(.a(a), .b(b), .f(f[2:0]), .y(y), .zero(zero));

	always
		begin
			clk=1;
			#5;
			clk=0;
			#5;
		end

	initial
		begin
			$readmemh("alu.tv", testvectors);
			vectornum=0;
			errors=0;
			reset=1;
			#5;
			reset=0;	
		end

	always @(posedge clk)
		begin
			#1; {f[3:0], a[31:0], b[31:0], yexpected[31:0], zeroexpected[3:0]} = testvectors[vectornum];
		end
	always @(negedge clk)
		begin
			if(~reset) begin
				if(y !== yexpected) begin
					$display("Error: test type = %d inputs = %b, %b", f[2:0], a[31:0], b[31:0]);
					$display(" outputs = %b (%b expected)", y, yexpected);
					errors=errors+1; 	

					if(zero !== zeroexpected[0]) begin
						$display("Error: incorrect zero for inputs = %b, %b", a[31:0], b[31:0]);
						$display("%b expected, %b actual", zeroexpected[0], zero);
						errors=errors+1;	
					end	
				end

				vectornum = vectornum+1;

				if(testvectors[vectornum] === 104'bx) begin
					$display("%d tests completed with %d errors", vectornum, errors);
					$finish;
				end
			end
		end
endmodule