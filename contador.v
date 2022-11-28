module counter(
 
   input wire clk, reset,
 
   input wire inc, dec,
   
   output reg [5:0] occupancy,

   output vazio,
  
  );
	
	
	
reg [5:0] count = 6'b000000;
	
	always@(posedge clk) begin

		if (reset)
		
	count <= 6'b000000;
		
else if (inc)
			
count <= count + 1'b1;
		
else if (dec)
			
count <= count - 1'b1;

	end
	
	
always @* begin
	
	occupancy = count;

	if (occupancy == 6'b000000)
	
		vazio <= 1;

	
end
	

endmodule
