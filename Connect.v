module Connect(
	input wire clk, reset,
    	input wire a,b, 
    	//output [7:0] counter //To be used for simulation
	// output [7:0] sseg,
    output [3:0]an
    );
	 
	wire increment;
	wire decrement;
	wire sw0; 
	wire sw1;
	wire sw2;
	wire sw3;
	wire empty;
	wire alarm;
	wire emerg;
	wire [7:0] contador;
	  
                 //The Next 2 lines for simulation Only
	 //ParkingFinal PF (.a(a),.b(b),.clk(clk),.reset(reset),.increment(increment),.decrement(decrement));
	// Counter CNT (.clk(clk),.reset(reset),.increment(increment),.decrement(decrement),.q(counter));


	//  db_fsm DB1 (.sw(a),.db(sw0),.clk(clk),.reset(reset));
	//  db_fsm DB2 (.sw(b),.db(sw1),.clk(clk),.reset(reset));
   	Estacionamento EST (.sensor_ent(sw0),.sensor_sai(sw1),.clk(clk),.reset(reset),.increment(increment),.decrement(decrement));
	contador CNT (.clk(clk),.reset(reset),.inc(increment),.dec(decrement),.occupancy(contador), .vazio(empty));
	NivelDeAgua NDA (.vazio(empty),.w10mm(sw2),.w20mm(sw3),.clk(clk),.reset(reset),.alerta(alarm),.emergencia(emerg));

endmodule
