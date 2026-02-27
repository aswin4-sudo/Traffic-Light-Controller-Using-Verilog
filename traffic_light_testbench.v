`timescale 1ns / 1ps
module Traffic_tb;

//internal wire/reg
wire [4:0] i_ns_count   ;
wire [3:0] i_ew_count   ;
wire [1:0] yellow_count ;
reg         clk         ;

//inputs
reg   ns_vehicle_detect ;
reg   ew_vehicle_detect ;

//outputs
wire        ns_red      ;
wire        ns_yellow   ;
wire        ns_green	;
wire        ew_red      ;
wire        ew_yellow   ;
wire        ew_green    ;

//initial block
initial begin
    clk = 1'b0                  ;
    ns_vehicle_detect = 1'b0    ;
    ew_vehicle_detect = 1'b1    ;
    
    $display("   NS      |     EW   ");
    $display("R   Y   G     R   Y   G");
    $monitor("%h %h  %h    %h  %h  %h",ns_red ,ns_yellow ,ns_green ,ew_red ,ew_yellow ,ew_green);
    #1000 $finish;
end 

//clock generation
always
    #5 clk = ~clk   ;
    //test case2
always@(clk) begin
    if($time % 21 == 0) begin
        ns_vehicle_detect = ~ns_vehicle_detect ;
        ew_vehicle_detect = ~ew_vehicle_detect ;
    end
end


//instansiation

//Traffic core
traffic_light CORE(
//input
.i_ns_count             (i_ns_count)        ,
.i_ew_count             (i_ew_count)        ,
.yellow_count	  	    (yellow_count)      ,
.ns_vehicle_detect      (ns_vehicle_detect) ,
.ew_vehicle_detect      (ew_vehicle_detect) ,
//output
.ns_red                 (ns_red)            ,			
.ns_yellow              (ns_yellow)         ,
.ns_green	            (ns_green)          ,
.ew_red                 (ew_red)            ,
.ew_yellow              (ew_yellow)         ,
.ew_green               (ew_green) 
);

//north south counter
ns_count i_NS_count_0(
.i_clk                  (clk),
.o_count                (i_ns_count)
);

//east west counter
ew_count i_EW_count_0(
.i_clk                  (clk),
.o_count                (i_ew_count)
);

//yellow counter
yellow_count i_Yellow_count_0(
.i_clk                  (clk),
.o_count                (yellow_count)
);
endmodule
