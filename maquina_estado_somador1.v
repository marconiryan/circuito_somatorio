module maquina_estado_somador1(inicio, valor, clk, reset, pronto, overflow, soma);
	input [5:0] valor;
	input inicio, clk, reset;
	output reg pronto;
	output overflow;
	output reg [5:0] soma;
	
	reg [5:0] acumulador;
	reg [3:0] state;
	
	parameter S0 = 3'b000,
				 S1 = 3'b001, 
				 S2 = 3'b010,
				 S3 = 3'b011,
				 S4 = 3'b100,
				 S5 = 3'b101;
				 
	
	
	assign overflow = (valor[5]^acumulador[5]) ? 0: (soma[5]^valor[5]);
	
	
	
	
	initial begin
		state <= S0;
	end
	
	
	always @(posedge clk, posedge reset)begin
		if(reset == 1'b1) state <= S0;
		else begin
			case(state)
				S0: begin
						if(inicio == 1'b1) state <= S1;
						else state <= S0;
					end
				S1: begin state <= S2; end
				S2: begin state <= S3; end
				S3: begin state <= S4; end
				S4: begin state <= S5; end
				S5: begin state <= S1; end
			endcase
		end
	end
	
	always @(state)begin
		case(state)
			S0: begin
					pronto <= 1'b1;
					acumulador <= 0;
				end
				S1: begin
						pronto <= 1'b0;
					   acumulador <= acumulador + valor;
					 end
				S2: begin
					   acumulador <= acumulador + valor;
					 end
				S3: begin
					   acumulador <= acumulador + valor;
					 end
				S4: begin
					   acumulador <= acumulador + valor;
					 end
				S5: begin
						pronto <= 1'b1;
					 end
		endcase
	
	
	end
	
	

endmodule 
