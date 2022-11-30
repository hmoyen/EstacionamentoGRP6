//O seguinte codigo contem três módulos: contador, NivelDeAgua e sistema

/*O módulo sistema é o que monitora os carros que entram e saem do estacionamento. Tem
como entrada, além de clk (clock) e reset, dois sensores: sensor_ent (da entrada 
do estabelecimento) e sensor_sai (da saída do estabelecimento). Como saídas do módulo,
temos increment (é 1 quando um carro entrou e nenhum saiu) e decrement (é 1 quando um carro
saiu e nenhum entrou). */

module sistema(

    input sensor_ent, // sensor na entrada
	 
    input sensor_sai, // sensor na saída
	 
    input wire clk,
	 
    input wire reset,
	 
    output reg increment, // 1, quando carro entrou
	 
    output reg decrement // 1, quando carro saiu

    );
	 
	 reg[1:0] state;
	 
	 //codificação dos estados
	 
	 parameter 
				   normal = 2'b00,
					entra = 2'b01,
					sai = 2'b10;
					
	// condição inicial
	
	initial begin
		state <= normal;
	end
	
	always@(negedge clk, negedge reset) begin
	
	
		if(reset == 1'b0) state <= normal;
		
		else begin
			case(state) // máquina de estado simples para monitorar os carros que entram e saem
			
				normal: begin // estado normal, nenhum entrou ou saiu
				
					if(sensor_ent == 1'b1 && sensor_sai == 1'b0) state <= entra; // se entrar, vai para o estado "entra"
					
					else if (sensor_sai == 1'b1 && sensor_ent == 1'b0) state <= sai; // se sair, vai para o estado "sai"
					
					else state <= normal; // se nenhum sensor for ativado ou dois forem ativados simultaneamente, não precisamos modificar o número de carros
					
				end
				
				entra: begin
					
					state<=normal;
				
					
				end
				
				sai: begin
					
					state<=normal;
				
				end
			endcase
		end
	end
	 
// saídas que serão passadas para o módulo do contador

always @(state) begin

	case(state)
	
		normal: begin
			increment = 1'b0;
			decrement = 1'b0;
			end
		entra: begin
			increment = 1'b1;
			decrement = 1'b0;
			end
		sai: begin
			increment = 1'b0;
			decrement = 1'b1;
			end
			
		endcase
		
end
	
endmodule


/*O modulo contador recebe como entrada clk (clock) e reset (para resetar o sistema)*/

/*Alem disso, temos a entrada inc que esta conectada com a saida increment do modulo sistema. 
Ou seja, ao entrar um carro, saberemos que deve-se somar 1 no contador. O mesmo ocorre para a
entrada dec que está conectada com a saída decrement do modulo sistema. Como saida do módulo,
temos a variável vazio que é 1 quando o estacionamento está vazio e a variável occupancy, que 
indica quantos carros há no estacionamento. */

module contador(clk, reset, occupancy, vazio, inc, dec);

// declarando as entradas e saídas

 
   input wire clk, reset;
 
   input wire inc, dec; // conectadas ao módulo sistema
   
	output reg [5:0] occupancy; 

   output reg vazio; // conectada ao módulo NivelDeAgua
	
	reg empty = 1'b1;

	reg [5:0] count = 6'b000000; // variável que armazenará o número de carros
	reg [5:0] count1 = 6'b111111;	// variável que armazenará quantas vagas livres há
	
	// contador comum que é atualizado a cada ciclo de clock
		
	always@(posedge clk) begin

		if (reset == 1'b0) 
			
			count <= 6'b000000;
		
		// define número de carros como 0, caso reset seja 0. O padrão para reset é 1.
			
		else if (inc) begin
				
			count <= count + 1'b1;
			
			empty <=1'b0; // estacionamento não está vazio, já que somamos 1 no contador
			
		end
			
		else if (dec) begin
		
			if (count == 6'b000001) empty <= 1'b1; // se a ocupação for 0, o estacionamento está vazio
		
			count <= count - 1'b1; // subtrai 1 do contador
			
			
			end
			

	end
		
		
	always @* begin
	
	
		occupancy = count; // passa o valor do contador para a saída occupancy
	
		count1 = 6'b111111 - count;
		
		$display("Vagas ocupadas: %d  Vagas livres: %d", occupancy, count1);
		
		vazio = empty; // passa o valor do empty para a saída vazio

		
	end
		

endmodule 


/*O módulo NivelDeAgua monitora o nível de alagamento do estacionamento. 
Recebe como entrada clk (clock) e rst (reset) também. Além disso, recebe
dois sensores w10mm (sensor que mede nível de água de 10mm) e w20mm (sensor 
que mede nível de água de 20mm) e recebe "vazio" do módulo contador. Como saída,
temos o sinal de "alerta", que indica que os clientes devem remover os carros
do estacionamento, e o sinal "emergencia", que indica que o estacionamento está 
fechado para escoamento de água */

module NivelDeAgua(

    input vazio, // conectada ao contador
	 
    input w10mm, // sensor 10 mm de agua
	 
    input w20mm, // sensor 20 mm de agua
	 
    input wire clk,
	 
    input wire rst,
	 
    output reg alerta, // alerta para retirar carros
	 
    output reg emergencia // estado de emergencia para fechar estacionamento
    );
	 
	 reg[1:0] state;
	 
	 //codificacao dos estados
	 
	 parameter 
				  init = 2'b00,
					s1 = 2'b01,
					s2 = 2'b10;
					
	// condicao inicial
	
	initial begin
		state <= init;
	end
	
	always@(negedge clk, negedge rst) begin
	
	
		if(rst == 1'b0) state <= init; // volta ao estado inicial com reset = 0
		
		else begin
		
			case(state) // maquina de estado que monitora o nivel da agua
			
				init: begin // estado normal, nenhum sensor acionado
				
					if(w10mm == 1'b1) state <= s1; // se nível subir para 10mm, sensor w10mm é ativado e passa-se para o estado s1 de alerta
					
					else begin
						
						$display("Estacionamento aberto."); // caso nenhum sensor seja ativado, continua-se na normalidade
						
						state <= init;
						
					
					end
				end
				
				
				s1: begin
				
					$display("Clientes devem remover carros do estacionamento. Risco de alagamento");
				
					if(w20mm == 1'b1 && vazio == 1'b1) state <=s2; // se o nivel subir para 20mm, o sensor w20mm é ativado. Caso o estacionamento esteja vazio, pode-se fechá-lo e começar as ações de escoamento de emergência.
					
					else if (w10mm == 1'b0) state <=init; // se o nível de água descer, volta-se ao estado normal
					
					else state <= s1; // caso contrário, continua-se em alerta para alagamento
					
				end
				
				s2: begin
				
					if(w20mm == 1'b1 && vazio == 1'b1) begin // continua em estado de emergência (s2)
					
						state <= s2;
						
						$display("Estacionamento fechado.");
						
						end
						
					else if(w20mm == 1'b0 && w10mm == 1'b0) 
					
						state <= init; // quando o nível de água desce, volta a abrir o estacionamento
						
					else if (vazio == 1'b0) state <=s1; // se o estacionamento não estiver vazio, não pode-se fechá-lo. Então, volta-se para estado de alerta para retirar os carros.
					
					else state <= s2; // caso contrário, continua-se em estado de emergência
				
				end
			endcase
		end
	end
	 
// descrição das saídas

	always @(state) begin

		case(state)
		
			init: begin
				alerta = 1'b0;
				emergencia = 1'b0;
				end
			s1: begin
				alerta = 1'b1;
				emergencia = 1'b0;
				end
			s2: begin
				alerta = 1'b0;
				emergencia = 1'b1;
				end
				
			endcase
			
	end
	
endmodule
