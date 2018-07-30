`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.11.2016 10:37:08
// Design Name: 
// Module Name: mux_2_to_4
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


module mux_2_to_4(
    input SLOW_CLOCK,
    input PB_UP,
    input PB_DOWN,
    input SW6,
    input SW7,
    input SW14,
    input [11:0] INPUT1,
    input [11:0] INPUT2,
    input [11:0] INPUT3,
    input [11:0] INPUT4,
    output [11:0] Z,
    output [1:0] SELECT_OUTPUT
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
