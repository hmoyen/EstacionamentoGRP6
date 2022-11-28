 module NivelDeAgua(
    input vazio,
    input w10mm,
    input w20mm,
    input clk,
    input reset,
    output reg alerta,
    output reg emergencia
    );

 localparam [1:0]
			idle = 3'b000,
			s1 = 3'b001,
			s2 = 3'b010,
			invalid =3'b111;
			
			reg[2:0] state_reg,state_next;
			initial begin
			state_reg = 0;			//INICIALIZANDO COMO 0
			state_next = 0;
			end
			
			always@(posedge clk, posedge reset)
				begin
				if (reset)
					state_reg <= idle;
				else
					state_reg <= state_next;
				end
				
				//MAQUINA DE ESTADO
				
				always@*
				begin
					alerta <= 0 ; // default value for inc going to the clock is 0 unless triggered
					emergencia <= 0 ; // default value for dec going to the clock is 0 unless triggered
					
					case(state_reg)
		         //estado inicial 
						idle:
							if(w10mm&~w20mm) // agua subiu ao nivel 10mm no estacionamento
								state_next <= s1;
							else if (~w10mm&w20mm) //invalido, impossivel de acontecer, primeiro ativa-se sempre o sensor w10mm
								state_next <= ;
							else if (~w10mm&~w20mm) //nivel normal de agua no estacionamento
								state_next<=idle;
			// se os dois sensores forem ativados ao mesmo temp (partindo do estado inicial), eh invalido
							else if (w10mm&w20mm) 
								state_next <= invalid;
						s1:
							if(a&b) // dois sensores ativados, ou seja, a agua subiu ao nivel de 20 mm
                                    // deve-se esvaziar o estacionamento
                                begin 
                                    alerta <= 1; // alerta para os clientes retirarem os carros
								    state_next <= s2;
                                end 
							else if(~w10mm&~w20mm) // sensor w10mm não mais acionado, ou seja, o nivel esta abaixo de 10mm de novo
								state_next <= idle;
							else if (w10mm&~w20mm) // nivel continua acima de 10mm, mas não ultrapassou 20mm
								state_next<=s1;
						s2:
							if(~w10mm&w20mm) // impossivel de acontecer, invalido
								state_next <= invalid;
							else if(w10mm&~w20mm) // nivel desceu para abaixo de 20mm
								state_next <= s1; // backing off!!
							else if(w10mm&w20mm)
                                begin 
                                    emergencia <=1; // depois, vai analisar se eh possivel fechar o estacionamento, para esvaziá-lo de água
								    state_next <= s2; //continua alto, segue no estado de emergencia
                                end
						
					endcase
				end
		 endmodule