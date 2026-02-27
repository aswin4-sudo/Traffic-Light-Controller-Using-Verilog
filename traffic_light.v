//traffic light controller 
module traffic_light(
//port declarations
//inputs
input wire[4:0] i_ns_count  	  	,
input wire[3:0] i_ew_count  	  	,
input wire[1:0]	yellow_count	  	,
input wire		ns_vehicle_detect 	,
input wire		ew_vehicle_detect 	,

//outputs
output reg		ns_red				,
output reg		ns_yellow			,
output reg		ns_green			,
output reg		ew_red				,
output reg		ew_yellow			,
output reg		ew_green			
);

//INITIALISATION
initial begin
	
	ns_red 		<= 1'b0;
	ns_yellow 	<= 1'b0;
	ns_green 	<= 1'b1;
	ew_red		<= 1'b1;
	ew_green	<= 1'b0;
	ew_yellow	<= 1'b0;

end

//NS controller
always @ (i_ns_count) begin
	
	if(i_ns_count == 31 & ew_vehicle_detect & ns_green) begin
	
		ns_red 		<= 1'b0;
		ns_yellow 	<= 1'b1;
		ns_green 	<= 1'b0;
		ew_red		<= 1'b1;
		ew_green	<= 1'b0;
		ew_yellow	<= 1'b0;
		
	end
end

//EW controller
always @ (i_ew_count) begin
	
	if(i_ew_count == 15 & ns_vehicle_detect & ew_green) begin
	
		ns_red 		<= 1'b1;
		ns_yellow 	<= 1'b0;
		ns_green 	<= 1'b0;
		ew_red		<= 1'b0;
		ew_yellow	<= 1'b1;
		ew_green	<= 1'b0;
	
	end
end

//yellow controller
always @ (yellow_count) begin
	
	if(yellow_count == 3 & ns_yellow) begin
	
		ns_red 		<= 1'b1;
		ns_yellow 	<= 1'b0;
		ns_green 	<= 1'b0;
		ew_red		<= 1'b0;
		ew_green	<= 1'b1;
		ew_yellow	<= 1'b0;
	
	end
	
	if(yellow_count == 3 & ew_yellow) begin
	
		ns_red 		<= 1'b0;
		ns_yellow 	<= 1'b0;
		ns_green 	<= 1'b1;
		ew_red		<= 1'b1;
		ew_green	<= 1'b0;
		ew_yellow	<= 1'b0;
	
	end
	
end

endmodule


// NS counter
module ns_count(

//port declarations
//inputs
input wire			i_clk	,	//input clock signal
output reg [4:0] 	o_count		//output counter
);

//INITIALIZATION
initial
	o_count = 0;
always @ (negedge i_clk )
	o_count[0] <= ~o_count[0];
	
always @ (negedge o_count[0])
	o_count[1] <= ~o_count[1];

always @ (negedge o_count[1])
	o_count[2] <= ~o_count[2];

always @ (negedge o_count[2])
	o_count[3] <= ~o_count[3];

always @ (negedge o_count[3])
	o_count[4] <= ~o_count[4];

endmodule


//EW controller
module ew_count(

//port declarations
//inputs
input wire			i_clk	,	//input clock signal
output reg [3:0] 	o_count		//output counter
);

//INITIALIZATION
initial
	o_count = 0;

always @ (negedge i_clk)
	o_count[0] <= ~o_count[0];
	
always @ (negedge o_count[0])
	o_count[1] <= ~o_count[1];

always @ (negedge o_count[1])
	o_count[2] <= ~o_count[2];

always @ (negedge o_count[2])
	o_count[3] <= ~o_count[3];

endmodule


//yellow controller
module yellow_count(

//port declarations
//inputs
input wire			i_clk	,	//input clock signal
output reg [1:0] 	o_count		//output counter
);

//INITIALIZATION
initial
	o_count = 0;

always @ (negedge i_clk)
	o_count[0] <= ~o_count[0];
	
always @ (negedge o_count[0])
	o_count[1] <= ~o_count[1];

endmodule
