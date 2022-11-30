`timescale 1ns/100ps

/* O módulo seguinte tem o intuito de conectat as respectivas
saídas e entradas de cada módulo, tornando o circuito funcional de fato */

module Connect; 

	reg clk_t, rst_t, w10mm_t, w20mm_t, ent_t, sai_t;
	wire alerta_t, emerg_t, vazio_t, inc_t, dec_t;
	wire [5:0] ocup_t;
	
	sistema est (.sensor_ent(ent_t), .sensor_sai(sai_t), .clk(clk_t), .reset(rst_t), .increment(inc_t), .decrement(dec_t));
	contador cnt (.clk(clk_t) , .reset(rst_t) , .occupancy(ocup_t), .vazio(vazio_t), .inc(inc_t), .dec(dec_t));
	NivelDeAgua nda (.vazio(vazio_t), .w10mm(w10mm_t), .w20mm(w20mm_t), .clk(clk_t), .rst(rst_t), .alerta(alerta_t), .emergencia(emerg_t));
	
/* Abaixo segue o testbench*/

/* As entradas podem ser alteradas como se desejar, assim como os intervalos
de tempo entre cada mudança. Mudanças com o mesmo ciclo de clk não são
recomendadas, pois pode-se acabar perdendo o sinal durante a simulação. Além
de que, na prática, nenhum carro iria ultrapassar o sensor em 5ns */

	initial begin
		
		clk_t = 0;
		rst_t = 1;
		w10mm_t = 0;
		w20mm_t = 0;
		ent_t = 0;
		sai_t = 0;
	
		
		#10
		
		rst_t = 0;
		
		#150
		
		rst_t = 1;
		
		#30
		
		ent_t =1;
		
		#15
		
		ent_t = 0;
		
		#30
		
		ent_t =1;
		
		#15
		
		ent_t = 0;
		
		#30
		
		ent_t =1;
		
		#15
		
		ent_t = 0;
		
		#30
		
		ent_t =1;
		
		#15
		
		ent_t = 0;
		#30
		
		ent_t =1;
		
		#15
		
		ent_t = 0;
		#30
		
		ent_t =1;
		
		#15
		
		ent_t = 0;
		#30
		
		ent_t =1;
		
		#15
		
		ent_t = 0;
		#30
		
		ent_t =1;
		
		#15
		
		ent_t = 0;
		#30
		
		ent_t =1;
		
		#15
		
		ent_t = 0;
		
		#30
		
		ent_t =1;
		
		#15
		
		ent_t = 0;
		
		#30
		
		ent_t =1;
		
		#15
		
		ent_t = 0;
		
		#30
		
		sai_t = 1;
		
		#15
		
		sai_t = 0;
		
		#30
		
		sai_t = 1;
		
		#15
		
		sai_t = 0;
		
		w10mm_t = 1;
		
		#80
		
		sai_t = 1;
		
		w20mm_t = 1;
		
		#15
		
		sai_t = 0;
		
		#30
		
		w20mm_t = 1;
		
		sai_t = 1;
		
		#15 
		
		sai_t = 0;
		
		#30
		
		sai_t = 1;
		
		#15 
		
		sai_t = 0;
		
		#30
		
		sai_t = 1;
		
		#15 
		
		sai_t = 0;
		
		#30
		
		sai_t = 1;
		
		#15 
		
		sai_t = 0;
		
		#30
		
		sai_t = 1;
		
		#15 
		
		sai_t = 0;
		
		#30
		
		sai_t = 1;
		
		#15 
		
		sai_t = 0;
		
		#30
		
		sai_t = 1;
		
		#15 
		
		sai_t = 0;
		
		#30
		
		sai_t = 1;
		

		#15
		
		sai_t =0;
		
		#1000
		
		w20mm_t = 0;
		
		#150
		
		w10mm_t = 0;
		
		#200
		
		$stop;
		
		
	end
	
	always #5 clk_t = ~clk_t;
	
endmodule