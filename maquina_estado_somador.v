// Simplificado
module maquina_estado_somador(inicio, valor, clk, reset, pronto, overflow, soma,contador);
	input [5:0] valor;
	input inicio, clk, reset;
	output reg pronto;
	output overflow;
	output reg [5:0] soma, contador;
	
	reg [5:0] acumulador;
	reg [2:0] state;
	
	parameter S0 = 2'b000,
				 S1 = 2'b001, 
				 S2 = 2'b010,
				 S3 = 2'b011;
				 
	
	
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
				S1: begin
					if(contador != 0) state <= S2; 
					else state <= S3;
					
				end
				S2: begin state <= S1; end
				S3: begin state <= S0; end
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
					 end
				S2: begin
						pronto <= 1'b0;
					   acumulador <= acumulador + valor;
						contador <= contador -1;
					 end
				S3: begin
						pronto <= 1'b1;
					 end
		endcase
	
	
	end
	
	

endmodule 
