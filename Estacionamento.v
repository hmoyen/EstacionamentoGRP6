module Estacionamento(
    input sensor_ent,
    input sensor_sai,
    input clk,
    input reset,
    output reg increment,
    output reg decrement
);

increment <= 0 ; // default value for inc going to the clock is 0 unless triggered
decrement <= 0 ;

always@(posedge clk) begin

		if (reset)

            increment <= 0 ; // default value for inc going to the clock is 0 unless triggered
            decrement <= 0 ;

        else if (sensor_ent&~sensor_sai)

            increment<=1;

        else if(~sensor_ent&sensor_sai)

            decrement<=1;
        
    end

endmodule




