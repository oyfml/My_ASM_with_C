`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.11.2016 20:55:22
// Design Name: 
// Module Name: mux_2_to_4_LED
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux_2_to_4_LED(
    input SLOW_CLOCK,
    input PB_UP,
    input PB_DOWN,
    input SW6,
    input SW7,
    input SW14,
    input INPUT1,
    input INPUT2,
    input INPUT3,
    input INPUT4,
    output Z
    );
    
    reg [1:0] select = 2'b00;
    
    always @ (posedge SLOW_CLOCK)
    begin
    if(SW6 == 0 && SW7 == 0)
    begin
        select = (SW14 == 1 && PB_UP == 1 && select != 3) ? select + 1 :
                    ((SW14 == 1 && PB_DOWN == 1 && select != 0) ? select - 1 : select);
    end
    end
      
    assign Z = (select==2'b00) ? INPUT1 : (select==2'b01) ? INPUT2: (select==2'b10) ? INPUT3 : INPUT4;
    assign SELECT_OUTPUT = select;
endmodule
